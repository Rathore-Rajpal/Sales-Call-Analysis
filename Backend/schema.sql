-- =================================================================
-- 01_extensions.sql - Extensions Setup
-- =================================================================
-- This file installs all required PostgreSQL extensions
-- Run this file first before creating tables
-- =================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pgcrypto" SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "vector" SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "pg_net" SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "supabase_vault" SCHEMA vault;
CREATE EXTENSION IF NOT EXISTS "pg_graphql" SCHEMA graphql;
CREATE EXTENSION IF NOT EXISTS "pg_cron" SCHEMA pg_catalog;
CREATE EXTENSION IF NOT EXISTS "plpgsql" SCHEMA pg_catalog;

-- Note: Some extensions may require superuser privileges
-- If you encounter permission errors, contact your database administrator
-- =================================================================
-- 02_tables_public.sql - Public Schema Tables
-- =================================================================
-- This file creates all tables in the public schema
-- =================================================================

-- Table: user_profiles
CREATE TABLE IF NOT EXISTS public.user_profiles (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL UNIQUE,
    email TEXT NOT NULL,
    full_name TEXT,
    avatar_url TEXT,
    company_name TEXT,
    company_email TEXT,
    company_industry TEXT,
    position TEXT,
    use_cases TEXT[],
    onboarding_completed BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id)
);

-- Table: lead_groups
CREATE TABLE IF NOT EXISTS public.lead_groups (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    group_name VARCHAR NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id)
);

-- Table: leads
CREATE TABLE IF NOT EXISTS public.leads (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    group_id UUID,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    contact VARCHAR NOT NULL,
    description TEXT,
    other JSONB,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    lead_type TEXT,
    project TEXT,
    PRIMARY KEY (id),
    CONSTRAINT leads_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.lead_groups(id)
);

-- Table: company_brain
CREATE TABLE IF NOT EXISTS public.company_brain (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL UNIQUE,
    company_name TEXT,
    company_tagline TEXT,
    company_description TEXT,
    industry TEXT,
    founded_year INTEGER,
    company_size TEXT,
    headquarters_location TEXT,
    website_url TEXT,
    contact_email TEXT,
    contact_phone TEXT,
    mission_statement TEXT,
    vision_statement TEXT,
    core_values TEXT[],
    unique_selling_points TEXT[],
    target_audience TEXT,
    products_services JSONB,
    pricing_model TEXT,
    key_features TEXT[],
    founder_info TEXT,
    leadership_team JSONB,
    team_size_details TEXT,
    additional_context TEXT,
    custom_fields JSONB,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id),
    COMMENT ON TABLE public.company_brain IS 'Stores company knowledge base and information for AI bot'
);

-- Table: document_groups
CREATE TABLE IF NOT EXISTS public.document_groups (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    group_name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id)
);

-- Table: brain_documents
CREATE TABLE IF NOT EXISTS public.brain_documents (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    company_brain_id UUID,
    file_name TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size BIGINT,
    storage_path TEXT NOT NULL,
    storage_url TEXT,
    mime_type TEXT,
    title TEXT,
    description TEXT,
    tags TEXT[],
    category TEXT,
    status TEXT DEFAULT 'uploaded',
    extracted_text TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    document_group_id UUID,
    PRIMARY KEY (id),
    CONSTRAINT brain_documents_company_brain_id_fkey FOREIGN KEY (company_brain_id) REFERENCES public.company_brain(id),
    CONSTRAINT brain_documents_document_group_id_fkey FOREIGN KEY (document_group_id) REFERENCES public.document_groups(id),
    COMMENT ON TABLE public.brain_documents IS 'Stores uploaded documents (PDFs, images, audio, video) for company brain',
    COMMENT ON COLUMN public.brain_documents.extracted_text IS 'Extracted/transcribed text content for search and AI processing'
);

-- Table: company_brain_embeddings
CREATE TABLE IF NOT EXISTS public.company_brain_embeddings (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    content_type TEXT NOT NULL,
    content_id UUID,
    content TEXT NOT NULL,
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    embedding vector,
    PRIMARY KEY (id)
);

-- Table: projects
CREATE TABLE IF NOT EXISTS public.projects (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL,
    created_by UUID NOT NULL,
    project_name TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'on_hold', 'completed', 'archived')),
    start_date TIMESTAMPTZ,
    end_date TIMESTAMPTZ,
    is_deleted BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id),
    COMMENT ON TABLE public.projects IS 'Stores projects scoped under a company'
);

-- Table: project_metadata
CREATE TABLE IF NOT EXISTS public.project_metadata (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL UNIQUE,
    company_id UUID NOT NULL,
    domain TEXT,
    industry TEXT,
    tech_stack TEXT[],
    project_type TEXT,
    target_audience TEXT,
    key_goals TEXT[],
    requirements TEXT,
    milestones JSONB,
    team_size TEXT,
    budget_range TEXT,
    priority_level TEXT CHECK (priority_level IN ('low', 'medium', 'high', 'critical')),
    custom_fields JSONB DEFAULT '{}'::jsonb,
    additional_context TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    pricing_information TEXT,
    PRIMARY KEY (id),
    CONSTRAINT project_metadata_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id),
    COMMENT ON COLUMN public.project_metadata.pricing_information IS 'Pricing details, quote guidelines, and ROI information for sales team reference'
);

