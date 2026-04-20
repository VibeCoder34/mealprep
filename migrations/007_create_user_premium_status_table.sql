-- 007 - user premium status (per user)
create table if not exists public.user_premium_status (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references public.users(id) on delete cascade,
  is_premium boolean default false,
  premium_until timestamp,
  created_at timestamp default current_timestamp,
  updated_at timestamp default current_timestamp
);

alter table public.user_premium_status enable row level security;

do $$
begin
  create policy "Users can view own premium status"
  on public.user_premium_status for select
  using (auth.uid() = user_id);
exception
  when duplicate_object then null;
end $$;

