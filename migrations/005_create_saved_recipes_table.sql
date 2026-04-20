-- 005 - user saved recipes (bookmarks)
create table if not exists public.saved_recipes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  recipe_id text not null references public.recipes(id),
  saved_at timestamp default current_timestamp,
  unique(user_id, recipe_id)
);

alter table public.saved_recipes enable row level security;

do $$
begin
  create policy "Users can view own saved recipes"
  on public.saved_recipes for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can save recipes"
  on public.saved_recipes for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete saved recipes"
  on public.saved_recipes for delete
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

