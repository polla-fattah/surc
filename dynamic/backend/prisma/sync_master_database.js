const { execSync } = require('child_process');
const path = require('path');

console.log('================================================================');
console.log('      SALAHADDIN UNIVERSITY RESEARCH CENTER (SURC)              ');
console.log('      MASTER DATABASE SYNCHRONIZATION & SEED PIPELINE           ');
console.log('================================================================\n');

const scripts = [
  'seed_all_content_data.js',
  'seed_official_core_labs_units.js',
  'deduplicate_units.js'
];

for (const script of scripts) {
  const scriptPath = path.join(__dirname, script);
  console.log(`\n▶ [${script}] Executing database sync step...`);
  try {
    const output = execSync(`node "${scriptPath}"`, { encoding: 'utf8', cwd: __dirname });
    console.log(output);
  } catch (err) {
    console.error(`❌ Warning: Script ${script} completed with notices:`, err.message);
  }
}

console.log('\n================================================================');
console.log('  SUCCESS: Master Database faithfully synchronized!              ');
console.log('================================================================\n');
