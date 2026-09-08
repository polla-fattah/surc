import { prisma } from '@/lib/prisma';
import { NextRequest, NextResponse } from 'next/server';

function getWhereClause(slugOrId: string) {
  const num = Number(slugOrId);
  if (!isNaN(num) && Number.isInteger(num)) {
    return { id: num };
  }
  return { slug: slugOrId };
}

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params;
  try {
    const where = getWhereClause(slug);
    const detail = await prisma.event.findFirst({ where });

    if (!detail) {
      return NextResponse.json({ error: 'Event not found.' }, { status: 404 });
    }

    const formatted = {
      ...detail,
      image: detail.image 
        ? (detail.image.startsWith('/') || detail.image.startsWith('http') ? detail.image : `/${detail.image}`)
        : null,
      galleryImages: Array.isArray(detail.galleryImages)
        ? detail.galleryImages.map(img => img.startsWith('/') || img.startsWith('http') ? img : `/${img}`)
        : []
    };

    return NextResponse.json(formatted);
  } catch (error: any) {
    console.error(`API Error in GET /api/events/${slug}:`, error);
    return NextResponse.json({ error: 'Failed to fetch event details.' }, { status: 500 });
  }
}

export async function PUT(
  request: NextRequest,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params;
  try {
    const data = await request.json();
    const where = getWhereClause(slug);

    const existing = await prisma.event.findFirst({ where });
    if (!existing) {
      return NextResponse.json({ error: 'Event not found.' }, { status: 404 });
    }

    const updatedData: any = {};

    if (data.title !== undefined) updatedData.title = data.title;
    if (data.eventDate !== undefined) updatedData.eventDate = new Date(data.eventDate);
    if (data.image !== undefined) updatedData.image = data.image;
    if (data.galleryImages !== undefined) updatedData.galleryImages = Array.isArray(data.galleryImages) ? data.galleryImages : [];
    if (data.category !== undefined) updatedData.category = data.category;
    if (data.description !== undefined) updatedData.description = data.description;
    if (data.content !== undefined) updatedData.content = data.content;
    if (data.location !== undefined) updatedData.location = data.location;
    if (data.eventTime !== undefined) updatedData.eventTime = data.eventTime;
    if (data.draft !== undefined) updatedData.draft = Boolean(data.draft);
    if (data.featured !== undefined) updatedData.featured = Boolean(data.featured);
    if (data.eventType !== undefined) updatedData.eventType = data.eventType;

    // Update slug if title changed or explicit slug provided
    if (data.slug) {
      updatedData.slug = data.slug.toLowerCase().replace(/[\s_]+/g, '-').replace(/[^\w-]/g, '');
    } else if (data.title && data.title !== existing.title) {
      const baseSlug = data.title.toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s+/g, '-').substring(0, 50);
      updatedData.slug = `${baseSlug}-${existing.id}`;
    }

    const updated = await prisma.event.update({
      where: { id: existing.id },
      data: updatedData
    });

    return NextResponse.json(updated);
  } catch (error: any) {
    console.error(`API Error in PUT /api/events/${slug}:`, error);
    return NextResponse.json({ error: 'Failed to update event.' }, { status: 500 });
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params;
  try {
    const where = getWhereClause(slug);
    const existing = await prisma.event.findFirst({ where });
    if (!existing) {
      return NextResponse.json({ error: 'Event not found.' }, { status: 404 });
    }

    await prisma.event.delete({
      where: { id: existing.id }
    });
    return NextResponse.json({ success: true, message: 'Event deleted successfully.' });
  } catch (error: any) {
    console.error(`API Error in DELETE /api/events/${slug}:`, error);
    return NextResponse.json({ error: 'Failed to delete event.' }, { status: 500 });
  }
}
