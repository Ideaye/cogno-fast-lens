export interface Course {
  id: string;
  slug?: string | null;
  title?: string | null;
  name?: string | null;
  board?: string | null;
  grade?: number | null;
  subject?: string | null;
  is_public?: boolean | null;
  created_at?: string | null;
  updated_at?: string | null;
}

export interface QuestionOption {
  key: string;
  text: string;
}

export interface Question {
  id: string;
  course_id: string;
  type: 'MCQ' | 'FR';
  stem_md: string;
  options: QuestionOption[] | null;
  correct_key: string | null;
  solution_steps_md: string | null;
  concept_tags: string[];
  difficulty_1_5?: number | null;
  time_budget_sec?: number | null;
  created_at?: string | null;
  updated_at?: string | null;
}

export interface FastMethod {
  id: string;
  question_id: string;
  short_justification_md: string;
  fast_steps_md: string;
  why_others_wrong_md: string | null;
  checks_notes_md: string | null;
  validated?: boolean | null;
  created_at?: string | null;
  updated_at?: string | null;
  title?: string | null;
  pitfall_analysis?: string | null;
  full_solution_md?: string | null;
}

export interface Attempt {
  id: string;
  device_id: string;
  course_id: string;
  question_id: string;
  selected_key: string | null;
  free_response: string | null;
  correct: boolean | null;
  time_taken_ms: number;
  time_to_first_action_ms: number | null;
  confidence_0_1: number | null;
  skipped: boolean;
  created_at: string;
}
