-- 006 - user dietary preferences (per user)
create table if not exists public.user_dietary_preferences (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references public.users(id) on delete cascade,
  preferences jsonb default '[]',
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.user_dietary_preferences enable row level security;

do $$
begin
  create policy "Users can view own preferences"
  on public.user_dietary_preferences for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can insert own preferences"
  on public.user_dietary_preferences for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own preferences"
  on public.user_dietary_preferences for update
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

