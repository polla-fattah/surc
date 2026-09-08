'use client';

import React, { useState } from 'react';
import DragDropImageUpload from '@/components/DragDropImageUpload';
import { 
  FileText, 
  ShieldCheck, 
  Plus, 
  Trash2, 
  Eye, 
  EyeOff, 
  CheckCircle2, 
  AlertCircle,
  Download,
  Layers,
  Award,
  Calendar,
  Image as ImageIcon,
  ExternalLink,
  Users,
  Briefcase,
  BookOpen,
  Edit,
  Pencil,
  Search,
  X
} from 'lucide-react';

interface FormItem {
  id: string | number;
  title: string;
  category: string;
  subCategory?: string | null;
  formType?: string | null;
  description?: string | null;
  filePath?: string | null;
  fileUrl?: string | null;
  fileFormat?: string | null;
  fileSize?: string | null;
  draft: boolean;
}

interface RegulationItem {
  id: string | number;
  title: string;
  category: string;
  subCategory?: string | null;
  description?: string | null;
  filePath?: string | null;
  fileUrl?: string | null;
  draft: boolean;
}

interface UnitItem {
  id: string;
  title: string;
  name: string;
  description?: string | null;
  draft: boolean;
}

interface LabItem {
  id: string;
  title: string;
  name: string;
  description?: string | null;
  platforms?: string[];
  draft: boolean;
}

interface EventItem {
  id: number;
  title: string;
  slug: string;
  eventDate: string;
  eventTime?: string | null;
  location?: string | null;
  image: string | null;
  galleryImages?: string[];
  category: string | null;
  description: string | null;
  content?: string | null;
  draft: boolean;
  featured?: boolean;
}

interface StaffItem {
  id: string;
  title: string;
  subtitle?: string | null;
  email?: string | null;
  image?: string | null;
  draft?: boolean;
}

interface ProjectItem {
  id: string;
  title: string;
  status: string;
  year?: string | null;
  projectType?: string | null;
  draft?: boolean;
}

interface PublicationItem {
  id: string;
  title: string;
  pubType: string;
  year?: string | null;
  journal?: string | null;
  draft?: boolean;
}

interface Props {
  initialForms: FormItem[];
  initialRegulations: RegulationItem[];
  initialUnits: UnitItem[];
  initialLabs: LabItem[];
  initialEvents?: EventItem[];
  initialStaff?: StaffItem[];
  initialProjects?: ProjectItem[];
  initialPublications?: PublicationItem[];
}