-- Table: project_documents
CREATE TABLE IF NOT EXISTS public.project_documents (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL,
    company_id UUID NOT NULL,
    uploaded_by UUID NOT NULL,
    file_name TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size BIGINT,
    mime_type TEXT,
    storage_path TEXT NOT NULL,
    storage_url TEXT,
    title TEXT,
    description TEXT,
    tags TEXT[],
    category TEXT,
    extracted_text TEXT,
    status TEXT DEFAULT 'uploaded' CHECK (status IN ('uploaded', 'processing', 'processed', 'failed')),
    is_deleted BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id),
    CONSTRAINT project_documents_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id)
);

-- Table: project_embeddings
CREATE TABLE IF NOT EXISTS public.project_embeddings (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL,
    company_id UUID NOT NULL,
    content_type TEXT NOT NULL CHECK (content_type IN ('project_metadata', 'document', 'document_chunk')),
    content_id UUID,
    content TEXT NOT NULL,
    metadata JSONB DEFAULT '{}'::jsonb,
    embedding vector,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id),
    CONSTRAINT project_embeddings_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id)
);

-- Table: recordings
CREATE TABLE IF NOT EXISTS public.recordings (
    id UUID NOT NULL DEFAULT extensions.uuid_generate_v4(),
    user_id UUID NOT NULL,
    file_name TEXT,
    file_size BIGINT,
    stored_file_url TEXT,
    duration_seconds INTEGER,
    transcript TEXT,
    created_at TIMESTAMP DEFAULT now(),
    lead_id UUID,
    call_date TIMESTAMPTZ,
    project_id UUID,
    PRIMARY KEY (id),
    CONSTRAINT recordings_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.leads(id),
    CONSTRAINT recordings_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id),
    COMMENT ON COLUMN public.recordings.lead_id IS 'Foreign key reference to the lead associated with this recording',
    COMMENT ON COLUMN public.recordings.call_date IS 'The date and time when the call actually took place (as provided by user)',
    COMMENT ON COLUMN public.recordings.project_id IS 'The project this recording is associated with'
);

-- Table: analyses
CREATE TABLE IF NOT EXISTS public.analyses (
    id UUID NOT NULL DEFAULT extensions.uuid_generate_v4(),
    recording_id UUID,
    user_id UUID NOT NULL,
    status VARCHAR DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT now(),
    participants JSONB,
    lead_type TEXT,
    sentiments_score NUMERIC,
    engagement_score NUMERIC,
    confidence_score_executive NUMERIC,
    confidence_score_person NUMERIC,
    objections_handeled TEXT,
    next_steps TEXT,
    improvements TEXT,
    call_outcome TEXT,
    short_summary TEXT,
    lead_type_explanation TEXT,
    sentiments_explanation TEXT,
    engagement_explanation TEXT,
    confidence_explanation_executive TEXT,
    confidence_explanation_person TEXT,
    objections_detected TEXT,
    objections_handling_details TEXT,
    next_steps_detailed TEXT,
    improvements_for_team TEXT,
    call_outcome_rationale TEXT,
    evidence_quotes TEXT,
    no_of_objections_detected INTEGER,
    no_of_objections_handeled INTEGER,
    ceipal_context_used TEXT,
    project_context_used TEXT,
    company_accuracy_score INTEGER,
    company_accuracy_reasoning TEXT,
    project_accuracy_score INTEGER,
    project_accuracy_reasoning TEXT,
    PRIMARY KEY (id),
    CONSTRAINT analyses_recording_id_fkey FOREIGN KEY (recording_id) REFERENCES public.recordings(id),
    COMMENT ON COLUMN public.analyses.ceipal_context_used IS 'Details about how CEIPAL company knowledge was used in analysis',
    COMMENT ON COLUMN public.analyses.project_context_used IS 'Details about how project-specific knowledge was used in analysis',
    COMMENT ON COLUMN public.analyses.company_accuracy_score IS 'Score (0-100) indicating accuracy of company information used in the call',
    COMMENT ON COLUMN public.analyses.company_accuracy_reasoning IS 'Explanation of the company accuracy score',
    COMMENT ON COLUMN public.analyses.project_accuracy_score IS 'Score (0-100) indicating accuracy of project information used in the call',
    COMMENT ON COLUMN public.analyses.project_accuracy_reasoning IS 'Explanation of the project accuracy score'
);

-- Table: metrics_aggregates
CREATE TABLE IF NOT EXISTS public.metrics_aggregates (
    id UUID NOT NULL DEFAULT extensions.uuid_generate_v4(),
    user_id UUID NOT NULL,
    date DATE NOT NULL,
    total_calls INTEGER,
    avg_sentiment NUMERIC,
    avg_engagement NUMERIC,
    conversion_rate NUMERIC,
    objections_rate NUMERIC,
    PRIMARY KEY (id)
);

-- Table: sample_transcripts
CREATE TABLE IF NOT EXISTS public.sample_transcripts (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    transcript TEXT NOT NULL,
    category TEXT,
    tags TEXT[],
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (id)
);

