-- 002 - inventory (fridge items per user)
create table if not exists public.inventory (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  item_name text not null,
  quantity numeric not null,
  unit text not null,
  added_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.inventory enable row level security;

do $$
begin
  create policy "Users can view own inventory"
  on public.inventory for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can insert own inventory"
  on public.inventory for insert
  with check (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can update own inventory"
  on public.inventory for update
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Users can delete own inventory"
  on public.inventory for delete
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

