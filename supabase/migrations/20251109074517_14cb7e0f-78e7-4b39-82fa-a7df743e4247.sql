-- Create courses table
CREATE TABLE public.courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  board TEXT NOT NULL,
  grade INTEGER NOT NULL,
  subject TEXT NOT NULL,
  is_public BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create questions table
CREATE TABLE public.questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id UUID REFERENCES public.courses(id) ON DELETE CASCADE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('MCQ', 'FR')),
  stem_md TEXT NOT NULL,
  options JSONB NULL,
  correct_key TEXT NULL,
  solution_steps_md TEXT NULL,
  concept_tags TEXT[] DEFAULT '{}',
  difficulty_1_5 INTEGER CHECK (difficulty_1_5 BETWEEN 1 AND 5),
  time_budget_sec INTEGER,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create fast_methods table
CREATE TABLE public.fast_methods (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL UNIQUE,
  short_justification_md TEXT NOT NULL,
  fast_steps_md TEXT NOT NULL,
  why_others_wrong_md TEXT NULL,
  checks_notes_md TEXT NULL,
  validated BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create attempts table
CREATE TABLE public.attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  device_id TEXT NOT NULL,
  course_id UUID REFERENCES public.courses(id) ON DELETE CASCADE NOT NULL,
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL,
  selected_key TEXT NULL,
  free_response TEXT NULL,
  correct BOOLEAN NULL,
  time_taken_ms INTEGER NOT NULL,
  time_to_first_action_ms INTEGER NULL,
  confidence_0_1 FLOAT NULL,
  skipped BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Enable RLS (public read for courses, questions, fast_methods; no auth required for attempts)
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fast_methods ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attempts ENABLE ROW LEVEL SECURITY;

-- Public read policies (no auth required - MVP)
CREATE POLICY "Anyone can view public courses"
  ON public.courses FOR SELECT
  USING (is_public = true);

CREATE POLICY "Anyone can view questions"
  ON public.questions FOR SELECT
  USING (true);

CREATE POLICY "Anyone can view fast methods"
  ON public.fast_methods FOR SELECT
  USING (true);

CREATE POLICY "Anyone can insert attempts"
  ON public.attempts FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can view attempts"
  ON public.attempts FOR SELECT
  USING (true);

-- Seed public courses
INSERT INTO public.courses (slug, title, board, grade, subject, is_public) VALUES
  ('class-10-chemistry', 'Class 10 Chemistry', 'Board', 10, 'Chemistry', true),
  ('class-11-chemistry', 'Class 11 Chemistry', 'Board', 11, 'Chemistry', true),
  ('class-13-chemistry', 'Class 13 Chemistry', 'Board', 13, 'Chemistry', true);

-- Seed Chemistry questions for Class 10 (Stoichiometry & Mole Concept)
WITH course AS (SELECT id FROM public.courses WHERE slug = 'class-10-chemistry' LIMIT 1)
INSERT INTO public.questions (course_id, type, stem_md, options, correct_key, concept_tags, difficulty_1_5, time_budget_sec) VALUES
  ((SELECT id FROM course), 'MCQ', 'A solution contains 58.5 g NaCl in 1 L water. What is its molarity? (Na=23, Cl=35.5)', 
   '[{"key":"A","text":"0.5 M"},{"key":"B","text":"1.0 M"},{"key":"C","text":"2.0 M"},{"key":"D","text":"58.5 M"}]'::jsonb, 
   'B', '{mole,solutions,stoichiometry}', 2, 60),
  
  ((SELECT id FROM course), 'MCQ', 'How many molecules are present in 18 g of water? (H=1, O=16)', 
   '[{"key":"A","text":"6.02 × 10²³"},{"key":"B","text":"3.01 × 10²³"},{"key":"C","text":"12.04 × 10²³"},{"key":"D","text":"1.0 × 10²³"}]'::jsonb, 
   'A', '{mole,avogadro}', 2, 70),
  
  ((SELECT id FROM course), 'MCQ', 'What is the mass of 0.5 moles of CO₂? (C=12, O=16)', 
   '[{"key":"A","text":"11 g"},{"key":"B","text":"22 g"},{"key":"C","text":"44 g"},{"key":"D","text":"88 g"}]'::jsonb, 
   'B', '{mole,molecular-mass}', 2, 65),
  
  ((SELECT id FROM course), 'MCQ', 'Which contains more atoms: 1 g of H₂ or 1 g of O₂? (H=1, O=16)', 
   '[{"key":"A","text":"H₂"},{"key":"B","text":"O₂"},{"key":"C","text":"Both equal"},{"key":"D","text":"Cannot determine"}]'::jsonb, 
   'A', '{mole,comparison}', 3, 80),
  
  ((SELECT id FROM course), 'MCQ', 'Calculate moles in 11 g of CO₂. (C=12, O=16)', 
   '[{"key":"A","text":"0.1 mol"},{"key":"B","text":"0.25 mol"},{"key":"C","text":"0.5 mol"},{"key":"D","text":"1.0 mol"}]'::jsonb, 
   'B', '{mole,stoichiometry}', 2, 60),
  
  ((SELECT id FROM course), 'MCQ', 'What is the volume of 1 mole of any gas at STP?', 
   '[{"key":"A","text":"11.2 L"},{"key":"B","text":"22.4 L"},{"key":"C","text":"44.8 L"},{"key":"D","text":"2.24 L"}]'::jsonb, 
   'B', '{mole,gas-laws}', 2, 50),
  
  ((SELECT id FROM course), 'MCQ', 'How many moles of H₂SO₄ are in 98 g of the acid? (H=1, S=32, O=16)', 
   '[{"key":"A","text":"0.5 mol"},{"key":"B","text":"1.0 mol"},{"key":"C","text":"1.5 mol"},{"key":"D","text":"2.0 mol"}]'::jsonb, 
   'B', '{mole,acids}', 2, 70),
  
  ((SELECT id FROM course), 'MCQ', 'What is the empirical formula of a compound with 40% C, 6.7% H, and 53.3% O by mass? (C=12, H=1, O=16)', 
   '[{"key":"A","text":"CH₂O"},{"key":"B","text":"C₂H₄O₂"},{"key":"C","text":"CHO"},{"key":"D","text":"C₃H₆O₃"}]'::jsonb, 
   'A', '{empirical-formula,stoichiometry}', 4, 120),
  
  ((SELECT id FROM course), 'MCQ', 'How many atoms are in 2 moles of methane (CH₄)?', 
   '[{"key":"A","text":"6.02 × 10²³"},{"key":"B","text":"1.204 × 10²⁴"},{"key":"C","text":"6.02 × 10²⁴"},{"key":"D","text":"3.01 × 10²⁴"}]'::jsonb, 
   'C', '{mole,molecules}', 3, 85),
  
  ((SELECT id FROM course), 'MCQ', 'Which has the greatest mass: 1 mol Fe or 1 mol S? (Fe=56, S=32)', 
   '[{"key":"A","text":"Fe"},{"key":"B","text":"S"},{"key":"C","text":"Both equal"},{"key":"D","text":"Cannot determine"}]'::jsonb, 
   'A', '{mole,atomic-mass}', 2, 55);

-- Seed fast methods for the questions
WITH q1 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%58.5 g NaCl%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q1), '58.5 g is exactly 1 mole of NaCl → 1 mol in ~1 L ≈ 1.0 M.', 
   'Recognize 58.5 g/mol for NaCl. Given 58.5 g in ~1 L → 1 mol/L → **1.0 M**. No arithmetic needed.', 
   '**A (0.5 M)**: Assumes half mole. **C (2.0 M)**: Assumes double. **D (58.5 M)**: Confuses grams with molarity.', 
   'Units: mol/L. Assumes volume contraction negligible (typical for board exams).');