-- Add comments
COMMENT ON TABLE public.user_profiles IS 'User profile information';
COMMENT ON TABLE public.lead_groups IS 'Groups for organizing leads';
COMMENT ON TABLE public.leads IS 'Lead contact information';
COMMENT ON TABLE public.recordings IS 'Call recordings and transcripts';
COMMENT ON TABLE public.analyses IS 'AI analysis results for recordings';
COMMENT ON TABLE public.company_brain_embeddings IS 'Vector embeddings for company knowledge';
COMMENT ON TABLE public.project_embeddings IS 'Vector embeddings for project knowledge';
COMMENT ON TABLE public.sample_transcripts IS 'Sample call transcripts for testing';
-- =================================================================
-- 03_tables_storage.sql - Storage Schema Tables
-- =================================================================
-- This file creates all tables in the storage schema
-- =================================================================

-- Table: storage.buckets
CREATE TABLE IF NOT EXISTS storage.buckets (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    owner UUID,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    public BOOLEAN DEFAULT false,
    avif_autodetection BOOLEAN DEFAULT false,
    file_size_limit BIGINT,
    allowed_mime_types TEXT[],
    owner_id TEXT,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype,
    PRIMARY KEY (id),
    COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead'
);

-- Table: storage.objects
CREATE TABLE IF NOT EXISTS storage.objects (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    bucket_id TEXT,
    name TEXT,
    owner UUID,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    last_accessed_at TIMESTAMPTZ DEFAULT now(),
    metadata JSONB,
    path_tokens TEXT[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version TEXT,
    owner_id TEXT,
    user_metadata JSONB,
    level INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT objects_bucketId_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id),
    COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead'
);

-- Table: storage.prefixes
CREATE TABLE IF NOT EXISTS storage.prefixes (
    bucket_id TEXT NOT NULL,
    name TEXT NOT NULL,
    level INTEGER GENERATED ALWAYS AS (storage.get_level(name)) STORED,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (bucket_id, name, level),
    CONSTRAINT prefixes_bucketId_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id)
);

-- Table: storage.s3_multipart_uploads
CREATE TABLE IF NOT EXISTS storage.s3_multipart_uploads (
    id TEXT NOT NULL,
    in_progress_size BIGINT NOT NULL DEFAULT 0,
    upload_signature TEXT NOT NULL,
    bucket_id TEXT NOT NULL,
    key TEXT NOT NULL,
    version TEXT NOT NULL,
    owner_id TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    user_metadata JSONB,
    PRIMARY KEY (id),
    CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id)
);

-- Table: storage.s3_multipart_uploads_parts
CREATE TABLE IF NOT EXISTS storage.s3_multipart_uploads_parts (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    upload_id TEXT NOT NULL,
    size BIGINT NOT NULL DEFAULT 0,
    part_number INTEGER NOT NULL,
    bucket_id TEXT NOT NULL,
    key TEXT NOT NULL,
    etag TEXT NOT NULL,
    owner_id TEXT,
    version TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (id),
    CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id),
    CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id)
);

-- Table: storage.migrations
CREATE TABLE IF NOT EXISTS storage.migrations (
    id INTEGER NOT NULL,
    name VARCHAR NOT NULL UNIQUE,
    hash VARCHAR NOT NULL,
    executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- Table: storage.buckets_analytics
CREATE TABLE IF NOT EXISTS storage.buckets_analytics (
    name TEXT NOT NULL,
    type storage.buckettype NOT NULL DEFAULT 'ANALYTICS'::storage.buckettype,
    format TEXT NOT NULL DEFAULT 'ICEBERG'::text,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    deleted_at TIMESTAMPTZ,
    PRIMARY KEY (id)
);

-- Table: storage.buckets_vectors
CREATE TABLE IF NOT EXISTS storage.buckets_vectors (
    id TEXT NOT NULL,
    type storage.buckettype NOT NULL DEFAULT 'VECTOR'::storage.buckettype,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (id)
);

-- Table: storage.vector_indexes
CREATE TABLE IF NOT EXISTS storage.vector_indexes (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    bucket_id TEXT NOT NULL,
    data_type TEXT NOT NULL,
    dimension INTEGER NOT NULL,
    distance_metric TEXT NOT NULL,
    metadata_configuration JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (id),
    CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id)
);
-- =================================================================
-- 04_functions_public.sql - Public Schema Functions
-- =================================================================
-- This file creates all custom functions in the public schema
-- Note: Vector extension functions are omitted as they come with the extension
-- =================================================================

-- Function: update_updated_at_column
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$function$;

-- Function: cleanup_project_data_on_delete
CREATE OR REPLACE FUNCTION public.cleanup_project_data_on_delete()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
BEGIN
  -- When a project is deleted, also delete all embeddings
  DELETE FROM project_embeddings WHERE project_id = OLD.id;
  
  -- Delete all documents
  DELETE FROM project_documents WHERE project_id = OLD.id;
  
  -- Delete metadata
  DELETE FROM project_metadata WHERE project_id = OLD.id;
  
  RETURN OLD;
END;
$function$;

