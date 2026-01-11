-- =================================================================
-- 07_data_public.sql - Sample Data for Public Schema
-- =================================================================
-- This file inserts sample data into public schema tables
-- Execute this after creating tables and functions
-- =================================================================

-- Insert sample data into leads table
INSERT INTO public.leads (id, user_id, group_id, name, email, contact, description, other, created_at, updated_at, lead_type, project) VALUES
('b193a577-738d-4dcb-bdce-3e65e592d3c8', '9635b742-1d28-43a5-9f95-0cde26cdb913', NULL, 'Masters-AI Services Pvt Ltd', 'contact@masterssoluctions.com', '+1-9090321456', 'Service Based Company - providing AI-ML Service, Texas-USA', NULL, '2026-01-02 10:51:09.186481+00', '2026-01-02 10:51:09.186481+00', 'Hot', 'AI Customer Support Assistant'),
('f8bf9080-b3b0-41d9-9759-3dcb20e35e04', '9635b742-1d28-43a5-9f95-0cde26cdb913', NULL, 'Jacob & Sons Ltd', 'contact@jacobandsons.com', '+1-9812450175', 'IT Services Company, Totentoo-CA', NULL, '2026-01-04 06:43:28.415654+00', '2026-01-04 06:43:28.415654+00', 'Cold', 'E-Commerce Platform Redesign');

-- Insert sample data into company_brain table
INSERT INTO public.company_brain (id, user_id, company_name, company_tagline, company_description, industry, founded_year, company_size, headquarters_location, website_url, contact_email, contact_phone, mission_statement, vision_statement, core_values, unique_selling_points, target_audience, products_services, pricing_model, key_features, founder_info, leadership_team, team_size_details, additional_context, custom_fields, created_at, updated_at) VALUES
('959663c2-5efe-456b-a5bf-f6e7b5e3142f', '9635b742-1d28-43a5-9f95-0cde26cdb913', 'CEIPAL', 'Intelligent Talent Cloud for Recruiting and Workforce Management', 'CEIPAL is a cloud-native AI-powered talent platform that helps enterprises and staffing agencies automate recruiting, applicant tracking, candidate sourcing, vendor management, and workforce operations. The platform unifies ATS, CRM, VMS, and workforce tools into a single system, enabling faster hiring, improved talent engagement, deeper analytics, and better operational visibility.', 'HR Tech | SaaS | Talent Management | Recruitment Software', 2015, '500â€“1000 employees', 'New Jersey, USA', 'https://www.ceipal.com', 'contact@ceipal.com', '+1 (844) 234-2455', 'To transform hiring and workforce management with intelligent automation, enabling organizations to build better talent experiences and achieve operational excellence.', 'To be the world''s most trusted platform for talent acquisition and workforce orchestration, powered by data and AI.', ARRAY['Innovation', 'Customer Success', 'Integrity', 'Collaboration', 'Continuous Learning'], ARRAY['AI-powered talent matching and ranking', 'Unified ATS + VMS platform', 'End-to-end workforce automation', 'Real-time analytics and reporting'], 'Staffing firms, enterprise HR teams, MSPs, talent acquisition leaders, operations managers', '{}', 'Subscription (SaaS)', ARRAY['AI candidate matching and ranking', 'Applicant tracking system (ATS)', 'Vendor management system (VMS)', 'Workforce management tools', 'Recruitment CRM', 'Real-time analytics and dashboards', 'Resume parsing and job board integrations', 'Compliance and credentialing'], 'CEIPAL was founded by industry veterans with deep experience in recruiting, staffing technology, and enterprise software.', '{}', 'Cross-functional teams in product, engineering, sales, support, and customer success; global operations across multiple regions.', '', '{}', '2026-01-02 06:49:52.704986+00', '2026-01-02 08:49:10.665521+00');

-- Insert sample data into document_groups table
INSERT INTO public.document_groups (id, user_id, group_name, description, created_at, updated_at) VALUES
('4c35af99-bec3-4f2a-9b5d-aa43b10914c3', '9635b742-1d28-43a5-9f95-0cde26cdb913', 'Sales Documents', NULL, '2026-01-02 08:48:11.041265+00', '2026-01-02 08:48:11.041265+00'),
('c0b37bd7-b637-42f2-8c6f-c3ba044b1c7b', '9635b742-1d28-43a5-9f95-0cde26cdb913', 'Marketing Materials', NULL, '2026-01-02 08:30:10.17494+00', '2026-01-02 08:30:10.17494+00');