export default function MasterAdminConsoleClient({ 
  initialForms, 
  initialRegulations,
  initialUnits,
  initialLabs,
  initialEvents = [],
  initialStaff = [],
  initialProjects = [],
  initialPublications = []
}: Props) {
  const [activeTab, setActiveTab] = useState<'events' | 'units' | 'labs' | 'staff' | 'projects' | 'publications' | 'forms' | 'regulations'>('events');
  const [forms, setForms] = useState<FormItem[]>(initialForms);
  const [regulations, setRegulations] = useState<RegulationItem[]>(initialRegulations);
  const [units, setUnits] = useState<UnitItem[]>(initialUnits);
  const [labs, setLabs] = useState<LabItem[]>(initialLabs);
  const [events, setEvents] = useState<EventItem[]>(initialEvents);
  const [staff, setStaff] = useState<StaffItem[]>(initialStaff);
  const [projects, setProjects] = useState<ProjectItem[]>(initialProjects);
  const [publications, setPublications] = useState<PublicationItem[]>(initialPublications);

  const [isAdding, setIsAdding] = useState(false);
  const [feedbackMsg, setFeedbackMsg] = useState<{ type: 'success' | 'error'; text: string } | null>(null);

  // New item form state
  const [newId, setNewId] = useState('');
  const [newTitle, setNewTitle] = useState('');
  const [newCategory, setNewCategory] = useState('');
  const [newSubCategory, setNewSubCategory] = useState('');
  const [newFileUrl, setNewFileUrl] = useState('');
  const [newFileFormat, setNewFileFormat] = useState('PDF');
  const [newDescription, setNewDescription] = useState('');
  const [newPlatforms, setNewPlatforms] = useState('');
  const [newHeroImage, setNewHeroImage] = useState('');
  const [newGalleryImages, setNewGalleryImages] = useState<string[]>([]);
  const [newEventDate, setNewEventDate] = useState('');
  const [newEventLocation, setNewEventLocation] = useState('SURC');
  const [newEventTime, setNewEventTime] = useState('10:00 AM - 01:00 PM');
  const [newContent, setNewContent] = useState('');
  const [newFeatured, setNewFeatured] = useState(false);
  const [newDraft, setNewDraft] = useState(false);

  // Event Edit State
  const [editingEvent, setEditingEvent] = useState<EventItem | null>(null);
  const [editTitle, setEditTitle] = useState('');
  const [editCategory, setEditCategory] = useState('');
  const [editEventDate, setEditEventDate] = useState('');
  const [editEventTime, setEditEventTime] = useState('');
  const [editLocation, setEditLocation] = useState('');
  const [editDescription, setEditDescription] = useState('');
  const [editContent, setEditContent] = useState('');
  const [editHeroImage, setEditHeroImage] = useState('');
  const [editGalleryImages, setEditGalleryImages] = useState<string[]>([]);
  const [editDraft, setEditDraft] = useState(false);
  const [editFeatured, setEditFeatured] = useState(false);

  // Admin Event Search & Pagination
  const [eventAdminSearch, setEventAdminSearch] = useState('');
  const [eventAdminLimit, setEventAdminLimit] = useState(25);

  const resetFormFields = () => {
    setNewId('');
    setNewTitle('');
    setNewCategory('');
    setNewSubCategory('');
    setNewFileUrl('');
    setNewFileFormat('PDF');
    setNewDescription('');
    setNewPlatforms('');
    setNewHeroImage('');
    setNewGalleryImages([]);
    setNewEventDate('');
    setNewEventLocation('SURC');
    setNewEventTime('10:00 AM - 01:00 PM');
    setNewContent('');
    setNewFeatured(false);
    setNewDraft(false);
    setIsAdding(false);
  };

  const openEditEventModal = (ev: EventItem) => {
    setEditingEvent(ev);
    setEditTitle(ev.title || '');
    setEditCategory(ev.category || 'Seminar');
    const formattedDate = ev.eventDate ? new Date(ev.eventDate).toISOString().split('T')[0] : '';
    setEditEventDate(formattedDate);
    setEditEventTime(ev.eventTime || '10:00 AM - 01:00 PM');
    setEditLocation(ev.location || 'SURC');
    setEditDescription(ev.description || '');
    setEditContent(ev.content || ev.description || '');
    setEditHeroImage(ev.image || '');
    setEditGalleryImages(Array.isArray(ev.galleryImages) ? ev.galleryImages : []);
    setEditDraft(Boolean(ev.draft));
    setEditFeatured(Boolean(ev.featured));
  };

  const handleUpdateEvent = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingEvent) return;
    setFeedbackMsg(null);

    try {
      const res = await fetch(`/api/events/${editingEvent.id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          title: editTitle,
          category: editCategory,
          eventDate: editEventDate ? new Date(editEventDate).toISOString() : new Date().toISOString(),
          eventTime: editEventTime,
          location: editLocation,
          description: editDescription,
          content: editContent,
          image: editHeroImage || null,
          galleryImages: editGalleryImages,
          draft: editDraft,
          featured: editFeatured
        })
      });

      if (res.ok) {
        const updated = await res.json();
        setEvents(events.map(ev => ev.id === editingEvent.id ? { ...ev, ...updated } : ev));
        setFeedbackMsg({ type: 'success', text: `Event "${editTitle}" updated successfully!` });
        setEditingEvent(null);
      } else {
        const errJson = await res.json();
        setFeedbackMsg({ type: 'error', text: errJson.error || 'Failed to update event.' });
      }
    } catch (err) {
      setFeedbackMsg({ type: 'error', text: 'Error updating event announcement.' });
    }
  };

  // Toggle Draft / Published
  const toggleDraft = async (type: 'events' | 'units' | 'labs' | 'staff' | 'projects' | 'publications' | 'forms' | 'regulations', id: string | number, currentDraft: boolean) => {
    try {
      const endpoint = type === 'events' ? `/api/events/${id}` :
                       type === 'units' ? `/api/units/${id}` :
                       type === 'labs' ? `/api/labs/${id}` :
                       type === 'staff' ? `/api/staff/${id}` :
                       type === 'projects' ? `/api/projects/${id}` :
                       type === 'publications' ? `/api/publications/${id}` :
                       type === 'forms' ? `/api/forms/${id}` : `/api/regulations/${id}`;
      
      const res = await fetch(endpoint, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ draft: !currentDraft })
      });
      
      if (res.ok) {
        if (type === 'events') setEvents(events.map(e => e.slug === String(id) || e.id === Number(id) ? { ...e, draft: !currentDraft } : e));
        if (type === 'units') setUnits(units.map(u => u.id === id ? { ...u, draft: !currentDraft } : u));
        if (type === 'labs') setLabs(labs.map(l => l.id === id ? { ...l, draft: !currentDraft } : l));
        if (type === 'staff') setStaff(staff.map(s => s.id === id ? { ...s, draft: !currentDraft } : s));
        if (type === 'projects') setProjects(projects.map(p => p.id === id ? { ...p, draft: !currentDraft } : p));
        if (type === 'publications') setPublications(publications.map(pb => pb.id === id ? { ...pb, draft: !currentDraft } : pb));
        if (type === 'forms') setForms(forms.map(f => f.id === id ? { ...f, draft: !currentDraft } : f));
        if (type === 'regulations') setRegulations(regulations.map(r => r.id === id ? { ...r, draft: !currentDraft } : r));
        setFeedbackMsg({ type: 'success', text: `Item draft status updated.` });
      }
    } catch (err) {
      setFeedbackMsg({ type: 'error', text: 'Failed to update draft status.' });
    }
  };

  // Delete Item
  const deleteItem = async (type: 'events' | 'units' | 'labs' | 'staff' | 'projects' | 'publications' | 'forms' | 'regulations', id: string | number) => {
    if (!confirm(`Are you sure you want to delete this ${type.slice(0, -1)}?`)) return;
    try {
      const endpoint = type === 'events' ? `/api/events/${id}` :
                       type === 'units' ? `/api/units/${id}` :
                       type === 'labs' ? `/api/labs/${id}` :
                       type === 'staff' ? `/api/staff/${id}` :
                       type === 'projects' ? `/api/projects/${id}` :
                       type === 'publications' ? `/api/publications/${id}` :
                       type === 'forms' ? `/api/forms/${id}` : `/api/regulations/${id}`;
      
      const res = await fetch(endpoint, { method: 'DELETE' });
      if (res.ok) {
        if (type === 'events') setEvents(events.filter(e => e.slug !== String(id) && e.id !== Number(id)));
        if (type === 'units') setUnits(units.filter(u => u.id !== id));
        if (type === 'labs') setLabs(labs.filter(l => l.id !== id));
        if (type === 'staff') setStaff(staff.filter(s => s.id !== id));
        if (type === 'projects') setProjects(projects.filter(p => p.id !== id));
        if (type === 'publications') setPublications(publications.filter(pb => pb.id !== id));
        if (type === 'forms') setForms(forms.filter(f => f.id !== id));
        if (type === 'regulations') setRegulations(regulations.filter(r => r.id !== id));
        setFeedbackMsg({ type: 'success', text: `${type.slice(0, -1)} deleted successfully.` });
      }
    } catch (err) {
      setFeedbackMsg({ type: 'error', text: `Failed to delete ${type.slice(0, -1)}.` });
    }
  };

  // Create Item
  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    setFeedbackMsg(null);

    if (activeTab === 'events') {
      try {
        const galleryArr = Array.isArray(newGalleryImages) ? newGalleryImages : [];

        const res = await fetch('/api/events', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: newTitle,
            eventDate: newEventDate ? new Date(newEventDate).toISOString() : new Date().toISOString(),
            eventTime: newEventTime || '10:00 AM - 01:00 PM',
            location: newEventLocation || 'SURC',
            image: newHeroImage || null,
            galleryImages: galleryArr,
            category: newCategory || 'Seminar',
            description: newDescription || null,
            content: newContent || newDescription || null,
            featured: newFeatured,
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setEvents([created, ...events]);
          setFeedbackMsg({ type: 'success', text: 'New Event Announcement created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating event announcement.' });
      }
    } else if (activeTab === 'units') {
      try {
        const res = await fetch('/api/units', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            id: newId.toLowerCase().replace(/\s+/g, '-'),
            title: newTitle,
            name: newTitle,
            description: newDescription || null,
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setUnits([created, ...units]);
          setFeedbackMsg({ type: 'success', text: 'New Research Unit created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating research unit.' });
      }
    } else if (activeTab === 'labs') {
      try {
        const res = await fetch('/api/labs', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            id: newId.toLowerCase().replace(/\s+/g, '-'),
            title: newTitle,
            name: newTitle,
            description: newDescription || null,
            platforms: newPlatforms ? newPlatforms.split(',').map(p => p.trim()) : [],
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setLabs([created, ...labs]);
          setFeedbackMsg({ type: 'success', text: 'New Core Laboratory created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating core laboratory.' });
      }
    } else if (activeTab === 'staff') {
      try {
        const res = await fetch('/api/staff', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: newTitle,
            subtitle: newCategory || 'Research Associate',
            email: newFileUrl || null,
            image: newHeroImage || null,
            bio: newDescription || null,
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setStaff([created, ...staff]);
          setFeedbackMsg({ type: 'success', text: 'New researcher staff profile created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating researcher profile.' });
      }
    } else if (activeTab === 'projects') {
      try {
        const res = await fetch('/api/projects', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: newTitle,
            status: newCategory || 'ongoing',
            year: newEventDate || '2025',
            projectType: newSubCategory || 'Institutional Research',
            description: newDescription || null,
            creatorStaffId: 'staff-polla-fattah',
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setProjects([created, ...projects]);
          setFeedbackMsg({ type: 'success', text: 'New research project created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating research project.' });
      }
    } else if (activeTab === 'publications') {
      try {
        const res = await fetch('/api/publications', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: newTitle,
            pubType: newCategory || 'Article',
            year: newEventDate || '2024',
            journal: newSubCategory || null,
            link: newFileUrl || null,
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setPublications([created, ...publications]);
          setFeedbackMsg({ type: 'success', text: 'New publication entry created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating publication entry.' });
      }
    } else if (activeTab === 'forms') {
      try {
        const res = await fetch('/api/forms', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: newTitle,
            category: newCategory || 'General Forms',
            subCategory: newSubCategory || null,
            description: newDescription || null,
            fileUrl: newFileUrl || '/forms/SUE_Human_Research_Form (2).docx',
            fileFormat: newFileFormat,
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setForms([created, ...forms]);
          setFeedbackMsg({ type: 'success', text: 'New form template created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating form template.' });
      }
    } else {
      try {
        const res = await fetch('/api/regulations', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: newTitle,
            category: newCategory || 'Institutional Governance',
            description: newDescription || null,
            fileUrl: newFileUrl || '/policies/SURC_Research_Center_Policy.pdf',
            draft: newDraft
          })
        });
        if (res.ok) {
          const created = await res.json();
          setRegulations([created, ...regulations]);
          setFeedbackMsg({ type: 'success', text: 'New regulation policy created successfully!' });
          resetFormFields();
        }
      } catch (err) {
        setFeedbackMsg({ type: 'error', text: 'Error creating regulation policy.' });
      }
    }
  };

  return (
    <div className="space-y-8">
      
      {/* Feedback Banner */}
      {feedbackMsg && (
        <div className={`p-4 rounded-2xl border text-xs font-bold flex items-center space-x-2 ${
          feedbackMsg.type === 'success' ? 'bg-green-50 text-green-800 border-green-200' : 'bg-red-50 text-red-800 border-red-200'
        }`}>
          {feedbackMsg.type === 'success' ? <CheckCircle2 className="w-4 h-4" /> : <AlertCircle className="w-4 h-4" />}
          <span>{feedbackMsg.text}</span>
        </div>
      )}

      {/* Control Tabs & Action Bar */}
      <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4 bg-white p-4 rounded-2xl border border-slate-200 shadow-sm">
        
        <div className="flex flex-wrap gap-2 w-full lg:w-auto">
          <button
            onClick={() => setActiveTab('events')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'events' ? 'bg-[var(--primary-maroon)] text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <Calendar className="w-3.5 h-3.5" />
            <span>Events ({events.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('units')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'units' ? 'bg-[var(--secondary-blue)] text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <Layers className="w-3.5 h-3.5" />
            <span>Units ({units.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('labs')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'labs' ? 'bg-purple-800 text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <Award className="w-3.5 h-3.5" />
            <span>Labs ({labs.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('staff')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'staff' ? 'bg-indigo-800 text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <Users className="w-3.5 h-3.5" />
            <span>Staff ({staff.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('projects')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'projects' ? 'bg-amber-800 text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <Briefcase className="w-3.5 h-3.5" />
            <span>Projects ({projects.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('publications')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'publications' ? 'bg-teal-800 text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <BookOpen className="w-3.5 h-3.5" />
            <span>Publications ({publications.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('forms')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'forms' ? 'bg-emerald-800 text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <FileText className="w-3.5 h-3.5" />
            <span>Forms ({forms.length})</span>
          </button>

          <button
            onClick={() => setActiveTab('regulations')}
            className={`px-3.5 py-2 rounded-xl text-xs font-extrabold flex items-center space-x-1.5 transition-all cursor-pointer ${
              activeTab === 'regulations' ? 'bg-slate-800 text-white shadow-sm' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
            }`}
          >
            <ShieldCheck className="w-3.5 h-3.5" />
            <span>Policies ({regulations.length})</span>
          </button>
        </div>

        <button
          onClick={() => setIsAdding(!isAdding)}
          className="px-5 py-2.5 rounded-xl text-xs font-extrabold bg-[var(--accent-gold)] text-slate-900 hover:bg-amber-400 flex items-center space-x-1.5 transition-all cursor-pointer"
        >
          <Plus className="w-4 h-4" />
          <span>Add New {
            activeTab === 'events' ? 'Research Event' :
            activeTab === 'units' ? 'Research Unit' :
            activeTab === 'labs' ? 'Core Laboratory' :
            activeTab === 'forms' ? 'Form Template' : 'Policy Regulation'
          }</span>
        </button>
      </div>

      {/* Creation Drawer / Card */}
      {isAdding && (
        <form onSubmit={handleCreate} className="bg-white rounded-3xl p-8 border-2 border-[var(--primary-maroon)] shadow-md space-y-6">
          <h3 className="text-sm font-extrabold text-[var(--secondary-blue)] border-b border-slate-100 pb-3">
            Add New {
              activeTab === 'events' ? 'Research Event Announcement' :
              activeTab === 'units' ? 'Specialized Research Unit' :
              activeTab === 'labs' ? 'Core Research Laboratory' :
              activeTab === 'forms' ? 'Downloadable Form Template' : 'Governance Policy'
            }
          </h3>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 text-xs">
            {(activeTab === 'units' || activeTab === 'labs') && (
              <div className="space-y-1.5">
                <label className="font-bold text-slate-700">Unique Slug / ID *</label>
                <input 
                  type="text" 
                  required
                  value={newId}
                  onChange={e => setNewId(e.target.value)}
                  placeholder="e.g. emccu or cancer-biology" 
                  className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                />
              </div>
            )}

            <div className="space-y-1.5 md:col-span-2">
              <label className="font-bold text-slate-700">Title *</label>
              <input 
                type="text" 
                required
                value={newTitle}
                onChange={e => setNewTitle(e.target.value)}
                placeholder="e.g. Workshop on Advanced AI in Kurdish Natural Language Processing" 
                className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
              />
            </div>

            {activeTab === 'events' && (
              <>
                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Category *</label>
                  <select
                    value={newCategory}
                    onChange={e => setNewCategory(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  >
                    <option value="Seminar">Seminar</option>
                    <option value="Workshop">Workshop</option>
                    <option value="Conference">Conference</option>
                    <option value="Symposium">Symposium</option>
                    <option value="Research Activity">Research Activity</option>
                    <option value="Award Ceremony">Award Ceremony</option>
                    <option value="Official Announcement">Official Announcement</option>
                  </select>
                </div>

                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Event Date *</label>
                  <input 
                    type="date" 
                    required
                    value={newEventDate}
                    onChange={e => setNewEventDate(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Location</label>
                  <input 
                    type="text" 
                    value={newEventLocation}
                    onChange={e => setNewEventLocation(e.target.value)}
                    placeholder="e.g. SURC or Hall 3" 
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Time</label>
                  <input 
                    type="text" 
                    value={newEventTime}
                    onChange={e => setNewEventTime(e.target.value)}
                    placeholder="e.g. 10:00 AM - 01:00 PM" 
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                <div className="space-y-1.5 md:col-span-2">
                  <label className="font-bold text-slate-700">Full Article Content</label>
                  <textarea 
                    rows={4}
                    value={newContent}
                    onChange={e => setNewContent(e.target.value)}
                    placeholder="Enter full event announcements, agenda, or background text..." 
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                <div className="md:col-span-2">
                  <label className="flex items-center space-x-2 text-xs font-bold text-slate-700 cursor-pointer">
                    <input 
                      type="checkbox" 
                      checked={newFeatured}
                      onChange={e => setNewFeatured(e.target.checked)}
                      className="w-4 h-4 text-[var(--primary-maroon)] rounded"
                    />
                    <span>★ Mark as Featured Announcement (Pin on Homepage)</span>
                  </label>
                </div>

                {/* MAIN HERO IMAGE (DRAG & DROP) */}
                <div className="md:col-span-2 bg-slate-50 p-4 rounded-2xl border border-slate-200">
                  <DragDropImageUpload
                    multiple={false}
                    label="Main Hero Banner Image (Optional - Top of Event Detail)"
                    description="Drag & drop or click to upload the main cover photo for this event. The backend will automatically rename and store it in /images/uploads/."
                    value={newHeroImage}
                    onChange={(val) => setNewHeroImage(val)}
                  />
                </div>

                {/* BOTTOM GALLERY PHOTOS (DRAG & DROP BATCH) */}
                <div className="md:col-span-2 bg-slate-50 p-4 rounded-2xl border border-slate-200">
                  <DragDropImageUpload
                    multiple={true}
                    label="Bottom Photo Gallery Images (Batch Upload)"
                    description="Drag & drop or select multiple event photos at once. They will be uploaded automatically and displayed in the photo gallery at the bottom of the event detail page."
                    value={newGalleryImages}
                    onChange={(val) => setNewGalleryImages(val)}
                  />
                </div>
              </>
            )}

            {(activeTab === 'forms' || activeTab === 'regulations') && (
              <div className="space-y-1.5">
                <label className="font-bold text-slate-700">Category *</label>
                <input 
                  type="text" 
                  required
                  value={newCategory}
                  onChange={e => setNewCategory(e.target.value)}
                  placeholder="e.g. Ethics Review Application" 
                  className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                />
              </div>
            )}

            {(activeTab === 'forms' || activeTab === 'regulations') && (
              <div className="space-y-1.5">
                <label className="font-bold text-slate-700">File Download Path / URL *</label>
                <input 
                  type="text" 
                  required
                  value={newFileUrl}
                  onChange={e => setNewFileUrl(e.target.value)}
                  placeholder="e.g. /forms/SUE_Human_Research_Form (2).docx" 
                  className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                />
              </div>
            )}

            {activeTab === 'labs' && (
              <div className="space-y-1.5 md:col-span-2">
                <label className="font-bold text-slate-700">Specialized Platforms (Comma-Separated)</label>
                <input 
                  type="text" 
                  value={newPlatforms}
                  onChange={e => setNewPlatforms(e.target.value)}
                  placeholder="e.g. BSL-2 Cell Culture, qPCR Molecular Biology, SDS-PAGE Protein Analysis" 
                  className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                />
              </div>
            )}

            <div className="space-y-1.5 md:col-span-2">
              <label className="font-bold text-slate-700">Description / Content</label>
              <textarea 
                rows={3}
                value={newDescription}
                onChange={e => setNewDescription(e.target.value)}
                placeholder="Provide operational guidelines, scope, or event details..." 
                className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
              />
            </div>
          </div>

          <div className="flex items-center justify-between border-t border-slate-100 pt-4">
            <label className="flex items-center space-x-2 text-xs font-bold text-slate-700 cursor-pointer">
              <input 
                type="checkbox" 
                checked={newDraft}
                onChange={e => setNewDraft(e.target.checked)}
                className="w-4 h-4 text-[var(--primary-maroon)] rounded"
              />
              <span>Save as Draft (Hide from public website)</span>
            </label>

            <div className="flex space-x-3">
              <button 
                type="button" 
                onClick={resetFormFields}
                className="px-4 py-2.5 rounded-xl text-xs font-bold bg-slate-100 text-slate-600 hover:bg-slate-200"
              >
                Cancel
              </button>
              <button 
                type="submit" 
                className="px-5 py-2.5 rounded-xl text-xs font-bold bg-[var(--primary-maroon)] text-white hover:bg-red-900 shadow-sm"
              >
                Save Item
              </button>
            </div>
          </div>
        </form>
      )}

      {/* Items List Cards */}
      <div className="bg-white rounded-3xl p-8 border border-slate-200 shadow-sm space-y-4">
        
        <h3 className="text-sm font-extrabold text-[var(--secondary-blue)] border-b border-slate-100 pb-3">
          Manage {
            activeTab === 'events' ? 'Research Events & Announcements' :
            activeTab === 'units' ? 'Specialized Research Units' :
            activeTab === 'labs' ? 'Core Laboratories' :
            activeTab === 'forms' ? 'Downloadable Form Templates' : 'Governance Regulations'
          }
        </h3>

        {activeTab === 'events' && (
          <div className="space-y-4">
            {/* Search Filter for Events in Admin Console */}
            <div className="flex flex-col sm:flex-row gap-3 justify-between items-center bg-slate-50 p-4 rounded-2xl border border-slate-200">
              <div className="relative w-full sm:w-80">
                <Search className="w-4 h-4 absolute left-3.5 top-3 text-slate-400" />
                <input
                  type="text"
                  placeholder="Search events by title or description..."
                  value={eventAdminSearch}
                  onChange={(e) => setEventAdminSearch(e.target.value)}
                  className="w-full pl-10 pr-3 py-2 bg-white border border-slate-200 rounded-xl text-xs font-semibold focus:outline-none focus:ring-2 focus:ring-[var(--primary-maroon)]/20"
                />
              </div>
              <div className="text-xs font-bold text-slate-500">
                Showing <span className="text-[var(--primary-maroon)]">
                  {Math.min(
                    eventAdminLimit,
                    events.filter(e => 
                      !eventAdminSearch.trim() || 
                      e.title.toLowerCase().includes(eventAdminSearch.toLowerCase()) ||
                      (e.description && e.description.toLowerCase().includes(eventAdminSearch.toLowerCase()))
                    ).length
                  )}
                </span> of <span className="text-[var(--secondary-blue)]">
                  {events.filter(e => 
                    !eventAdminSearch.trim() || 
                    e.title.toLowerCase().includes(eventAdminSearch.toLowerCase()) ||
                    (e.description && e.description.toLowerCase().includes(eventAdminSearch.toLowerCase()))
                  ).length}
                </span> matching events
              </div>
            </div>

            {events
              .filter(e => 
                !eventAdminSearch.trim() || 
                e.title.toLowerCase().includes(eventAdminSearch.toLowerCase()) ||
                (e.description && e.description.toLowerCase().includes(eventAdminSearch.toLowerCase()))
              )
              .slice(0, eventAdminLimit)
              .map(ev => (
                <div key={ev.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 hover:border-[var(--primary-maroon)] transition-all">
                  <div className="space-y-1.5 flex-1">
                    <div className="flex items-center space-x-2">
                      <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                        ev.draft ? 'bg-amber-100 text-amber-800' : 'bg-red-100 text-[var(--primary-maroon)]'
                      }`}>
                        {ev.draft ? 'Draft' : (ev.category || 'Event')}
                      </span>
                      {ev.featured && (
                        <span className="px-2 py-0.5 rounded text-[8px] font-extrabold uppercase bg-amber-100 text-amber-800">
                          ★ Featured
                        </span>
                      )}
                      <span className="text-[10px] font-bold text-slate-400">
                        {new Date(ev.eventDate).toLocaleDateString()}
                      </span>
                    </div>
                    <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{ev.title}</h4>
                    <p className="text-[10px] text-slate-500 font-medium line-clamp-2">{ev.description || 'No description text.'}</p>
                  </div>

                  <div className="flex items-center space-x-2.5 self-end sm:self-center shrink-0">
                    <button
                      onClick={() => openEditEventModal(ev)}
                      className="px-3 py-1.5 rounded-lg bg-blue-50 text-blue-700 hover:bg-blue-100 text-[10px] font-extrabold flex items-center space-x-1 transition-all"
                      title="Edit Event Details"
                    >
                      <Pencil className="w-3 h-3" />
                      <span>Edit</span>
                    </button>

                    <button
                      onClick={() => toggleDraft('events', ev.id, ev.draft)}
                      className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                        ev.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                      }`}
                    >
                      {ev.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                      <span>{ev.draft ? 'Publish' : 'Draft'}</span>
                    </button>

                    <a 
                      href={`/events/${ev.slug}`} 
                      target="_blank" 
                      rel="noreferrer"
                      className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                      title="View Public Page"
                    >
                      <ExternalLink className="w-3.5 h-3.5" />
                    </a>

                    <button
                      onClick={() => deleteItem('events', ev.id)}
                      className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                      title="Delete Event"
                    >
                      <Trash2 className="w-3.5 h-3.5" />
                    </button>
                  </div>
                </div>
              ))}

            {events.filter(e => 
              !eventAdminSearch.trim() || 
              e.title.toLowerCase().includes(eventAdminSearch.toLowerCase()) ||
              (e.description && e.description.toLowerCase().includes(eventAdminSearch.toLowerCase()))
            ).length > eventAdminLimit && (
              <div className="text-center pt-3">
                <button
                  onClick={() => setEventAdminLimit(prev => prev + 25)}
                  className="px-6 py-2.5 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-extrabold transition-all cursor-pointer"
                >
                  Load More Events in Admin List
                </button>
              </div>
            )}
          </div>
        )}

        {activeTab === 'units' && (
          <div className="space-y-4">
            {units.map(unit => (
              <div key={unit.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                      unit.draft ? 'bg-amber-100 text-amber-800' : 'bg-green-100 text-green-800'
                    }`}>
                      {unit.draft ? 'Draft' : 'Active'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">ID: {unit.id}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{unit.title}</h4>
                  <p className="text-[10px] text-slate-500 font-medium line-clamp-2">{unit.description || 'No description.'}</p>
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('units', unit.id, unit.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      unit.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {unit.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{unit.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={`/units/${unit.id}`} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <ExternalLink className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('units', unit.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'labs' && (
          <div className="space-y-4">
            {labs.map(lab => (
              <div key={lab.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                      lab.draft ? 'bg-amber-100 text-amber-800' : 'bg-purple-100 text-purple-800'
                    }`}>
                      {lab.draft ? 'Draft' : 'Laboratory'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">ID: {lab.id}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{lab.title}</h4>
                  <p className="text-[10px] text-slate-500 font-medium line-clamp-2">{lab.description || 'No description.'}</p>
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('labs', lab.id, lab.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      lab.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {lab.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{lab.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={`/labs/${lab.id}`} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <ExternalLink className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('labs', lab.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'staff' && (
          <div className="space-y-4">
            {staff.map(st => (
              <div key={st.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                      st.draft ? 'bg-amber-100 text-amber-800' : 'bg-indigo-100 text-indigo-800'
                    }`}>
                      {st.draft ? 'Draft' : 'Academic Staff'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">ID: {st.id}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{st.title}</h4>
                  <p className="text-[10px] text-slate-500 font-medium">{st.subtitle || st.email || 'Researcher'}</p>
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('staff', st.id, !!st.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      st.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {st.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{st.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={`/staff/${st.id}`} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <ExternalLink className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('staff', st.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'projects' && (
          <div className="space-y-4">
            {projects.map(proj => (
              <div key={proj.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                      proj.draft ? 'bg-amber-100 text-amber-800' : 'bg-green-100 text-green-800'
                    }`}>
                      {proj.status || 'Ongoing'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Year: {proj.year || '2025'}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{proj.title}</h4>
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('projects', proj.id, !!proj.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      proj.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {proj.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{proj.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={`/projects/${proj.id}`} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <ExternalLink className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('projects', proj.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'publications' && (
          <div className="space-y-4">
            {publications.map(pub => (
              <div key={pub.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className="px-2 py-0.5 rounded text-[9px] font-extrabold uppercase bg-teal-100 text-teal-800">
                      {pub.pubType || 'Article'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 font-bold">Year: {pub.year || '2024'}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{pub.title}</h4>
                  {pub.journal && <p className="text-[10px] italic text-slate-500">{pub.journal}</p>}
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('publications', pub.id, !!pub.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      pub.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {pub.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{pub.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={`/publications/${pub.id}`} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <ExternalLink className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('publications', pub.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'forms' && (
          <div className="space-y-4">
            {forms.map(form => (
              <div key={form.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                      form.draft ? 'bg-amber-100 text-amber-800' : 'bg-green-100 text-green-800'
                    }`}>
                      {form.draft ? 'Draft' : 'Published'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">{form.category}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{form.title}</h4>
                  <p className="text-[10px] text-slate-500 font-medium line-clamp-2">{form.description || 'No description provided.'}</p>
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('forms', form.id, form.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      form.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {form.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{form.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={form.filePath || form.fileUrl || '#'} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <Download className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('forms', form.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'regulations' && (
          <div className="space-y-4">
            {regulations.map(reg => (
              <div key={reg.id} className="p-5 rounded-2xl border border-slate-200 bg-slate-50/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div className="space-y-1.5">
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-0.5 rounded text-[9px] font-extrabold uppercase ${
                      reg.draft ? 'bg-amber-100 text-amber-800' : 'bg-green-100 text-green-800'
                    }`}>
                      {reg.draft ? 'Draft' : 'Published'}
                    </span>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">{reg.category}</span>
                  </div>
                  <h4 className="text-xs font-extrabold text-[var(--secondary-blue)]">{reg.title}</h4>
                  <p className="text-[10px] text-slate-500 font-medium line-clamp-2">{reg.description || 'No description provided.'}</p>
                </div>

                <div className="flex items-center space-x-3 self-end sm:self-center">
                  <button
                    onClick={() => toggleDraft('regulations', reg.id, reg.draft)}
                    className={`px-3 py-1.5 rounded-lg text-[10px] font-extrabold flex items-center space-x-1 transition-all ${
                      reg.draft ? 'bg-slate-200 text-slate-700 hover:bg-green-100 hover:text-green-800' : 'bg-amber-100 text-amber-800 hover:bg-amber-200'
                    }`}
                  >
                    {reg.draft ? <Eye className="w-3 h-3" /> : <EyeOff className="w-3 h-3" />}
                    <span>{reg.draft ? 'Publish' : 'Set Draft'}</span>
                  </button>

                  <a 
                    href={reg.filePath || reg.fileUrl || '#'} 
                    target="_blank" 
                    rel="noreferrer"
                    className="p-2 rounded-lg bg-slate-100 text-slate-600 hover:bg-slate-200 text-[10px] font-bold flex items-center space-x-1"
                  >
                    <Download className="w-3.5 h-3.5" />
                  </a>

                  <button
                    onClick={() => deleteItem('regulations', reg.id)}
                    className="p-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

      </div>

      {/* EDIT EVENT MODAL */}
      {editingEvent && (
        <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 overflow-y-auto">
          <div className="bg-white rounded-3xl max-w-3xl w-full p-8 border border-slate-200 shadow-2xl space-y-6 my-8 max-h-[90vh] overflow-y-auto">
            
            <div className="flex justify-between items-center border-b border-slate-100 pb-4">
              <div>
                <span className="text-[10px] font-extrabold text-[var(--primary-maroon)] uppercase tracking-wider">Edit Event Announcement</span>
                <h3 className="text-lg font-extrabold text-[var(--secondary-blue)]">{editingEvent.title}</h3>
              </div>
              <button 
                onClick={() => setEditingEvent(null)}
                className="p-2 rounded-full bg-slate-100 hover:bg-slate-200 text-slate-500 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleUpdateEvent} className="space-y-6 text-xs">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                
                {/* Title */}
                <div className="space-y-1.5 md:col-span-2">
                  <label className="font-bold text-slate-700">Title *</label>
                  <input 
                    type="text" 
                    required
                    value={editTitle}
                    onChange={e => setEditTitle(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                {/* Category */}
                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Category *</label>
                  <select
                    value={editCategory}
                    onChange={e => setEditCategory(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  >
                    <option value="Seminar">Seminar</option>
                    <option value="Workshop">Workshop</option>
                    <option value="Conference">Conference</option>
                    <option value="Symposium">Symposium</option>
                    <option value="Research Activity">Research Activity</option>
                    <option value="Award Ceremony">Award Ceremony</option>
                    <option value="Official Announcement">Official Announcement</option>
                  </select>
                </div>

                {/* Date */}
                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Event Date *</label>
                  <input 
                    type="date" 
                    required
                    value={editEventDate}
                    onChange={e => setEditEventDate(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                {/* Location */}
                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Location</label>
                  <input 
                    type="text" 
                    value={editLocation}
                    onChange={e => setEditLocation(e.target.value)}
                    placeholder="e.g. SURC"
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                {/* Time */}
                <div className="space-y-1.5">
                  <label className="font-bold text-slate-700">Time</label>
                  <input 
                    type="text" 
                    value={editEventTime}
                    onChange={e => setEditEventTime(e.target.value)}
                    placeholder="e.g. 10:00 AM - 01:00 PM"
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                {/* Short Description */}
                <div className="space-y-1.5 md:col-span-2">
                  <label className="font-bold text-slate-700">Short Summary / Description</label>
                  <textarea 
                    rows={3}
                    value={editDescription}
                    onChange={e => setEditDescription(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                {/* Full Content */}
                <div className="space-y-1.5 md:col-span-2">
                  <label className="font-bold text-slate-700">Full Article Content</label>
                  <textarea 
                    rows={5}
                    value={editContent}
                    onChange={e => setEditContent(e.target.value)}
                    className="w-full p-3 rounded-xl border border-slate-200 bg-slate-50 focus:bg-white text-xs font-semibold"
                  />
                </div>

                {/* Toggles */}
                <div className="md:col-span-2 flex flex-wrap gap-6 pt-2">
                  <label className="flex items-center space-x-2 text-xs font-bold text-slate-700 cursor-pointer">
                    <input 
                      type="checkbox" 
                      checked={editDraft}
                      onChange={e => setEditDraft(e.target.checked)}
                      className="w-4 h-4 text-[var(--primary-maroon)] rounded"
                    />
                    <span>Save as Draft (Hide from public events explorer)</span>
                  </label>

                  <label className="flex items-center space-x-2 text-xs font-bold text-slate-700 cursor-pointer">
                    <input 
                      type="checkbox" 
                      checked={editFeatured}
                      onChange={e => setEditFeatured(e.target.checked)}
                      className="w-4 h-4 text-[var(--primary-maroon)] rounded"
                    />
                    <span>★ Mark as Featured Announcement</span>
                  </label>
                </div>

                {/* HERO COVER IMAGE */}
                <div className="md:col-span-2 bg-slate-50 p-4 rounded-2xl border border-slate-200">
                  <DragDropImageUpload
                    multiple={false}
                    label="Main Cover Banner Image"
                    description="Upload or change the primary event banner image."
                    value={editHeroImage}
                    onChange={(val) => setEditHeroImage(val)}
                  />
                </div>

                {/* GALLERY IMAGES */}
                <div className="md:col-span-2 bg-slate-50 p-4 rounded-2xl border border-slate-200">
                  <DragDropImageUpload
                    multiple={true}
                    label="Photo Gallery Images (Batch Upload)"
                    description="Upload or modify event photos displayed in the bottom photo gallery."
                    value={editGalleryImages}
                    onChange={(val) => setEditGalleryImages(val)}
                  />
                </div>

              </div>

              <div className="flex justify-end space-x-3 pt-4 border-t border-slate-100">
                <button 
                  type="button" 
                  onClick={() => setEditingEvent(null)}
                  className="px-5 py-2.5 rounded-xl text-xs font-bold bg-slate-100 text-slate-600 hover:bg-slate-200"
                >
                  Cancel
                </button>
                <button 
                  type="submit" 
                  className="px-6 py-2.5 rounded-xl text-xs font-bold bg-[var(--primary-maroon)] text-white hover:bg-red-900 shadow-md transition-all"
                >
                  Update Event
                </button>
              </div>
            </form>

          </div>
        </div>
      )}

    </div>
  );
}
