-- 015 - AI backfill for recipes.macros
-- GeneratedAt: 2026-04-22T21:11:14Z
-- Input: recipes_import_staging.csv
-- Model: gpt-4.1-mini
-- Rows: 1
-- Basis: per_100g

begin;
update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":16.0,"carbs":6.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0001';

commit;