-- Insert sample data into brain_documents table (without actual files)
-- Note: storage_url should be updated with actual URLs after uploading files
INSERT INTO public.brain_documents (id, user_id, company_brain_id, file_name, file_type, file_size, storage_path, storage_url, mime_type, title, description, tags, category, status, extracted_text, created_at, updated_at, document_group_id) VALUES
('11cc80f4-34c2-4941-8c7c-e11d6413e77e', '9635b742-1d28-43a5-9f95-0cde26cdb913', NULL, 'Ceipal .pdf', 'pdf', 106009, '9635b742-1d28-43a5-9f95-0cde26cdb913/1767343690503-Ceipal .pdf', 'https://YOUR_PROJECT_URL.supabase.co/storage/v1/object/public/brain-documents/9635b742-1d28-43a5-9f95-0cde26cdb913/1767343690503-Ceipal%20.pdf', 'application/pdf', NULL, NULL, ARRAY['sales'], 'product', 'uploaded', NULL, '2026-01-02 08:48:11.041265+00', '2026-01-02 08:48:11.041265+00', '4c35af99-bec3-4f2a-9b5d-aa43b10914c3'),
('b6e48f0f-ec19-434e-936f-cb0680623c2d', '9635b742-1d28-43a5-9f95-0cde26cdb913', NULL, 'Demo-image', 'image', 375537, '9635b742-1d28-43a5-9f95-0cde26cdb913/1767342609072-WhatsApp Image 2026-01-02 at 13.52.17.jpeg', 'https://YOUR_PROJECT_URL.supabase.co/storage/v1/object/public/brain-documents/9635b742-1d28-43a5-9f95-0cde26cdb913/1767342609072-WhatsApp%20Image%202026-01-02%20at%2013.52.17.jpeg', 'image/jpeg', NULL, NULL, ARRAY['Marketing'], 'Engineering', 'uploaded', NULL, '2026-01-02 08:30:10.17494+00', '2026-01-02 08:48:54.304559+00', 'c0b37bd7-b637-42f2-8c6f-c3ba044b1c7b');

-- Insert sample data into projects table
INSERT INTO public.projects (id, company_id, created_by, project_name, description, status, start_date, end_date, is_deleted, created_at, updated_at) VALUES
('f77e19d9-8f5d-409b-ae86-f532ecb261cd', '9635b742-1d28-43a5-9f95-0cde26cdb913', '9635b742-1d28-43a5-9f95-0cde26cdb913', 'Ceipal ATS (Application Tracking System)', 'The intelligent, end-to-end ATS for total talent management', 'active', '2026-01-01 00:00:00+00', '2026-01-30 00:00:00+00', false, '2026-01-05 07:43:53.882029+00', '2026-01-05 09:23:30.173333+00');

-- Note: For recordings, analyses, and other tables with complex data,
-- please refer to the actual data export or manually insert as needed

-- Insert storage buckets
INSERT INTO storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) VALUES
('brain-documents', 'brain-documents', NULL, '2026-01-02 06:45:00.467687+00', '2026-01-02 06:45:00.467687+00', true, false, 52428800, ARRAY['application/pdf', 'image/png', 'image/jpeg', 'image/jpg', 'image/gif', 'image/webp', 'audio/mpeg', 'audio/mp3', 'audio/wav', 'audio/ogg', 'video/mp4', 'video/webm', 'video/quicktime', 'text/plain', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'], NULL, 'STANDARD'),
('project-documents', 'project-documents', NULL, '2026-01-03 05:44:54.39316+00', '2026-01-03 05:44:54.39316+00', true, false, 52428800, ARRAY['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'text/plain', 'image/png', 'image/jpeg', 'image/jpg', 'image/gif', 'image/webp'], NULL, 'STANDARD');

-- ============================================
-- Notes for Data Migration:
-- ============================================
-- 1. Update all storage URLs with your actual Supabase project URL
-- 2. Recording transcripts and analysis data are too large to include here
--    Export them separately using pg_dump or Supabase CLI
-- 3. Embeddings data (vector columns) should be regenerated using the 
--    regenerate-embeddings and regenerate-project-embeddings edge functions
-- 4. Sample transcripts table data is in a separate file due to size
-- =================================================================
-- 08_sample_transcripts.sql - Sample Transcripts Data
-- =================================================================
-- This file contains sample transcript data
-- Execute this after running 07_data_public.sql
-- =================================================================

-- Note: Due to the length of transcripts, only metadata is shown here
-- Full transcripts should be loaded from your backup or application

-- The sample_transcripts table contains 5 records with various call scenarios
-- These are used for testing and demonstration purposes

-- To load the actual transcript data, you can either:
-- 1. Use the application's UI to upload sample transcripts
-- 2. Export from your existing database using:
--    pg_dump -U postgres -h your-host -d your-db -t sample_transcripts --data-only --column-inserts > sample_transcripts_data.sql
-- 3. Use the Supabase CLI to export data:
--    supabase db dump -f sample_transcripts.sql --data-only --schema public --table sample_transcripts

-- Sample structure (without full transcript text due to size):
-- INSERT INTO public.sample_transcripts (id, title, description, transcript, category, tags, created_at, updated_at) VALUES
-- ('82018a66-dfbe-46aa-b355-2e719fcfd543', 'ATS Demo - TalentPro Staffing Agency', 'Successful demo call...', '...full transcript...', 'Warm', ARRAY['staffing-agency','demo-scheduled'], '2026-01-10 14:58:07.315186+00', '2026-01-10 14:58:07.315186+00');

-- For production use, load sample transcripts from:
-- - Sample Call Transcripts folder in your project
-- - Database export
-- - Application seeding script
