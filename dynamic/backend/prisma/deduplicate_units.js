const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log('--- DEDUPLICATING RESEARCH UNITS IN POSTGRESQL ---');

  // Mapping from old/duplicate IDs to canonical IDs:
  const idMap = {
    'data-analysis-and-ai': 'data-analysis-ai',
    'unit-data-analysis': 'data-analysis-ai',
    'development-and-cooperation': 'development-cooperation',
    'unit-collaboration-partnerships': 'development-cooperation',
    'unit-environmental-studies': 'emccu'
  };

  // 1. Ensure canonical units exist
  const canonicalUnits = [
    {
      id: 'emccu',
      title: 'Environmental Monitoring & Climate Change Unit',
      name: 'Environmental Monitoring & Climate Change Unit (EMCCU)',
      image: '/images/labs/lab-agriculture.svg',
      description: 'Leading research in regional environmental monitoring, climate change impact assessment, air and water quality analytics, and GIS spatial modeling across Kurdistan.'
    },
    {
      id: 'data-analysis-ai',
      title: 'Data Analysis and AI Unit',
      name: 'Data Analysis and AI Unit',
      image: '/images/labs/lab-engineering.svg',
      description: 'Pioneering computational research in artificial intelligence, deep learning, temporal data mining, medical image classification, and Kurdish natural language processing (NLP).'
    },
    {
      id: 'development-cooperation',
      title: 'Development & Cooperation Unit',
      name: 'Development & Cooperation Unit',
      image: '/images/labs/lab-chemistry.svg',
      description: 'Coordinates international research grants, multi-institutional university collaborations, industrial technology transfer, and evidence-based policy outreach.'
    },
    {
      id: 'unit-agriculture',
      title: 'Agriculture Research Unit',
      name: 'Agriculture Research Unit',
      image: '/images/labs/lab-agriculture.svg',
      description: 'Conducts practical applied agricultural research, crop science studies, soil quality analytics, and aquaculture research.'
    },
    {
      id: 'unit-biology-life-sciences',
      title: 'Biology & Life Sciences Unit',
      name: 'Biology & Life Sciences Unit',
      image: '/images/labs/lab-biology.svg',
      description: 'Focuses on biomedical research, molecular genetics, microbiology, parasitology, and occupational bio-monitoring.'
    },
    {
      id: 'unit-chemistry',
      title: 'Chemistry & Materials Unit',
      name: 'Chemistry & Materials Unit',
      image: '/images/labs/lab-chemistry.svg',
      description: 'Specializes in analytical chemistry, spectrophotometry, heavy metal bio-remediation, and environmental chemical analytics.'
    },
    {
      id: 'unit-social-sciences-humanities',
      title: 'Social Sciences & Humanities Unit',
      name: 'Social Sciences & Humanities Unit',
      image: '/images/labs/lab-engineering.svg',
      description: 'Promotes interdisciplinary studies in humanities, social phobia biomonitoring, educational methods, and regional cultural preservation.'
    }
  ];

  for (const u of canonicalUnits) {
    await prisma.researchUnit.upsert({
      where: { id: u.id },
      update: u,
      create: u
    });
  }

  // 2. Re-point Staff, Projects, Publications to Canonical IDs
  for (const [oldId, newId] of Object.entries(idMap)) {
    const updatedStaff = await prisma.staff.updateMany({
      where: { unitId: oldId },
      data: { unitId: newId }
    });
    if (updatedStaff.count > 0) {
      console.log(`Re-pointed ${updatedStaff.count} staff records from "${oldId}" -> "${newId}"`);
    }

    const updatedProjects = await prisma.project.updateMany({
      where: { unitId: oldId },
      data: { unitId: newId }
    });
    if (updatedProjects.count > 0) {
      console.log(`Re-pointed ${updatedProjects.count} projects from "${oldId}" -> "${newId}"`);
    }

    const updatedPubs = await prisma.publication.updateMany({
      where: { unitId: oldId },
      data: { unitId: newId }
    });
    if (updatedPubs.count > 0) {
      console.log(`Re-pointed ${updatedPubs.count} publications from "${oldId}" -> "${newId}"`);
    }
  }

  // 3. Delete non-canonical duplicate units
  for (const oldId of Object.keys(idMap)) {
    try {
      await prisma.researchUnit.delete({ where: { id: oldId } });
      console.log(`Deleted duplicate unit record: "${oldId}"`);
    } catch (e) {
      console.log(`Unit "${oldId}" was already removed or missing.`);
    }
  }

  console.log('--- DEDUPLICATION COMPLETE ---');
}

main().finally(() => prisma.$disconnect());
