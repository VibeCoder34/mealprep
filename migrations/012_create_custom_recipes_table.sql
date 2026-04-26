-- 012 - custom recipes (per user, includes AI-generated)
-- Stores the full Recipe JSON from the app, keyed by a client-generated text id.

create table if not exists public.custom_recipes (
  id text primary key,
  user_id uuid not null references public.users(id) on delete cascade,
  recipe jsonb not null,
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

create index if not exists idx_custom_recipes_user_id
  on public.custom_recipes(user_id);

alter table public.custom_recipes enable row level security;

do $$
begin
  create policy "Users can view own custom recipes"
  on public.custom_recipes for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can insert own custom recipes"
  on public.custom_recipes for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own custom recipes"
  on public.custom_recipes for update
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete own custom recipes"
  on public.custom_recipes for delete
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

