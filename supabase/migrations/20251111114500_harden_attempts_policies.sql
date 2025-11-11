-- Tighten row-level security on attempts table

-- Remove overly permissive policies if they exist
DROP POLICY IF EXISTS "Anyone can insert attempts" ON public.attempts;
DROP POLICY IF EXISTS "Anyone can view attempts" ON public.attempts;

-- Allow public (anon) clients to insert attempts while blocking other roles
CREATE POLICY "Anon can log attempts"
  ON public.attempts
  FOR INSERT
  WITH CHECK (auth.role() = 'anon' OR auth.role() = 'service_role');

-- Hide attempts from anonymous readers; only service role (e.g. Edge Functions) can read
CREATE POLICY "Service role can view attempts"
  ON public.attempts
  FOR SELECT
  USING (auth.role() = 'service_role');
