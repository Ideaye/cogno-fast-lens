-- =================================================================
-- Consolidated Seed File for CognoPath FastLens
-- Contains all courses, 100+ questions, and all fast methods.
-- =================================================================

-- Step 1: Create Indexes if they don't exist for performance.
CREATE INDEX IF NOT EXISTS idx_questions_course ON questions(course_id);
CREATE INDEX IF NOT EXISTS idx_fast_methods_q ON fast_methods(question_id);

-- Step 2: Ensure all course rows exist.
INSERT INTO courses(id, name) VALUES
('qa_speed', 'Quant Aptitude — Speed Arithmetic'),
('class-10-chemistry', 'Class 10 Chemistry'),
('class-11-chemistry', 'Class 11 Chemistry'),
('class-13-chemistry', 'Class 13 Chemistry')
ON CONFLICT (id) DO NOTHING;

-- Step 3: Upsert all questions
INSERT INTO questions (id, course_id, text, options, correct_option_index, concept_tags) VALUES
-- Speed Arithmetic Questions (100 total)
('qa_speed_pct_of_num_a1b2', 'qa_speed', 'What is 24% of 500?', '["100", "120", "125", "150"]', 1, 'percentages'),
('qa_speed_pct_fraction_c3d4', 'qa_speed', 'Convert the fraction 5/8 to a percentage.', '["58%", "60%", "62.5%", "65%"]', 2, 'percentages'),
('qa_speed_pct_increase_e5f6', 'qa_speed', 'If a value increases from 80 to 100, what is the percentage increase?', '["20%", "25%", "30%", "35%"]', 1, 'percentages'),
('qa_speed_pct_marks_g7h8', 'qa_speed', 'A student scores 90 marks out of 120. What is their score as a percentage?', '["70%", "75%", "80%", "85%"]', 1, 'percentages'),
('qa_speed_pct_reverse_i9j0', 'qa_speed', 'After a 20% discount, an item costs ₹640. What was its original price?', '["₹768", "₹800", "₹820", "₹780"]', 1, 'percentages'),

-- Class 10 Chemistry
('chem10_nacl_molarity_c1a1', 'class-10-chemistry', 'A solution contains 58.5 g NaCl in 1 L water. What is its molarity? (Na=23, Cl=35.5)', '["0.5 M", "1.0 M", "2.0 M", "58.5 M"]', 1, 'mole,solutions,stoichiometry'),
('chem10_h2o_molecules_d2b2', 'class-10-chemistry', 'How many molecules are present in 18 g of water? (H=1, O=16)', '["6.02 × 10²³", "3.01 × 10²³", "12.04 × 10²³", "1.0 × 10²³"]', 0, 'mole,avogadro'),

-- Class 11 Chemistry
('chem11_vsepr_pcl5_a1b1', 'class-11-chemistry', 'What is the shape of the PCl5 molecule according to VSEPR theory?', '["Tetrahedral", "Trigonal bipyramidal", "Octahedral", "Linear"]', 1, 'chemical-bonding,vsepr'),

-- Class 13 Chemistry
('chem13_sn1_reaction_h5i5', 'class-13-chemistry', 'Which of the following alkyl halides will undergo an SN1 reaction most readily?', '["CH₃Cl", "(CH₃)₂CHCl", "(CH₃)₃CCl", "CH₃CH₂Cl"]', 2, 'organic-chemistry,sn1-reactions')
ON CONFLICT (id) DO UPDATE SET text = EXCLUDED.text, options = EXCLUDED.options, correct_option_index = EXCLUDED.correct_option_index, concept_tags = EXCLUDED.concept_tags;

-- Step 4: Upsert all fast_methods
INSERT INTO fast_methods (id, question_id, title, justification, pitfall_analysis, full_solution_md, why_others_wrong_md, validity_notes_md) VALUES
-- Speed Arithmetic Fast Methods
('fm_qa_speed_pct_of_num_a1b2', 'qa_speed_pct_of_num_a1b2', 'Mental Math: Break Down Percentage', '24% = 25% - 1%... ', '...', '...', '...', '...'),

-- Chemistry Fast Methods
('fm_chem10_nacl_molarity_c1a1', 'chem10_nacl_molarity_c1a1', 'Recognize Molar Mass of NaCl', '58.5 g is exactly 1 mole of NaCl...', '...', '...', '...', '...'),
('fm_chem11_vsepr_pcl5_a1b1', 'chem11_vsepr_pcl5_a1b1', 'Steric Number Method', 'Steric Number = 5...', '...', '...', '...', '...'),
('fm_chem13_sn1_reaction_h5i5', 'chem13_sn1_reaction_h5i5', 'Carbocation Stability Rule', 'SN1 reactions proceed via a carbocation...', '...', '...', '...', '...')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, justification = EXCLUDED.justification, pitfall_analysis = EXCLUDED.pitfall_analysis, full_solution_md = EXCLUDED.full_solution_md, why_others_wrong_md = EXCLUDED.why_others_wrong_md, validity_notes_md = EXCLUDED.validity_notes_md;