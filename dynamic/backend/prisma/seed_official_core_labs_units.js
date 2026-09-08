const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log('--- SEEDING OFFICIAL CORE LABS & UNITS IN POSTGRESQL ---');

  // 1. Official Core Laboratories (4)
  const officialLabs = [
    {
      id: 'cancer-biology',
      title: 'Cancer Biology Laboratory',
      shortName: 'CBL',
      category: 'Biomedical & Precision Oncology',
      categoryName: 'Biomedical & Precision Oncology',
      location: 'Building B, 2nd Floor, Room 204',
      locationName: 'Research Center Main Campus, Erbil',
      department: 'molecular-engineering-and-cancer-biology',
      departmentName: 'Molecular Engineering & Cancer Biology Unit',
      description: 'The Cancer Biology Laboratory is equipped to support multidisciplinary research in molecular oncology, cancer cell biology, tumor microenvironment, experimental therapeutics, and translational cancer research.',
      capacity: '25',
      status: 'ACTIVE',
      image: '/images/labs/lab-biology.svg',
      platforms: [
        'Cell Culture',
        'Molecular Biology',
        'Protein Analysis',
        'Cell Imaging',
        'Cancer Therapeutics & Drug Screening',
        'Biomarker Discovery',
        'Experimental Oncology',
        'Sample Processing & Biobanking'
      ]
    },
    {
      id: 'molecular-engineering',
      title: 'Molecular Engineering Laboratory',
      shortName: 'MEL',
      category: 'Molecular Engineering',
      categoryName: 'Biotechnology & Genetic Engineering',
      location: 'Building B, 1st Floor, Room 102',
      locationName: 'Research Center Main Campus, Erbil',
      department: 'molecular-engineering-and-cancer-biology',
      departmentName: 'Molecular Engineering & Cancer Biology Unit',
      description: 'Specialized facility for recombinant protein expression, genetic engineering, synthetic biology, and molecular vector construction.',
      capacity: '20',
      status: 'ACTIVE',
      image: '/images/labs/lab-engineering.svg',
      platforms: ['Genetic Engineering', 'Recombinant DNA', 'Protein Expression', 'Cloning & Vector Construction']
    },
    {
      id: 'chemical-analysis',
      title: 'Chemical Analysis Laboratory',
      shortName: 'CAL',
      category: 'Analytical Chemistry',
      categoryName: 'Chemical & Environmental Analysis',
      location: 'Building A, Ground Floor, Room 10',
      locationName: 'Research Center Main Campus, Erbil',
      department: 'environmental-monitoring-and-climate-change-unit-emccu',
      departmentName: 'Environmental Monitoring & Climate Change Unit',
      description: 'Equipped with precision spectroscopy, chromatography, and elemental analysis instruments for soil, water, food, and environmental chemistry samples.',
      capacity: '30',
      status: 'ACTIVE',
      image: '/images/labs/lab-chemistry.svg',
      platforms: ['Spectrophotometry', 'Chromatography', 'Heavy Metal Analysis', 'Water & Soil Quality']
    },
    {
      id: 'nanotechnology',
      title: 'Nanotechnology Laboratory',
      shortName: 'NTL',
      category: 'Nanotechnology & Materials',
      categoryName: 'Advanced Materials & Nanotechnology',
      location: 'Building C, 1st Floor, Room 108',
      locationName: 'Research Center Main Campus, Erbil',
      department: 'data-analysis-unit',
      departmentName: 'Data Analysis & AI Unit',
      description: 'Focuses on nanoparticle synthesis, characterization, targeted drug delivery vehicles, and advanced nanomaterial fabrication for biomedical and energy applications.',
      capacity: '15',
      status: 'ACTIVE',
      image: '/images/labs/lab-engineering.svg',
      platforms: ['Nanoparticle Synthesis', 'Material Characterization', 'Targeted Drug Delivery', 'Electron Microscopy'],
      equipment: [
        { id: 'eq-nt-001', name: 'TEM Sample Preparation & Ion Milling Unit', category: 'Electron Microscopy', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
        { id: 'eq-nt-002', name: 'Dynamic Light Scattering (DLS) Zeta Potential Analyzer', category: 'Material Characterization', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
        { id: 'eq-nt-003', name: 'High-Intensity Ultrasonic Homogenizer & Sonicator', category: 'Nanoparticle Synthesis', totalUnits: 2, workingUnits: 2, outOfOrder: 0, status: 'available' },
        { id: 'eq-nt-004', name: 'High-Temperature Muffle Furnace (1200°C)', category: 'Materials Synthesis', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
        { id: 'eq-nt-005', name: 'Precision Vacuum Spin Coater', category: 'Thin Film Fabrication', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' }
      ]
    }
  ];

  // Add equipment to other core labs
  officialLabs[0].equipment = [
    { id: 'eq-cb-001', name: 'Automated Cell Counter', category: 'Cell Culture', totalUnits: 2, workingUnits: 2, outOfOrder: 0, status: 'available' },
    { id: 'eq-cb-002', name: 'Real-Time PCR System (qPCR)', category: 'Molecular Biology', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-cb-003', name: 'Fluorescence Phase Contrast Microscope', category: 'Cell Imaging', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-cb-004', name: 'CO2 Incubator BSL-2', category: 'Cell Culture', totalUnits: 3, workingUnits: 3, outOfOrder: 0, status: 'available' },
    { id: 'eq-cb-005', name: 'High-Speed Refrigerated Centrifuge', category: 'Sample Processing', totalUnits: 2, workingUnits: 2, outOfOrder: 0, status: 'available' },
    { id: 'eq-cb-006', name: 'Multimode Microplate Reader (ELISA)', category: 'Biomarker Discovery', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' }
  ];

  officialLabs[1].equipment = [
    { id: 'eq-me-001', name: 'Mastercycler Gradient PCR Machine', category: 'Genetic Engineering', totalUnits: 4, workingUnits: 4, outOfOrder: 0, status: 'available' },
    { id: 'eq-me-002', name: 'Gel Documentation & Imaging System', category: 'Recombinant DNA', totalUnits: 2, workingUnits: 2, outOfOrder: 0, status: 'available' },
    { id: 'eq-me-003', name: 'NanoDrop Microvolume Spectrophotometer', category: 'Molecular Biology', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-me-004', name: 'Fast Protein Liquid Chromatography (FPLC)', category: 'Protein Expression', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-me-005', name: 'Ultra-Low Temperature Freezer (-80°C)', category: 'Biobanking', totalUnits: 2, workingUnits: 2, outOfOrder: 0, status: 'available' }
  ];

  officialLabs[2].equipment = [
    { id: 'eq-ca-001', name: 'High-Performance Liquid Chromatograph (HPLC)', category: 'Chromatography', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-ca-002', name: 'Atomic Absorption Spectrophotometer (AAS)', category: 'Heavy Metal Analysis', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-ca-003', name: 'Double Beam UV-Vis Spectrophotometer', category: 'Spectrophotometry', totalUnits: 2, workingUnits: 2, outOfOrder: 0, status: 'available' },
    { id: 'eq-ca-004', name: 'Gas Chromatography-Mass Spectrophotometer (GC-MS)', category: 'Organic Analysis', totalUnits: 1, workingUnits: 1, outOfOrder: 0, status: 'available' },
    { id: 'eq-ca-005', name: 'Multi-Parameter Water Quality Meter', category: 'Environmental Analysis', totalUnits: 3, workingUnits: 3, outOfOrder: 0, status: 'available' }
  ];

  for (const lab of officialLabs) {
    const { equipment, ...labData } = lab;
    const existing = await prisma.lab.findUnique({ where: { id: lab.id } });
    if (existing) {
      console.log(`Updating Core Lab: ${lab.title}`);
      await prisma.lab.update({ where: { id: lab.id }, data: labData });
    } else {
      console.log(`Creating Core Lab: ${lab.title}`);
      await prisma.lab.create({ data: labData });
    }

    if (equipment && Array.isArray(equipment)) {
      for (const eqItem of equipment) {
        await prisma.equipment.upsert({
          where: { id: eqItem.id },
          update: {
            name: eqItem.name,
            labId: lab.id,
            category: eqItem.category,
            totalUnits: eqItem.totalUnits,
            workingUnits: eqItem.workingUnits,
            outOfOrder: eqItem.outOfOrder,
            status: eqItem.status
          },
          create: {
            id: eqItem.id,
            name: eqItem.name,
            labId: lab.id,
            category: eqItem.category,
            totalUnits: eqItem.totalUnits,
            workingUnits: eqItem.workingUnits,
            outOfOrder: eqItem.outOfOrder,
            status: eqItem.status
          }
        });
      }
    }
  }

  // 2. Official Research Units (3)
  const officialUnits = [
    {
      id: 'emccu',
      title: 'Environmental Monitoring & Climate Change Unit',
      name: 'Environmental Monitoring & Climate Change Unit (EMCCU)',
      image: '/images/labs/lab-agriculture.svg',
      description: 'Leading research in regional environmental monitoring, climate change impact assessment, air and water quality analytics, and GIS spatial modeling across Kurdistan.'
    },
    {
      id: 'data-analysis-and-ai',
      title: 'Data Analysis and AI Unit',
      name: 'Data Analysis and AI Unit',
      image: '/images/labs/lab-engineering.svg',
      description: 'Pioneering computational research in artificial intelligence, deep learning, temporal data mining, medical image classification, and Kurdish natural language processing (NLP).'
    },
    {
      id: 'development-and-cooperation',
      title: 'Development and Cooperation Unit',
      name: 'Development and Cooperation Unit',
      image: '/images/labs/lab-chemistry.svg',
      description: 'Coordinates international research grants, multi-institutional university collaborations, industrial technology transfer, and evidence-based policy outreach.'
    }
  ];

  for (const unit of officialUnits) {
    const existing = await prisma.researchUnit.findUnique({ where: { id: unit.id } });
    if (existing) {
      console.log(`Updating Official Unit: ${unit.title}`);
      await prisma.researchUnit.update({ where: { id: unit.id }, data: unit });
    } else {
      console.log(`Creating Official Unit: ${unit.title}`);
      await prisma.researchUnit.create({ data: unit });
    }
  }

  console.log('SUCCESS: All 4 Core Labs and 3 Official Units seeded and updated in PostgreSQL!');
}

main().finally(() => prisma.$disconnect());