WITH q2 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%18 g of water%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q2), '18 g = 1 mole of H₂O → Avogadro''s number of molecules.', 
   'Molecular mass of H₂O = 18. So 18 g = 1 mol → **6.02 × 10²³** molecules directly.', 
   '**B**: Half of Avogadro. **C**: Double. **D**: Random factor.', 
   'Standard recall: 1 mol = 6.02 × 10²³ entities.');

WITH q3 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%0.5 moles of CO₂%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q3), 'CO₂ = 44 g/mol. Half mole = half mass.', 
   'Molar mass CO₂ = 12 + 32 = 44. For 0.5 mol: 0.5 × 44 = **22 g**.', 
   '**A (11 g)**: Quarter mole. **C (44 g)**: Full mole. **D (88 g)**: Double mole.', 
   'Quick mental: half of 44 is 22.');

WITH q4 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%1 g of H₂ or 1 g of O₂%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q4), 'Lighter molecule → more moles → more atoms for same mass.', 
   'H₂ (2 g/mol) vs O₂ (32 g/mol). For 1 g: H₂ gives 0.5 mol, O₂ gives 0.03 mol. Each H₂ has 2 atoms, O₂ has 2 atoms. **H₂ wins** (more moles).', 
   '**B (O₂)**: Heavier molecule means fewer moles. **C**: Different molar masses. **D**: Determinable from atomic masses.', 
   'Atom count = moles × atoms per molecule. Lighter = more moles.');

