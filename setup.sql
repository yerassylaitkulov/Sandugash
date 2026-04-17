-- Run this once in Supabase SQL Editor
-- Creates the hw_questions and hw_status tables

CREATE TABLE IF NOT EXISTS hw_questions (
  id SERIAL PRIMARY KEY,
  hw_number INTEGER NOT NULL,
  ex_number INTEGER NOT NULL,
  section TEXT DEFAULT '',
  type TEXT NOT NULL CHECK (type IN ('translate','fillin','multiple','sentence')),
  question TEXT NOT NULL,
  answer TEXT NOT NULL,
  options JSONB DEFAULT NULL,
  tip TEXT DEFAULT '',
  min_words INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS hw_status (
  hw_number INTEGER PRIMARY KEY,
  is_locked BOOLEAN DEFAULT true,
  label TEXT DEFAULT ''
);

-- Unlock HW1 by default
INSERT INTO hw_status (hw_number, is_locked, label) VALUES
  (1, false, 'Vocabulary · Passive · Well/Badly · So/Such'),
  (2, true,  'Personality · Body · Comparatives'),
  (3, true,  'Past Simple · Past Continuous'),
  (4, true,  'Present Perfect'),
  (5, true,  'Modals · Passive voice'),
  (6, true,  'Future · Articles · So/Such · Mixed')
ON CONFLICT (hw_number) DO NOTHING;

-- Allow public reads and inserts
ALTER TABLE hw_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE hw_status ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow_all_questions" ON hw_questions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_status" ON hw_status FOR ALL USING (true) WITH CHECK (true);

-- Seed HW1 questions
INSERT INTO hw_questions (hw_number, ex_number, section, type, question, answer, options, tip) VALUES
(1,1,'Part A — Vocabulary','translate','Translate: «Беженец»','refugee',NULL,''),
(1,2,'Part A — Vocabulary','translate','Translate: «Избегать»','avoid',NULL,''),
(1,3,'Part A — Vocabulary','translate','Translate: «Позволить себе (по деньгам)»','afford',NULL,''),
(1,4,'Part A — Vocabulary','fillin','Fill in: «The army decided to ___ the country.»','invade',NULL,''),
(1,5,'Part A — Vocabulary','translate','Translate: «Необычный»','unusual',NULL,''),
(1,6,'Part A — Vocabulary','translate','Translate: «Налог»','tax',NULL,''),
(1,7,'Part A — Vocabulary','multiple','«The government decided to ___ people fleeing the war.»','let people in','["invade","let people in","avoid"]',''),
(1,8,'Part A — Vocabulary','multiple','Which word means «Древний»?','Ancient','["Recently","Ancient","Cosmopolitan"]',''),
(1,9,'Part B — Passive voice','multiple','Which sentence is in the passive voice?','The city was invaded by soldiers.','["The soldiers invaded the city.","The city was invaded by soldiers.","Soldiers are invading the city."]',''),
(1,10,'Part B — Passive voice','fillin','Fill in: «She ___ by the police after the protest.» (захвачена — past passive)','was captured',NULL,''),
(1,11,'Part B — Passive voice','fillin','Fill in: «Taxes ___ (collect) by the government every year.» (present passive)','are collected',NULL,''),
(1,12,'Part B — Passive voice','fillin','Rewrite in passive: «People consider this city cosmopolitan.» Start with: "This city…"','this city is considered cosmopolitan',NULL,''),
(1,13,'Part B — Passive voice','fillin','Rewrite in passive: «The army invaded the country in 1940.» Start with: "The country…"','the country was invaded in 1940',NULL,''),
(1,14,'Part B — Passive voice','multiple','«Refugees ___ helped by volunteers every day.» Choose correct auxiliary.','are','["is","are","was"]',''),
(1,15,'Part B — Passive voice','translate','Translate: «Приказ был выполнен.»','the order was executed',NULL,''),
(1,16,'Part C — Well- / Badly-','multiple','«She is a ___ known scientist.» (before a noun)','well-known','["well-known","well known","good known"]',''),
(1,17,'Part C — Well- / Badly-','fillin','Fill in: «The project was ___ managed — nothing worked.» (after a verb)','badly managed',NULL,''),
(1,18,'Part C — Well- / Badly-','multiple','«It was a ___ organised event — everyone was confused.»','badly-organised','["badly-organised","well-organised","bad-organise"]',''),
(1,19,'Part C — Well- / Badly-','fillin','Correct the mistake: «She is a well known author.» (before a noun — write the full corrected sentence)','she is a well-known author',NULL,'Think about the hyphen rule'),
(1,20,'Part D — So / Such','multiple','«It was ___ unusual experience.»','such an','["so","such an","so much"]',''),
(1,21,'Part D — So / Such','multiple','«There were ___ many refugees at the border.»','so','["so","such","very"]',''),
(1,22,'Part D — So / Such','fillin','Fill in: «She is ___ a brave person.» (такая)','such',NULL,''),
(1,23,'Part D — So / Such','fillin','Fill in: «There was ___ much traffic that we were late.»','so',NULL,''),
(1,24,'Part D — So / Such','translate','Translate: «Это была такая необычная сказка!»','it was such an unusual fairy tale',NULL,'Use "such a/an" + adjective + noun'),
(1,25,'Part D — So / Such','sentence','Write 2 sentences: one using passive voice, one using so/such. Topic: refugees or ancient cities.','',NULL,'Teacher will check. At least 8 words total.')
ON CONFLICT DO NOTHING;
