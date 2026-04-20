-- 001 - users profile table (extends auth.users)
create extension if not exists pgcrypto;

create table if not exists public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  email text unique not null,
  full_name text,
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.users enable row level security;

do $$
begin
  create policy "Users can view own data"
  on public.users for select
  using (auth.uid() = id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own data"
  on public.users for update
  using (auth.uid() = id);
exception
  when duplicate_object then null;
end $$;

-- Needed so the app can create its own profile row after sign-up.
do $$
begin
  create policy "Users can insert own data"
  on public.users for insert
  with check (auth.uid() = id);
exception
  when duplicate_object then null;
end $$;

