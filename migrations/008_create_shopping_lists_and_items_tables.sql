-- 008 - shopping lists + items (matches app model: multiple named lists + items)
create extension if not exists pgcrypto;

-- Parent lists (bundle)
create table if not exists public.shopping_lists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null,
  description text not null default '',
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.shopping_lists enable row level security;

do $$
begin
  create policy "Users can view own shopping lists"
  on public.shopping_lists for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can insert own shopping lists"
  on public.shopping_lists for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own shopping lists"
  on public.shopping_lists for update
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete own shopping lists"
  on public.shopping_lists for delete
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

-- Items per list (bundle.items)
create table if not exists public.shopping_list_items (
  id uuid primary key default gen_random_uuid(),
  list_id uuid not null references public.shopping_lists(id) on delete cascade,
  item_name text not null,
  amount text not null default '',
  is_purchased boolean default false,
  source text, -- 'recipe' or 'manual'
  recipe_id text references public.recipes(id),
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.shopping_list_items enable row level security;

-- RLS is based on list ownership (join to shopping_lists)
do $$
begin
  create policy "Users can view items in own shopping lists"
  on public.shopping_list_items for select
  using (
    exists (
      select 1
      from public.shopping_lists l
      where l.id = shopping_list_items.list_id
        and l.user_id = auth.uid()
    )
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can insert items in own shopping lists"
  on public.shopping_list_items for insert
  with check (
    exists (
      select 1
      from public.shopping_lists l
      where l.id = shopping_list_items.list_id
        and l.user_id = auth.uid()
    )
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update items in own shopping lists"
  on public.shopping_list_items for update
  using (
    exists (
      select 1
      from public.shopping_lists l
      where l.id = shopping_list_items.list_id
        and l.user_id = auth.uid()
    )
  );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete items in own shopping lists"
  on public.shopping_list_items for delete
  using (
    exists (
      select 1
      from public.shopping_lists l
      where l.id = shopping_list_items.list_id
        and l.user_id = auth.uid()
    )
  );
exception
  when duplicate_object then null;
end $$;