WITH q5 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%11 g of CO₂%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q5), '11 g is exactly ¼ of 44 g (1 mole CO₂).', 
   'Molar mass CO₂ = 44. So 11 g = 11/44 = **0.25 mol**.', 
   '**A (0.1)**: Assumes 1/10. **C (0.5)**: Half mole (22 g). **D (1.0)**: Full mole (44 g).', 
   'Quick fraction: 11/44 = 1/4 = 0.25.');

WITH q6 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%volume of 1 mole%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q6), 'Standard recall: 1 mol gas at STP = 22.4 L.', 
   'Direct fact: **22.4 L** at STP for any ideal gas. No calculation needed.', 
   '**A**: Half. **C**: Double. **D**: 1/10. All incorrect multiples.', 
   'STP: 0°C, 1 atm. Universal constant for ideal gases.');

WITH q7 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%98 g of the acid%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q7), '98 g is exactly the molar mass of H₂SO₄.', 
   'H₂SO₄: 2 + 32 + 64 = 98 g/mol. Given 98 g → **1.0 mol**.', 
   '**A (0.5)**: Half mole. **C (1.5)**: 1.5× mass. **D (2.0)**: Double mass.', 
   'Recognize 98 as molar mass instantly.');

WITH q8 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%empirical formula%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q8), 'No safe shortcut—use the standard method.', 
   'Divide mass % by atomic mass to get mole ratio: C(40/12)=3.33, H(6.7/1)=6.7, O(53.3/16)=3.33. Ratio 1:2:1 → **CH₂O**. This requires full calculation.', 
   '**B, D**: Molecular formulas (multiples). **C**: Wrong ratio.', 
   'Empirical = simplest whole-number ratio. No mental shortcut here.');

WITH q9 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%2 moles of methane%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q9), 'CH₄ has 5 atoms. 2 moles → 2 × 5 × Avogadro''s number.', 
   'Each CH₄ = 5 atoms. 2 mol CH₄ = 2 mol × 5 atoms/molecule = 10 mol atoms. 10 × 6.02×10²³ = **6.02 × 10²⁴** atoms.', 
   '**A**: 1 mol atoms. **B**: 2 mol atoms. **D**: 5 mol atoms. All undercounted.', 
   'Total atoms = moles × atoms per molecule × Avogadro.');

WITH q10 AS (SELECT id FROM public.questions WHERE stem_md LIKE '%1 mol Fe or 1 mol S%' LIMIT 1)
INSERT INTO public.fast_methods (question_id, short_justification_md, fast_steps_md, why_others_wrong_md, checks_notes_md) VALUES
  ((SELECT id FROM q10), 'Same moles, compare atomic masses: 56 > 32.', 
   '1 mol Fe = 56 g. 1 mol S = 32 g. **Fe** is heavier.', 
   '**B (S)**: Lower atomic mass. **C**: Different masses. **D**: Atomic masses given.', 
   'Same moles → mass ratio = atomic mass ratio.');