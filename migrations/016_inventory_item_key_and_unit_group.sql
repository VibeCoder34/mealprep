-- 016 - inventory item_key + unit_group for safer upserts
--
-- Goal:
-- - Prevent duplicates caused by spelling/casing/punctuation differences by storing a normalized key.
-- - Avoid overwriting an existing item's unit with an incompatible unit by including unit_group in the upsert key.
--
-- Notes:
-- - SQL normalization is intentionally conservative (lowercase + trim + punctuation collapse).
--   The app computes a stronger key (see IngredientNormalizer) but the DB column must be present
--   for constraints and upserts.

alter table public.inventory
  add column if not exists item_key text,
  add column if not exists unit_group text;

-- Best-effort backfill for existing rows.
update public.inventory
set item_key = trim(regexp_replace(lower(coalesce(item_name, '')), '[^[:alnum:]]+', ' ', 'g'))
where item_key is null or item_key = '';

update public.inventory
set unit_group = case
  when lower(unit) in ('g', 'gram', 'gr', 'kg') then 'weight'
  when lower(unit) in ('ml', 'l', 'litre', 'liter') then 'volume'
  when lower(unit) in ('adet', 'pcs', 'piece', 'pieces') then 'count'
  else 'other'
end
where unit_group is null or unit_group = '';

-- Replace old unique index (user_id, item_name) with a safer key.
drop index if exists public.idx_inventory_user_item_unique;
create unique index if not exists idx_inventory_user_key_group_unique
  on public.inventory (user_id, item_key, unit_group);

