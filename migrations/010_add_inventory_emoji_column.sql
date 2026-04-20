-- 010 - inventory: add emoji column to match app model
alter table public.inventory
add column if not exists emoji text not null default '🍽️';

