-- 009 - recipe ratings (matches app: 1..5 stars + optional comment per user per recipe)
create extension if not exists pgcrypto;

create table if not exists public.recipe_ratings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  recipe_id text not null references public.recipes(id) on delete cascade,
  rating integer not null check (rating >= 1 and rating <= 5),
  comment text not null default '',
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp,
  unique(user_id, recipe_id)
);

alter table public.recipe_ratings enable row level security;

do $$
begin
  create policy "Users can view own recipe ratings"
  on public.recipe_ratings for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can insert own recipe ratings"
  on public.recipe_ratings for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own recipe ratings"
  on public.recipe_ratings for update
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete own recipe ratings"
  on public.recipe_ratings for delete
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

