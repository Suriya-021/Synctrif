-- Enable pgvector extension for RAG (Retrieval-Augmented Generation)
create extension if not exists vector;

-- 1. Profiles Table (Extends Supabase Auth users)
create table public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Projects Table
create table public.projects (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  name text not null,
  github_repo text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. Pull Requests Table
create table public.pull_requests (
  id uuid default gen_random_uuid() primary key,
  project_id uuid references public.projects(id) on delete cascade not null,
  pr_number integer not null,
  title text not null,
  status text not null default 'open',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. Code Reviews Table (Stores Agent Output)
create table public.code_reviews (
  id uuid default gen_random_uuid() primary key,
  pr_id uuid references public.pull_requests(id) on delete cascade not null,
  risk_level text not null check (risk_level in ('low', 'medium', 'high')),
  summary text not null,
  changed_functions text[] default '{}',
  modified_endpoints text[] default '{}',
  added_dependencies text[] default '{}',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 5. QA Test Plans Table (Stores Agent Output)
create table public.qa_test_plans (
  id uuid default gen_random_uuid() primary key,
  pr_id uuid references public.pull_requests(id) on delete cascade not null,
  test_cases jsonb not null default '[]'::jsonb,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 6. Historical Bugs Table (For RAG)
create table public.historical_bugs (
  id uuid default gen_random_uuid() primary key,
  project_id uuid references public.projects(id) on delete cascade not null,
  description text not null,
  -- 768 dimensions matches Google's text-embedding-004 model
  embedding vector(768),
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Set up Row Level Security (RLS)
alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.pull_requests enable row level security;
alter table public.code_reviews enable row level security;
alter table public.qa_test_plans enable row level security;
alter table public.historical_bugs enable row level security;

-- Only service_role can access tables by default, protecting data from public clients
-- The Agent Worker will use the Service Role key to bypass RLS.
