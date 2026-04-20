-- 004 - shopping list items (per user)
create table if not exists public.shopping_list (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  item_name text not null,
  quantity numeric not null,
  unit text not null,
  is_purchased boolean default false,
  source text, -- 'recipe' or 'manual'
  recipe_id text references public.recipes(id),
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.shopping_list enable row level security;

do $$
begin
  create policy "Users can view own shopping list"
  on public.shopping_list for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can manage own shopping list"
  on public.shopping_list for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own shopping list"
  on public.shopping_list for update
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete own shopping list"
  on public.shopping_list for delete
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