-- Function: create_project_with_metadata
CREATE OR REPLACE FUNCTION public.create_project_with_metadata(
    p_company_id uuid, 
    p_created_by uuid, 
    p_project_name text, 
    p_description text DEFAULT NULL::text, 
    p_domain text DEFAULT NULL::text, 
    p_industry text DEFAULT NULL::text, 
    p_tech_stack text[] DEFAULT NULL::text[], 
    p_project_type text DEFAULT NULL::text, 
    p_target_audience text DEFAULT NULL::text, 
    p_key_goals text[] DEFAULT NULL::text[], 
    p_requirements text DEFAULT NULL::text, 
    p_additional_context text DEFAULT NULL::text
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
    v_project_id UUID;
    v_metadata_id UUID;
    v_result JSON;
BEGIN
    INSERT INTO public.projects (
        company_id, created_by, project_name, description
    ) VALUES (
        p_company_id, p_created_by, p_project_name, p_description
    )
    RETURNING id INTO v_project_id;
    
    INSERT INTO public.project_metadata (
        project_id, company_id, domain, industry, tech_stack, project_type,
        target_audience, key_goals, requirements, additional_context
    ) VALUES (
        v_project_id, p_company_id, p_domain, p_industry, p_tech_stack, p_project_type,
        p_target_audience, p_key_goals, p_requirements, p_additional_context
    )
    RETURNING id INTO v_metadata_id;
    
    v_result := json_build_object(
        'project_id', v_project_id,
        'metadata_id', v_metadata_id,
        'success', true
    );
    
    RETURN v_result;
END;
$function$;

-- Function: get_project_stats
CREATE OR REPLACE FUNCTION public.get_project_stats(p_project_id uuid)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
    v_stats JSON;
BEGIN
    SELECT json_build_object(
        'project_id', p_project_id,
        'document_count', COUNT(DISTINCT pd.id),
        'embedding_count', COUNT(DISTINCT pe.id),
        'total_content_size', COALESCE(SUM(pd.file_size), 0),
        'last_updated', MAX(GREATEST(pd.updated_at, pe.updated_at))
    )
    INTO v_stats
    FROM public.projects p
    LEFT JOIN public.project_documents pd ON p.id = pd.project_id AND pd.is_deleted = false
    LEFT JOIN public.project_embeddings pe ON p.id = pe.project_id
    WHERE p.id = p_project_id;
    
    RETURN v_stats;
END;
$function$;

-- Function: hard_delete_project
CREATE OR REPLACE FUNCTION public.hard_delete_project(p_project_id uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
  doc_record RECORD;
BEGIN
  -- 1. Delete all embeddings for this project
  DELETE FROM project_embeddings
  WHERE project_id = p_project_id;
  
  -- 2. Get all documents to delete from storage
  FOR doc_record IN 
    SELECT storage_path 
    FROM project_documents 
    WHERE project_id = p_project_id AND storage_path IS NOT NULL
  LOOP
    -- Note: Storage deletion should be handled by the application layer
    -- This just removes the database record
    NULL;
  END LOOP;
  
  -- 3. Delete all project documents
  DELETE FROM project_documents
  WHERE project_id = p_project_id;
  
  -- 4. Delete project metadata
  DELETE FROM project_metadata
  WHERE project_id = p_project_id;
  
  -- 5. Finally, delete the project itself
  DELETE FROM projects
  WHERE id = p_project_id;
  
  RETURN FOUND;
END;
$function$;

-- Function: soft_delete_project
CREATE OR REPLACE FUNCTION public.soft_delete_project(p_project_id uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
BEGIN
  RETURN hard_delete_project(p_project_id);
END;
$function$;

-- Function: update_project_metadata
CREATE OR REPLACE FUNCTION public.update_project_metadata(
    p_project_id uuid, 
    p_domain text DEFAULT NULL::text, 
    p_industry text DEFAULT NULL::text, 
    p_tech_stack text[] DEFAULT NULL::text[], 
    p_project_type text DEFAULT NULL::text, 
    p_target_audience text DEFAULT NULL::text, 
    p_key_goals text[] DEFAULT NULL::text[], 
    p_requirements text DEFAULT NULL::text, 
    p_additional_context text DEFAULT NULL::text
)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
BEGIN
    UPDATE public.project_metadata
    SET 
        domain = COALESCE(p_domain, domain),
        industry = COALESCE(p_industry, industry),
        tech_stack = COALESCE(p_tech_stack, tech_stack),
        project_type = COALESCE(p_project_type, project_type),
        target_audience = COALESCE(p_target_audience, target_audience),
        key_goals = COALESCE(p_key_goals, key_goals),
        requirements = COALESCE(p_requirements, requirements),
        additional_context = COALESCE(p_additional_context, additional_context),
        updated_at = now()
    WHERE project_id = p_project_id;
    
    RETURN FOUND;
END;
$function$;

-- Function: trigger_project_document_embedding
CREATE OR REPLACE FUNCTION public.trigger_project_document_embedding()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
  request_id BIGINT;
BEGIN
  -- For DELETE or soft delete, remove embeddings
  IF TG_OP = 'DELETE' OR (TG_OP = 'UPDATE' AND NEW.is_deleted = true AND OLD.is_deleted = false) THEN
    DELETE FROM project_embeddings
    WHERE project_id = COALESCE(NEW.project_id, OLD.project_id)
    AND content_type = 'document'
    AND content_id = COALESCE(NEW.id, OLD.id);
    RETURN COALESCE(NEW, OLD);
  END IF;

  -- For INSERT or UPDATE (when not deleted), call edge function
  -- NOTE: Update the URL and Bearer token with your actual values
  IF NEW.is_deleted = false THEN
    SELECT net.http_post(
      url := 'https://YOUR_PROJECT_URL.supabase.co/functions/v1/generate-project-embedding',
      headers := jsonb_build_object(
        'Authorization', 'Bearer YOUR_SERVICE_ROLE_KEY',
        'Content-Type', 'application/json'
      ),
      body := jsonb_build_object(
        'type', 'document',
        'project_id', NEW.project_id,
        'company_id', NEW.company_id,
        'document_id', NEW.id
      )
    ) INTO request_id;
  END IF;

  RETURN NEW;
END;
$function$;

-- Function: trigger_project_metadata_embedding
CREATE OR REPLACE FUNCTION public.trigger_project_metadata_embedding()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
  request_id BIGINT;
BEGIN
  -- For DELETE operations, delete embeddings
  IF TG_OP = 'DELETE' THEN
    DELETE FROM project_embeddings
    WHERE project_id = OLD.project_id
    AND content_type = 'project_metadata';
    RETURN OLD;
  END IF;

  -- For INSERT or UPDATE, call edge function (it handles upsert)
  -- NOTE: Update the URL and Bearer token with your actual values
  SELECT net.http_post(
    url := 'https://YOUR_PROJECT_URL.supabase.co/functions/v1/generate-project-embedding',
    headers := jsonb_build_object(
      'Authorization', 'Bearer YOUR_SERVICE_ROLE_KEY',
      'Content-Type', 'application/json'
    ),
    body := jsonb_build_object(
      'type', 'metadata',
      'project_id', NEW.project_id,
      'company_id', NEW.company_id
    )
  ) INTO request_id;

  RETURN NEW;
END;
$function$;

-- Function: match_company_brain_documents
CREATE OR REPLACE FUNCTION public.match_company_brain_documents(
    query_embedding vector, 
    match_user_id uuid, 
    match_threshold double precision DEFAULT 0.7, 
    match_count integer DEFAULT 10
)
RETURNS TABLE(
    id uuid, 
    user_id uuid, 
    content_type text, 
    content_id uuid, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    company_brain_embeddings.id,
    company_brain_embeddings.user_id,
    company_brain_embeddings.content_type,
    company_brain_embeddings.content_id,
    company_brain_embeddings.content,
    company_brain_embeddings.metadata,
    1 - (company_brain_embeddings.embedding <=> query_embedding) AS similarity
  FROM company_brain_embeddings
  WHERE company_brain_embeddings.user_id = match_user_id
    AND 1 - (company_brain_embeddings.embedding <=> query_embedding) > match_threshold
  ORDER BY company_brain_embeddings.embedding <=> query_embedding
  LIMIT match_count;
END;
$function$;

-- Function: match_company_projects
CREATE OR REPLACE FUNCTION public.match_company_projects(
    p_query_embedding vector, 
    p_company_id uuid, 
    p_match_threshold double precision DEFAULT 0.7, 
    p_match_count integer DEFAULT 10
)
RETURNS TABLE(
    id uuid, 
    project_id uuid, 
    company_id uuid, 
    content_type text, 
    content_id uuid, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        pe.id,
        pe.project_id,
        pe.company_id,
        pe.content_type,
        pe.content_id,
        pe.content,
        pe.metadata,
        1 - (pe.embedding <=> p_query_embedding) AS similarity
    FROM public.project_embeddings pe
    WHERE 
        pe.company_id = p_company_id
        AND 1 - (pe.embedding <=> p_query_embedding) > p_match_threshold
    ORDER BY pe.embedding <=> p_query_embedding
    LIMIT p_match_count;
END;
$function$;

-- Function: match_project_documents
CREATE OR REPLACE FUNCTION public.match_project_documents(
    p_query_embedding vector, 
    p_project_id uuid, 
    p_match_threshold double precision DEFAULT 0.7, 
    p_match_count integer DEFAULT 10
)
RETURNS TABLE(
    id uuid, 
    project_id uuid, 
    company_id uuid, 
    content_type text, 
    content_id uuid, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        pe.id,
        pe.project_id,
        pe.company_id,
        pe.content_type,
        pe.content_id,
        pe.content,
        pe.metadata,
        1 - (pe.embedding <=> p_query_embedding) AS similarity
    FROM public.project_embeddings pe
    WHERE 
        pe.project_id = p_project_id
        AND 1 - (pe.embedding <=> p_query_embedding) > p_match_threshold
    ORDER BY pe.embedding <=> p_query_embedding
    LIMIT p_match_count;
END;
$function$;

-- Function: match_documents (overloaded version 1)
CREATE OR REPLACE FUNCTION public.match_documents(
    filter jsonb, 
    match_count integer, 
    query_embedding vector
)
RETURNS TABLE(
    id uuid, 
    user_id uuid, 
    content_type text, 
    content_id uuid, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    cbe.id,
    cbe.user_id,
    cbe.content_type,
    cbe.content_id,
    cbe.content,
    cbe.metadata,
    1 - (cbe.embedding <=> query_embedding) AS similarity
  FROM company_brain_embeddings cbe
  WHERE (
      filter = '{}'::jsonb
      OR cbe.metadata @> filter
    )
  ORDER BY cbe.embedding <=> query_embedding
  LIMIT match_count;
END;
$function$;

-- Function: match_documents (overloaded version 2)
CREATE OR REPLACE FUNCTION public.match_documents(
    p_table text, 
    p_query_embedding vector, 
    p_match_count integer DEFAULT 5, 
    p_filter jsonb DEFAULT '{}'::jsonb
)
RETURNS TABLE(
    id uuid, 
    project_id uuid, 
    company_id uuid, 
    content_type text, 
    content_id uuid, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY EXECUTE format(
    'SELECT id, project_id, company_id, content_type, content_id, content, metadata,
            1 - (embedding <=> $1) AS similarity
     FROM %I
     WHERE ($2 IS NULL OR metadata @> $2)
     ORDER BY embedding <=> $1
     LIMIT $3;',
    p_table
  )
  USING p_query_embedding, p_filter, p_match_count;
END;
$function$;

-- Function: search_project_context (overloaded version 1)
CREATE OR REPLACE FUNCTION public.search_project_context(
    filter jsonb, 
    match_count integer, 
    query_embedding vector
)
RETURNS TABLE(
    project_id uuid, 
    company_id uuid, 
    content_type text, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    pe.project_id,
    pe.company_id,
    pe.content_type,
    pe.content,
    pe.metadata,
    1 - (pe.embedding <=> query_embedding) AS similarity
  FROM project_embeddings pe
  WHERE (
      filter = '{}'::jsonb
      OR pe.metadata @> filter
    )
  ORDER BY pe.embedding <=> query_embedding
  LIMIT match_count;
END;
$function$;

-- Function: search_project_context (overloaded version 2)
CREATE OR REPLACE FUNCTION public.search_project_context(
    query_embedding vector, 
    match_count integer DEFAULT 5
)
RETURNS TABLE(
    project_id uuid, 
    company_id uuid, 
    content_type text, 
    content text, 
    metadata jsonb, 
    similarity double precision
)
LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    pe.project_id,
    pe.company_id,
    pe.content_type,
    pe.content,
    pe.metadata,
    1 - (pe.embedding <=> query_embedding) AS similarity
  FROM project_embeddings pe
  WHERE COALESCE(pe.is_deleted, false) IS false
  ORDER BY pe.embedding <=> query_embedding
  LIMIT match_count;
END;
$function$;

COMMENT ON FUNCTION public.update_updated_at_column() IS 'Automatically updates the updated_at column';
COMMENT ON FUNCTION public.cleanup_project_data_on_delete() IS 'Cleans up related data when a project is deleted';
COMMENT ON FUNCTION public.match_company_brain_documents(vector, uuid, double precision, integer) IS 'Semantic search for company brain documents';
COMMENT ON FUNCTION public.match_project_documents(vector, uuid, double precision, integer) IS 'Semantic search for project documents';
COMMENT ON FUNCTION public.search_project_context(vector, integer) IS 'Semantic search across all project contexts';
-- =================================================================
-- 05_functions_storage.sql - Storage Schema Functions
-- =================================================================
-- This file creates all custom functions in the storage schema
-- =================================================================

-- Note: Storage functions are included here for completeness
-- These are typically provided by Supabase Storage, but are included
-- for reference in case you need to recreate the schema

-- Create storage schema if not exists
CREATE SCHEMA IF NOT EXISTS storage;

-- Function: get_level
CREATE OR REPLACE FUNCTION storage.get_level(name text)
RETURNS integer
LANGUAGE sql
IMMUTABLE STRICT
AS $function$
SELECT array_length(string_to_array("name", '/'), 1);
$function$;

-- Function: get_prefix
CREATE OR REPLACE FUNCTION storage.get_prefix(name text)
RETURNS text
LANGUAGE sql
IMMUTABLE STRICT
AS $function$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$function$;

-- Function: get_prefixes
CREATE OR REPLACE FUNCTION storage.get_prefixes(name text)
RETURNS text[]
LANGUAGE plpgsql
IMMUTABLE STRICT
AS $function$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$function$;

-- Function: add_prefixes
CREATE OR REPLACE FUNCTION storage.add_prefixes(_bucket_id text, _name text)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$function$;

-- Function: delete_prefix
CREATE OR REPLACE FUNCTION storage.delete_prefix(_bucket_id text, _name text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$function$;

-- Function: delete_leaf_prefixes
CREATE OR REPLACE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[])
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$function$;

-- Function: lock_top_prefixes
CREATE OR REPLACE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[])
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$function$;

-- Function: update_updated_at_column
CREATE OR REPLACE FUNCTION storage.update_updated_at_column()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$function$;

-- Function: enforce_bucket_name_length
CREATE OR REPLACE FUNCTION storage.enforce_bucket_name_length()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$function$;

-- Function: objects_insert_prefix_trigger
CREATE OR REPLACE FUNCTION storage.objects_insert_prefix_trigger()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$function$;

-- Function: objects_update_prefix_trigger
CREATE OR REPLACE FUNCTION storage.objects_update_prefix_trigger()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$function$;

-- Function: delete_prefix_hierarchy_trigger
CREATE OR REPLACE FUNCTION storage.delete_prefix_hierarchy_trigger()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$function$;

-- Function: prefixes_insert_trigger
CREATE OR REPLACE FUNCTION storage.prefixes_insert_trigger()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$function$;

-- Function: objects_delete_cleanup
CREATE OR REPLACE FUNCTION storage.objects_delete_cleanup()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$function$;

-- Function: prefixes_delete_cleanup
CREATE OR REPLACE FUNCTION storage.prefixes_delete_cleanup()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$function$;

-- Additional storage functions can be added here as needed
-- Most storage-related functions are provided by the Supabase Storage service

COMMENT ON FUNCTION storage.get_level(text) IS 'Gets the directory level for a storage path';
COMMENT ON FUNCTION storage.get_prefix(text) IS 'Gets the parent prefix for a storage path';
COMMENT ON FUNCTION storage.get_prefixes(text) IS 'Gets all parent prefixes for a storage path';
-- =================================================================
-- 06_triggers.sql - Database Triggers
-- =================================================================
-- This file creates all triggers for the database
-- =================================================================

-- ============================================
-- Public Schema Triggers
-- ============================================

-- Trigger: update_brain_documents_updated_at
CREATE TRIGGER update_brain_documents_updated_at 
BEFORE UPDATE ON public.brain_documents 
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger: update_company_brain_updated_at
CREATE TRIGGER update_company_brain_updated_at 
BEFORE UPDATE ON public.company_brain 
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger: on_project_document_change
CREATE TRIGGER on_project_document_change 
AFTER INSERT OR DELETE OR UPDATE ON public.project_documents 
FOR EACH ROW 
EXECUTE FUNCTION trigger_project_document_embedding();

-- Trigger: update_project_documents_updated_at
CREATE TRIGGER update_project_documents_updated_at 
BEFORE UPDATE ON public.project_documents 
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger: update_project_embeddings_updated_at
CREATE TRIGGER update_project_embeddings_updated_at 
BEFORE UPDATE ON public.project_embeddings 
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger: on_project_metadata_change
CREATE TRIGGER on_project_metadata_change 
AFTER INSERT OR DELETE OR UPDATE ON public.project_metadata 
FOR EACH ROW 
EXECUTE FUNCTION trigger_project_metadata_embedding();

-- Trigger: update_project_metadata_updated_at
CREATE TRIGGER update_project_metadata_updated_at 
BEFORE UPDATE ON public.project_metadata 
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- Trigger: on_project_delete
CREATE TRIGGER on_project_delete 
BEFORE DELETE ON public.projects 
FOR EACH ROW 
EXECUTE FUNCTION cleanup_project_data_on_delete();

-- Trigger: update_projects_updated_at
CREATE TRIGGER update_projects_updated_at 
BEFORE UPDATE ON public.projects 
FOR EACH ROW 
EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- Storage Schema Triggers
-- ============================================

-- Trigger: enforce_bucket_name_length_trigger
CREATE TRIGGER enforce_bucket_name_length_trigger 
BEFORE INSERT OR UPDATE OF name ON storage.buckets 
FOR EACH ROW 
EXECUTE FUNCTION storage.enforce_bucket_name_length();

-- Trigger: objects_delete_delete_prefix
CREATE TRIGGER objects_delete_delete_prefix 
AFTER DELETE ON storage.objects 
FOR EACH ROW 
EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();

-- Trigger: objects_insert_create_prefix
CREATE TRIGGER objects_insert_create_prefix 
BEFORE INSERT ON storage.objects 
FOR EACH ROW 
EXECUTE FUNCTION storage.objects_insert_prefix_trigger();

-- Trigger: objects_update_create_prefix
CREATE TRIGGER objects_update_create_prefix 
BEFORE UPDATE ON storage.objects 
FOR EACH ROW 
WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) 
EXECUTE FUNCTION storage.objects_update_prefix_trigger();

-- Trigger: update_objects_updated_at
CREATE TRIGGER update_objects_updated_at 
BEFORE UPDATE ON storage.objects 
FOR EACH ROW 
EXECUTE FUNCTION storage.update_updated_at_column();

-- Trigger: prefixes_create_hierarchy
CREATE TRIGGER prefixes_create_hierarchy 
BEFORE INSERT ON storage.prefixes 
FOR EACH ROW 
WHEN ((pg_trigger_depth() < 1)) 
EXECUTE FUNCTION storage.prefixes_insert_trigger();

-- Trigger: prefixes_delete_hierarchy
CREATE TRIGGER prefixes_delete_hierarchy 
AFTER DELETE ON storage.prefixes 
FOR EACH ROW 
EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();

-- ============================================
-- Comments
-- ============================================

COMMENT ON TRIGGER update_brain_documents_updated_at ON public.brain_documents IS 'Auto-updates updated_at timestamp';
COMMENT ON TRIGGER update_company_brain_updated_at ON public.company_brain IS 'Auto-updates updated_at timestamp';
COMMENT ON TRIGGER on_project_document_change ON public.project_documents IS 'Triggers embedding generation when documents change';
COMMENT ON TRIGGER on_project_metadata_change ON public.project_metadata IS 'Triggers embedding generation when metadata changes';
COMMENT ON TRIGGER on_project_delete ON public.projects IS 'Cleans up related data on project deletion';
-- =================================================================
-- 09_indexes.sql - Database Indexes
-- =================================================================
-- This file creates indexes for optimizing query performance
-- Execute this after creating tables
-- =================================================================

-- ============================================
-- Public Schema Indexes
-- ============================================

-- Indexes for company_brain_embeddings (vector similarity search)
CREATE INDEX IF NOT EXISTS company_brain_embeddings_user_id_idx 
ON public.company_brain_embeddings(user_id);

CREATE INDEX IF NOT EXISTS company_brain_embeddings_content_type_idx 
ON public.company_brain_embeddings(content_type);

-- Vector index for similarity search (using HNSW algorithm)
-- Note: Adjust m and ef_construction based on your data size and performance needs
CREATE INDEX IF NOT EXISTS company_brain_embeddings_embedding_idx 
ON public.company_brain_embeddings 
USING hnsw (embedding vector_cosine_ops) 
WITH (m = 16, ef_construction = 64);

-- Indexes for project_embeddings (vector similarity search)
CREATE INDEX IF NOT EXISTS project_embeddings_project_id_idx 
ON public.project_embeddings(project_id);

CREATE INDEX IF NOT EXISTS project_embeddings_company_id_idx 
ON public.project_embeddings(company_id);

CREATE INDEX IF NOT EXISTS project_embeddings_content_type_idx 
ON public.project_embeddings(content_type);

-- Vector index for project embeddings
CREATE INDEX IF NOT EXISTS project_embeddings_embedding_idx 
ON public.project_embeddings 
USING hnsw (embedding vector_cosine_ops) 
WITH (m = 16, ef_construction = 64);

-- Indexes for leads
CREATE INDEX IF NOT EXISTS leads_user_id_idx 
ON public.leads(user_id);

CREATE INDEX IF NOT EXISTS leads_group_id_idx 
ON public.leads(group_id);

CREATE INDEX IF NOT EXISTS leads_lead_type_idx 
ON public.leads(lead_type);

CREATE INDEX IF NOT EXISTS leads_project_idx 
ON public.leads(project);

-- Indexes for recordings
CREATE INDEX IF NOT EXISTS recordings_user_id_idx 
ON public.recordings(user_id);

CREATE INDEX IF NOT EXISTS recordings_lead_id_idx 
ON public.recordings(lead_id);

CREATE INDEX IF NOT EXISTS recordings_project_id_idx 
ON public.recordings(project_id);

CREATE INDEX IF NOT EXISTS recordings_call_date_idx 
ON public.recordings(call_date);

-- Indexes for analyses
CREATE INDEX IF NOT EXISTS analyses_recording_id_idx 
ON public.analyses(recording_id);

CREATE INDEX IF NOT EXISTS analyses_user_id_idx 
ON public.analyses(user_id);

CREATE INDEX IF NOT EXISTS analyses_status_idx 
ON public.analyses(status);

-- Indexes for projects
CREATE INDEX IF NOT EXISTS projects_company_id_idx 
ON public.projects(company_id);

CREATE INDEX IF NOT EXISTS projects_created_by_idx 
ON public.projects(created_by);

CREATE INDEX IF NOT EXISTS projects_status_idx 
ON public.projects(status);

CREATE INDEX IF NOT EXISTS projects_is_deleted_idx 
ON public.projects(is_deleted) 
WHERE is_deleted = false;

-- Indexes for project_documents
CREATE INDEX IF NOT EXISTS project_documents_project_id_idx 
ON public.project_documents(project_id);

CREATE INDEX IF NOT EXISTS project_documents_company_id_idx 
ON public.project_documents(company_id);

CREATE INDEX IF NOT EXISTS project_documents_is_deleted_idx 
ON public.project_documents(is_deleted) 
WHERE is_deleted = false;

-- Indexes for brain_documents
CREATE INDEX IF NOT EXISTS brain_documents_user_id_idx 
ON public.brain_documents(user_id);

CREATE INDEX IF NOT EXISTS brain_documents_company_brain_id_idx 
ON public.brain_documents(company_brain_id);

CREATE INDEX IF NOT EXISTS brain_documents_document_group_id_idx 
ON public.brain_documents(document_group_id);

-- Indexes for sample_transcripts
CREATE INDEX IF NOT EXISTS sample_transcripts_category_idx 
ON public.sample_transcripts(category);

-- GIN index for tag arrays
CREATE INDEX IF NOT EXISTS sample_transcripts_tags_idx 
ON public.sample_transcripts USING gin(tags);

-- ============================================
-- Storage Schema Indexes
-- ============================================

-- Indexes for storage.objects
CREATE INDEX IF NOT EXISTS objects_bucket_id_idx 
ON storage.objects(bucket_id);

CREATE INDEX IF NOT EXISTS objects_bucket_id_name_idx 
ON storage.objects(bucket_id, name);

-- Index for path-based queries
CREATE INDEX IF NOT EXISTS objects_name_pattern_idx 
ON storage.objects(name text_pattern_ops);

-- Indexes for storage.prefixes
CREATE INDEX IF NOT EXISTS prefixes_bucket_id_idx 
ON storage.prefixes(bucket_id);

-- ============================================
-- Comments
-- ============================================

COMMENT ON INDEX company_brain_embeddings_embedding_idx IS 'HNSW index for fast vector similarity search on company brain embeddings';
COMMENT ON INDEX project_embeddings_embedding_idx IS 'HNSW index for fast vector similarity search on project embeddings';
COMMENT ON INDEX projects_is_deleted_idx IS 'Partial index for active (not deleted) projects';
COMMENT ON INDEX project_documents_is_deleted_idx IS 'Partial index for active (not deleted) project documents';
