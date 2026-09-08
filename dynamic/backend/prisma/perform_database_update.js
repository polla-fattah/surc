const { PrismaClient } = require('@prisma/client');
const fs = require('fs');
const path = require('path');

const prisma = new PrismaClient();

function normalizeText(text) {
  if (!text) return '';
  return text
    .replace(/[^\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\w]/g, '')
    .trim();
}

async function main() {
  console.log('===========================================================');
  console.log('  UPDATING EVENT DATES IN DATABASE FROM posts_updated.txt  ');
  console.log('===========================================================\n');

  const postsTxtPath = path.resolve(__dirname, '../../../posts_updated.txt');
  if (!fs.existsSync(postsTxtPath)) {
    console.error(`Error: posts_updated.txt not found at ${postsTxtPath}`);
    return;
  }

  const postsData = JSON.parse(fs.readFileSync(postsTxtPath, 'utf8'));
  const posts = postsData.posts; // 174 posts

  console.log(`Loaded ${posts.length} posts from posts_updated.txt.`);

  // Build photo ID and description index maps
  const photoIdToPost = new Map();
  const postsList = [];

  for (const post of posts) {
    const targetDateStr = post.published_at || post.date;
    const postObj = {
      id: post.id,
      facebook_post_id: post.facebook_post_id,
      published_at: post.published_at,
      date: post.date,
      targetDate: new Date(targetDateStr),
      description: post.description || '',
      normDesc: normalizeText(post.description || ''),
      main_image: post.main_image,
      images: post.images || []
    };
    postsList.push(postObj);

    // Map photo IDs from main_image and images array
    if (post.images && Array.isArray(post.images)) {
      for (const img of post.images) {
        if (img.facebook_photo_id) {
          photoIdToPost.set(String(img.facebook_photo_id), postObj);
        }
        if (img.path) {
          const basename = path.basename(img.path).split('.')[0];
          photoIdToPost.set(basename, postObj);
        }
      }
    }
    if (post.main_image) {
      const basename = path.basename(post.main_image).split('.')[0];
      photoIdToPost.set(basename, postObj);
    }
  }

  const dbEvents = await prisma.event.findMany({
    orderBy: { id: 'asc' }
  });

  console.log(`Loaded ${dbEvents.length} events from PostgreSQL database.\n`);

  let updatedCount = 0;
  let skippedCount = 0;
  const updateLog = [];

  for (const event of dbEvents) {
    let matchedPost = null;
    let matchMethod = '';

    // 1. Try Main Image Photo ID match
    if (event.image) {
      const imgBasename = path.basename(event.image).split('.')[0];
      if (photoIdToPost.has(imgBasename)) {
        matchedPost = photoIdToPost.get(imgBasename);
        matchMethod = `Main Image (${imgBasename})`;
      }
    }

    // 2. Try Gallery Image Photo ID match
    if (!matchedPost && event.galleryImages && Array.isArray(event.galleryImages)) {
      for (const gImg of event.galleryImages) {
        const gBasename = path.basename(gImg).split('.')[0];
        if (photoIdToPost.has(gBasename)) {
          matchedPost = photoIdToPost.get(gBasename);
          matchMethod = `Gallery Image (${gBasename})`;
          break;
        }
      }
    }

    // 3. Try Normalized Substring Match
    if (!matchedPost) {
      const eventNormTitle = normalizeText(event.title || '');
      const eventNormDesc = normalizeText(event.description || '');

      if (eventNormTitle.length >= 15 || eventNormDesc.length >= 15) {
        for (const p of postsList) {
          if (!p.normDesc) continue;
          
          const titleSub = eventNormTitle.substring(0, 25);
          const descSub = eventNormDesc.substring(0, 25);

          if ((titleSub.length >= 15 && p.normDesc.includes(titleSub)) ||
              (descSub.length >= 15 && p.normDesc.includes(descSub))) {
            matchedPost = p;
            matchMethod = `Description Overlap`;
            break;
          }
        }
      }
    }

    if (matchedPost) {
      const newDate = matchedPost.targetDate;

      await prisma.event.update({
        where: { id: event.id },
        data: {
          eventDate: newDate
        }
      });

      updatedCount++;
      updateLog.push({
        id: event.id,
        slug: event.slug,
        title: event.title.substring(0, 45),
        oldDate: event.eventDate.toISOString(),
        newDate: newDate.toISOString(),
        matchMethod
      });
    } else {
      skippedCount++;
    }
  }

  console.log(`-----------------------------------------------------------`);
  console.log(`  DATABASE UPDATE SUMMARY`);
  console.log(`-----------------------------------------------------------`);
  console.log(`Total Events in Database : ${dbEvents.length}`);
  console.log(`Events Updated          : ${updatedCount}`);
  console.log(`Events Unmatched/Skipped: ${skippedCount} (Demo / Template events)`);
  console.log(`-----------------------------------------------------------\n`);

  console.log('Sample of updated records in database:');
  updateLog.slice(0, 15).forEach(item => {
    console.log(`[ID ${item.id}] ${item.title}`);
    console.log(`   Old: ${item.oldDate} -> NEW: ${item.newDate} (${item.matchMethod})`);
  });

  // Verify directly from Database
  console.log('\n--- VERIFYING UPDATED DATES DIRECTLY FROM POSTGRESQL ---');
  const verifyEvents = await prisma.event.findMany({
    where: {
      id: { gte: 239 }
    },
    orderBy: { eventDate: 'desc' },
    take: 10
  });

  console.log('Top 10 Latest Facebook Events in Database after update:');
  verifyEvents.forEach(e => {
    console.log(`[ID ${e.id}] Date: ${e.eventDate.toISOString()} | Title: ${e.title.substring(0, 50)}`);
  });
}

main()
  .catch(err => {
    console.error('Database update failed:', err);
  })
  .finally(() => prisma.$disconnect());
