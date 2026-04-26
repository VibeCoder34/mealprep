-- 014 - inventory upsert key + shopping list item recipe name

-- Inventory: enforce per-user unique names so the app can upsert reliably.
-- (Uses a unique index instead of a constraint for IF NOT EXISTS support.)
create unique index if not exists idx_inventory_user_item_unique
  on public.inventory (user_id, item_name);

-- Shopping list items: store recipe name for nicer UI grouping/labels.
alter table public.shopping_list_items
  add column if not exists recipe_name text;

