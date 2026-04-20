-- 003 - recipes (shared, hardcoded/seeded)
create table if not exists public.recipes (
  id text primary key,
  name text not null,
  ingredients jsonb not null,
  macros jsonb,
  time_minutes integer,
  difficulty text,
  steps jsonb not null,
  dietary_tags jsonb,
  collections jsonb,
  is_premium boolean default false,
  created_at timestamp default current_timestamp
);

alter table public.recipes enable row level security;

do $$
begin
  create policy "Anyone can view recipes"
  on public.recipes for select
  using (true);
exception
  when duplicate_object then null;
end $$;

