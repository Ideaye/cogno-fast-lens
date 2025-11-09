export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "13.0.5"
  }
  public: {
    Tables: {
      attempts: {
        Row: {
          confidence_0_1: number | null
          correct: boolean | null
          course_id: string
          created_at: string | null
          device_id: string
          free_response: string | null
          id: string
          question_id: string
          selected_key: string | null
          skipped: boolean | null
          time_taken_ms: number
          time_to_first_action_ms: number | null
        }
        Insert: {
          confidence_0_1?: number | null
          correct?: boolean | null
          course_id: string
          created_at?: string | null
          device_id: string
          free_response?: string | null
          id?: string
          question_id: string
          selected_key?: string | null
          skipped?: boolean | null
          time_taken_ms: number
          time_to_first_action_ms?: number | null
        }
        Update: {
          confidence_0_1?: number | null
          correct?: boolean | null
          course_id?: string
          created_at?: string | null
          device_id?: string
          free_response?: string | null
          id?: string
          question_id?: string
          selected_key?: string | null
          skipped?: boolean | null
          time_taken_ms?: number
          time_to_first_action_ms?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "attempts_course_id_fkey"
            columns: ["course_id"]
            isOneToOne: false
            referencedRelation: "courses"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attempts_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      courses: {
        Row: {
          board: string
          created_at: string | null
          grade: number
          id: string
          is_public: boolean | null
          slug: string
          subject: string
          title: string
          updated_at: string | null
        }
        Insert: {
          board: string
          created_at?: string | null
          grade: number
          id?: string
          is_public?: boolean | null
          slug: string
          subject: string
          title: string
          updated_at?: string | null
        }
        Update: {
          board?: string
          created_at?: string | null
          grade?: number
          id?: string
          is_public?: boolean | null
          slug?: string
          subject?: string
          title?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      fast_methods: {
        Row: {
          checks_notes_md: string | null
          created_at: string | null
          fast_steps_md: string
          id: string
          question_id: string
          short_justification_md: string
          updated_at: string | null
          validated: boolean | null
          why_others_wrong_md: string | null
        }
        Insert: {
          checks_notes_md?: string | null
          created_at?: string | null
          fast_steps_md: string
          id?: string
          question_id: string
          short_justification_md: string
          updated_at?: string | null
          validated?: boolean | null
          why_others_wrong_md?: string | null
        }
        Update: {
          checks_notes_md?: string | null
          created_at?: string | null
          fast_steps_md?: string
          id?: string
          question_id?: string
          short_justification_md?: string
          updated_at?: string | null
          validated?: boolean | null
          why_others_wrong_md?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "fast_methods_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: true
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      questions: {
        Row: {
          concept_tags: string[] | null
          correct_key: string | null
          course_id: string
          created_at: string | null
          difficulty_1_5: number | null
          id: string
          options: Json | null
          solution_steps_md: string | null
          stem_md: string
          time_budget_sec: number | null
          type: string
          updated_at: string | null
        }
        Insert: {
          concept_tags?: string[] | null
          correct_key?: string | null
          course_id: string
          created_at?: string | null
          difficulty_1_5?: number | null
          id?: string
          options?: Json | null
          solution_steps_md?: string | null
          stem_md: string
          time_budget_sec?: number | null
          type: string
          updated_at?: string | null
        }
        Update: {
          concept_tags?: string[] | null
          correct_key?: string | null
          course_id?: string
          created_at?: string | null
          difficulty_1_5?: number | null
          id?: string
          options?: Json | null
          solution_steps_md?: string | null
          stem_md?: string
          time_budget_sec?: number | null
          type?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "questions_course_id_fkey"
            columns: ["course_id"]
            isOneToOne: false
            referencedRelation: "courses"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
