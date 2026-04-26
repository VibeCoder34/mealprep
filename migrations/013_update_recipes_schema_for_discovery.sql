-- 013 - recipe discovery schema extensions
-- Adds new columns needed for advanced filtering & discovery.

alter table public.recipes
  add column if not exists category text default 'lunch',
  add column if not exists cuisine_type text default 'turkish',
  add column if not exists servings integer default 1,
  add column if not exists source text default 'custom',
  add column if not exists is_approved boolean default true,
  add column if not exists status text default 'active',
  add column if not exists allergens jsonb default '[]'::jsonb,
  add column if not exists updated_at timestamp default current_timestamp;

-- Backfill updated_at where missing.
update public.recipes
set updated_at = coalesce(updated_at, created_at)
where updated_at is null;

