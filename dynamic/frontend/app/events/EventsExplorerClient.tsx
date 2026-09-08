'use client';

import React, { useState, useMemo, useEffect, useRef, useCallback } from 'react';
import Link from 'next/link';
import { Calendar, MapPin, Clock, ArrowRight, Bookmark, Search, Filter, Loader2, CheckCircle2 } from 'lucide-react';
import { getEventImageUrl } from '@/lib/imageResolver';

interface Event {
  id: number;
  title: string;
  slug: string;
  eventDate: string;
  image: string | null;
  eventType: string;
  featured: boolean;
  description: string | null;
  category: string | null;
  eventTime: string | null;
  location: string | null;
}

interface Props {
  initialEvents: Event[];
}

const FB_BATCH_SIZE = 10;

export default function EventsExplorerClient({ initialEvents }: Props) {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [visibleCount, setVisibleCount] = useState(FB_BATCH_SIZE);
  const [isLoadingMore, setIsLoadingMore] = useState(false);

  const bottomSentinelRef = useRef<HTMLDivElement | null>(null);

  // Extract unique categories
  const categories = useMemo(() => {
    const cats = new Set<string>();
    cats.add('All');
    initialEvents.forEach(e => {
      if (e.category) cats.add(e.category);
    });
    return Array.from(cats);
  }, [initialEvents]);

  // Filter events by search & category
  const filteredEvents = useMemo(() => {
    return initialEvents.filter(ev => {
      const matchesSearch = 
        !searchQuery.trim() ||
        ev.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        (ev.description && ev.description.toLowerCase().includes(searchQuery.toLowerCase()));

      const matchesCat = 
        selectedCategory === 'All' || 
        (ev.category && ev.category.toLowerCase() === selectedCategory.toLowerCase());

      return matchesSearch && matchesCat;
    });
  }, [initialEvents, searchQuery, selectedCategory]);

  // Slice events based on scroll-down visible count
  const visibleEvents = useMemo(() => {
    return filteredEvents.slice(0, visibleCount);
  }, [filteredEvents, visibleCount]);

  const hasMore = visibleCount < filteredEvents.length;

  // Load next batch of 10 items
  const loadNextBatch = useCallback(() => {
    if (isLoadingMore || !hasMore) return;
    setIsLoadingMore(true);
    setTimeout(() => {
      setVisibleCount(prev => Math.min(prev + FB_BATCH_SIZE, filteredEvents.length));
      setIsLoadingMore(false);
    }, 150);
  }, [isLoadingMore, hasMore, filteredEvents.length]);

  // 1. Facebook-style Window Scroll Listener (Early trigger when within 1000px of bottom)
  useEffect(() => {
    if (!hasMore) return;

    const handleWindowScroll = () => {
      const scrollHeight = document.documentElement.scrollHeight;
      const scrollTop = window.scrollY || document.documentElement.scrollTop;
      const clientHeight = window.innerHeight;

      if (scrollHeight - scrollTop - clientHeight < 1000) {
        loadNextBatch();
      }
    };

    window.addEventListener('scroll', handleWindowScroll, { passive: true });
    // Trigger check immediately in case page is short
    handleWindowScroll();

    return () => window.removeEventListener('scroll', handleWindowScroll);
  }, [hasMore, loadNextBatch]);

  // 2. IntersectionObserver Backup with 1000px root margin
  useEffect(() => {
    if (!hasMore) return;

    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting) {
          loadNextBatch();
        }
      },
      { threshold: 0.01, rootMargin: '1000px' }
    );

    const currentTarget = bottomSentinelRef.current;
    if (currentTarget) {
      observer.observe(currentTarget);
    }

    return () => {
      if (currentTarget) {
        observer.unobserve(currentTarget);
      }
    };
  }, [hasMore, loadNextBatch]);

  return (
    <div className="space-y-10">
      
      {/* Search & Category Filter Toolbar */}
      <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-sm space-y-6">
        <div className="flex flex-col md:flex-row gap-4 justify-between items-center">
          
          {/* Search Input */}
          <div className="relative w-full md:w-96">
            <Search className="w-4 h-4 absolute left-4 top-3.5 text-slate-400" />
            <input 
              type="text"
              placeholder="Search seminars, workshops & activities..."
              value={searchQuery}
              onChange={(e) => {
                setSearchQuery(e.target.value);
                setVisibleCount(FB_BATCH_SIZE);
              }}
              className="w-full pl-11 pr-4 py-2.5 bg-slate-50 border border-slate-200 rounded-2xl text-xs text-slate-800 focus:outline-none focus:ring-2 focus:ring-[var(--primary-maroon)]/30 focus:border-[var(--primary-maroon)] transition-all"
            />
          </div>

          {/* Result Count Indicator */}
          <div className="text-xs font-bold text-slate-500 whitespace-nowrap">
            Showing <span className="text-[var(--primary-maroon)]">{visibleEvents.length}</span> of <span className="text-[var(--secondary-blue)]">{filteredEvents.length}</span> events
          </div>
        </div>

        {/* Category Pills */}
        <div className="flex flex-wrap items-center gap-2 pt-2 border-t border-slate-100">
          <span className="text-xs font-extrabold text-slate-400 mr-2 flex items-center gap-1">
            <Filter className="w-3.5 h-3.5" /> Category:
          </span>
          {categories.map((cat) => (
            <button
              key={cat}
              onClick={() => {
                setSelectedCategory(cat);
                setVisibleCount(FB_BATCH_SIZE);
              }}
              className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all cursor-pointer ${
                selectedCategory.toLowerCase() === cat.toLowerCase()
                  ? 'bg-[var(--primary-maroon)] text-white shadow-md shadow-red-900/10'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              {cat}
            </button>
          ))}
        </div>
      </div>

      {/* Events Grid */}
      {visibleEvents.length === 0 ? (
        <div className="bg-white border border-slate-200 rounded-3xl p-12 text-center space-y-3">
          <Bookmark className="w-8 h-8 text-slate-300 mx-auto" />
          <h3 className="text-sm font-bold text-slate-700">No matching events found</h3>
          <p className="text-xs text-slate-400">Try adjusting your search query or category filter.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {visibleEvents.map((ev) => (
            <div 
              key={ev.id} 
              className="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden flex flex-col justify-between hover:border-[var(--primary-maroon)] hover:shadow-md transition-all group"
            >
              {/* Event Cover Image */}
              <div className="h-48 w-full relative overflow-hidden bg-slate-100 border-b border-slate-100">
                <img 
                  src={getEventImageUrl(ev.image, ev.title)} 
                  alt={ev.title} 
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                />
              </div>

              {/* Event Content */}
              <div className="p-6 space-y-4 flex-1 flex flex-col justify-between">
                <div className="space-y-3">
                  <div className="flex justify-between items-center text-[10px] font-bold">
                    <span className="inline-flex items-center px-2 py-0.5 rounded-md text-[8px] font-extrabold uppercase bg-red-50 text-[var(--primary-maroon)] border border-red-100">
                      {ev.category || 'Seminar'}
                    </span>
                    {ev.featured && (
                      <span className="text-amber-600 uppercase font-extrabold tracking-wider">
                        ★ Featured
                      </span>
                    )}
                  </div>
                  
                  <h3 className="text-sm font-extrabold text-[var(--secondary-blue)] leading-snug line-clamp-2 group-hover:text-[var(--primary-maroon)] transition-colors">
                    <Link href={`/events/${ev.slug}`}>
                      {ev.title}
                    </Link>
                  </h3>

                  <p className="text-xs text-slate-500 leading-relaxed line-clamp-3">
                    {ev.description || 'No detailed announcements text provided.'}
                  </p>
                </div>

                <div className="space-y-2 text-xs font-semibold text-slate-600 pt-4 border-t border-slate-100">
                  <div className="flex items-center space-x-2">
                    <Calendar className="w-4 h-4 text-[var(--primary-maroon)]" />
                    <span>{new Date(ev.eventDate).toLocaleDateString(undefined, { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric' })}</span>
                  </div>
                  {ev.eventTime && (
                    <div className="flex items-center space-x-2">
                      <Clock className="w-4 h-4 text-[var(--primary-maroon)]" />
                      <span>{ev.eventTime}</span>
                    </div>
                  )}
                  {ev.location && (
                    <div className="flex items-center space-x-2">
                      <MapPin className="w-4 h-4 text-[var(--primary-maroon)] shrink-0" />
                      <span className="truncate">{ev.location}</span>
                    </div>
                  )}
                </div>
              </div>

              {/* Footer CTA */}
              <div className="bg-slate-50/50 p-4 border-t border-slate-100 text-right">
                <Link 
                  href={`/events/${ev.slug}`} 
                  className="inline-flex items-center space-x-1 text-xs font-bold text-[var(--primary-maroon)] hover:underline"
                >
                  <span>Read Event Details</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Facebook-style Bottom Loading Sentinel */}
      <div ref={bottomSentinelRef} className="py-8 text-center min-h-[60px] flex items-center justify-center">
        {isLoadingMore && (
          <div className="inline-flex items-center space-x-2.5 px-5 py-2.5 rounded-full bg-white border border-slate-200 shadow-sm text-xs font-bold text-[var(--primary-maroon)] animate-pulse">
            <Loader2 className="w-4 h-4 animate-spin text-[var(--primary-maroon)]" />
            <span>Loading 10 more events...</span>
          </div>
        )}

        {!hasMore && filteredEvents.length > 0 && (
          <div className="inline-flex items-center space-x-2 px-6 py-2.5 rounded-full bg-slate-100 text-slate-500 text-xs font-bold border border-slate-200">
            <CheckCircle2 className="w-4 h-4 text-emerald-600" />
            <span>All {filteredEvents.length} events loaded</span>
          </div>
        )}
      </div>

    </div>
  );
}
