-- 015 - AI backfill for recipes.macros
-- GeneratedAt: 2026-04-22T21:29:52Z
-- Input: recipes_import_staging.csv
-- Model: gpt-4.1-mini
-- Rows: 685
-- Basis: per_100g

begin;
update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":16.5,"carbs":5.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0001';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":6.5,"carbs":12.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0002';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":13.0,"carbs":12.5,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0003';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":8.7,"carbs":15.3,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0004';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":11.0,"carbs":15.0,"fat":11.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0005';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":10.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0006';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":28.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0007';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":260,"protein":5.5,"carbs":45.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0008';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.2,"carbs":18.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0009';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":5.0,"carbs":12.5,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0010';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":25.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0011';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":3.2,"carbs":14.5,"fat":2.1}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0012';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":22.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0013';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":7.0,"carbs":22.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0014';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":420,"protein":5.5,"carbs":45.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0015';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":265,"protein":9.0,"carbs":30.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0016';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":480,"protein":5.5,"carbs":50.0,"fat":28.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0017';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":35.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0018';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":410,"protein":5.5,"carbs":45.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0019';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":11.0,"carbs":6.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0020';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":4.5,"carbs":3.5,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0021';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":14.0,"carbs":6.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0022';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":20.0,"carbs":4.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0023';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":20.0,"carbs":4.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0024';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":12.0,"carbs":8.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0025';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":14.0,"carbs":12.5,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0026';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":15.0,"carbs":5.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0027';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":6.5,"carbs":6.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0028';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":4.0,"carbs":9.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0029';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":30.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0030';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.0,"carbs":45.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0031';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.5,"carbs":16.0,"fat":3.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0032';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":5.0,"carbs":12.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0033';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":25.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0034';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":3.2,"carbs":15.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0035';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":22.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0036';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":22.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0037';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":420,"protein":5.0,"carbs":45.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0038';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":9.0,"carbs":25.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0039';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":480,"protein":5.5,"carbs":45.0,"fat":30.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0040';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":35.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0041';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":430,"protein":5.0,"carbs":45.0,"fat":25.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0042';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":10.5,"carbs":7.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0043';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":4.5,"carbs":3.5,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0044';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":145,"protein":13.8,"carbs":5.4,"fat":7.2}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0045';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":18.0,"carbs":4.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0046';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":19.0,"carbs":4.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0047';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":12.0,"carbs":8.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0048';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":15.0,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0049';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":15.0,"carbs":5.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0050';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":7.0,"carbs":6.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0051';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":8.0,"carbs":5.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0052';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":3.5,"carbs":15.0,"fat":17.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0053';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":3.2,"carbs":12.5,"fat":3.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0054';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":7.5,"carbs":28.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0055';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0056';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":0.6,"carbs":11.0,"fat":0.7}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0057';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":7.5,"carbs":6.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0058';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":38.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0059';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":2.5,"carbs":18.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0060';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":9.0,"carbs":3.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0061';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":14.0,"carbs":2.0,"fat":17.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0062';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":98,"protein":11.0,"carbs":3.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0063';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":3.2,"carbs":7.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0064';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":2.1,"carbs":7.5,"fat":2.3}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0065';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":1.5,"carbs":22.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0066';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":3.5,"carbs":22.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0067';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":3.5,"carbs":20.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0068';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":4.0,"carbs":8.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0069';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":35,"protein":2.5,"carbs":4.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0070';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":3.2,"carbs":8.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0071';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":25.0,"fat":25.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0072';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":5,"protein":0.2,"carbs":1.2,"fat":0.1}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0073';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":3.2,"carbs":8.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0074';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0075';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":9.0,"carbs":10.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0076';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":8.0,"carbs":10.5,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0077';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.5,"carbs":6.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0078';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":5.0,"carbs":22.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0079';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":3.5,"carbs":6.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0080';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":1.8,"carbs":6.5,"fat":2.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0081';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":6.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0082';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":2.1,"carbs":7.5,"fat":2.3}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0083';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":2.5,"carbs":8.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0084';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":4.5,"carbs":20.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0085';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":4.5,"carbs":60.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0086';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":1.5,"carbs":7.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0087';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.2,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0088';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":5.0,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0089';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":1.5,"carbs":7.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0090';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":4.5,"carbs":6.0,"fat":13.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0091';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":5.2,"carbs":20.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0092';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":12.0,"carbs":25.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0093';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.5,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0094';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":2.5,"carbs":25.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0095';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.1,"carbs":5.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0096';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":4.5,"carbs":35.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0097';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":5.0,"carbs":9.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0098';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":2.5,"carbs":10.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0099';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.0,"carbs":10.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0100';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.1,"carbs":5.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0101';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.5,"carbs":6.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0102';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":5.2,"carbs":12.5,"fat":3.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0103';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.5,"carbs":4.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0104';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.5,"carbs":11.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0105';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":2.5,"carbs":10.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0106';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":7.5,"carbs":4.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0107';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.5,"carbs":10.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0108';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":35,"protein":2.5,"carbs":4.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0109';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":7.0,"carbs":9.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0110';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.2,"carbs":7.5,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0111';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.5,"carbs":10.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0112';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":3.2,"carbs":8.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0113';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.3,"carbs":5.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0114';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":5.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0115';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":6.5,"carbs":6.0,"fat":3.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0116';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":6.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0117';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":6.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0118';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":8.0,"carbs":4.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0119';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.0,"carbs":6.5,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0120';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":4.5,"carbs":3.5,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0121';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.5,"carbs":10.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0122';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":2.0,"carbs":8.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0123';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":35,"protein":1.2,"carbs":6.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0124';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":9.0,"carbs":5.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0125';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":6.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0126';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":4.5,"carbs":10.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0127';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.0,"carbs":6.0,"fat":1.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0128';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.5,"carbs":10.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0129';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":6.5,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0130';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.8,"carbs":3.5,"fat":2.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0131';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":7.0,"carbs":6.5,"fat":4.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0132';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":12.0,"carbs":3.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0133';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":4.0,"carbs":3.5,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0134';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":62,"protein":3.5,"carbs":6.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0135';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":7.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0136';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":5.0,"carbs":10.5,"fat":2.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0137';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":6.0,"carbs":20.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0138';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":5.0,"carbs":12.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0139';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":4.2,"carbs":10.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0140';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":5.2,"carbs":11.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0141';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":6.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0142';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":9.0,"carbs":5.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0143';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.2,"carbs":6.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0144';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":4.2,"carbs":10.5,"fat":3.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0145';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":30,"protein":1.5,"carbs":6.0,"fat":0.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0146';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":1.8,"carbs":7.5,"fat":3.2}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0147';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":4.2,"carbs":9.5,"fat":4.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0148';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":1.5,"carbs":8.0,"fat":2.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0149';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":4.2,"carbs":8.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0150';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.5,"carbs":6.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0151';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.5,"carbs":5.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0152';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":92,"protein":6.2,"carbs":7.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0153';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":5.2,"carbs":10.5,"fat":3.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0154';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":2.5,"carbs":4.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0155';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.0,"carbs":8.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0156';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":5.0,"carbs":10.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0157';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":3.0,"carbs":5.5,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0158';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":0.5,"carbs":55.0,"fat":0.1}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0159';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.5,"carbs":8.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0160';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":10.5,"carbs":20.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0161';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":7.5,"carbs":5.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0162';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":10.5,"carbs":20.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0163';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":10.0,"carbs":14.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0164';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":8.0,"carbs":25.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0165';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":11.0,"carbs":20.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0166';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":8.0,"carbs":10.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0167';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":6.0,"carbs":18.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0168';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":3.2,"carbs":12.5,"fat":3.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0169';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":0.5,"carbs":55.0,"fat":0.2}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0170';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":20.0,"carbs":1.5,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0171';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.5,"carbs":35.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0172';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":11.0,"carbs":22.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0173';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":12.5,"carbs":1.1,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0174';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.5,"carbs":8.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0175';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":7.5,"carbs":45.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0176';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":11.0,"carbs":18.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0177';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":15.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0178';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":11.0,"carbs":15.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0179';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":10.0,"carbs":25.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0180';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":11.0,"carbs":15.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0181';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.5,"carbs":35.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0182';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":590,"protein":25.5,"carbs":15.0,"fat":50.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0183';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.5,"carbs":1.5,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0184';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":9.0,"carbs":15.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0185';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":8.0,"carbs":18.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0186';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":8.0,"carbs":50.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0187';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":5.0,"carbs":15.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0188';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":8.5,"carbs":12.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0189';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":7.5,"carbs":9.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0190';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":6.5,"carbs":6.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0191';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":9.0,"carbs":3.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0192';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":30.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0193';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":590,"protein":17.0,"carbs":10.0,"fat":55.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0194';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":3.5,"carbs":45.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0195';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":4.0,"carbs":12.5,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0196';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":7.0,"carbs":15.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0197';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":0.5,"carbs":62.0,"fat":0.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0198';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":8.0,"carbs":28.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0199';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":8.0,"carbs":30.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0200';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":7.5,"carbs":35.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0201';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":8.0,"carbs":20.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0202';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.5,"carbs":15.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0203';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":11.5,"carbs":1.5,"fat":17.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0204';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":3.5,"carbs":6.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0205';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":5.5,"carbs":12.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0206';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":5.0,"carbs":28.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0207';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":11.0,"carbs":13.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0208';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":9.0,"carbs":4.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0209';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":8.0,"carbs":20.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0210';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":270,"protein":11.0,"carbs":20.0,"fat":17.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0211';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":6.0,"carbs":15.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0212';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":6.0,"carbs":25.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0213';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":9.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0214';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":6.5,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0215';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":22.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0216';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":10.5,"carbs":18.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0217';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":15.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0218';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":9.0,"carbs":14.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0219';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":3.5,"carbs":20.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0220';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":9.0,"carbs":18.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0221';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":9.0,"carbs":25.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0222';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":11.0,"carbs":18.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0223';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":5.5,"carbs":22.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0224';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":25.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0225';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":9.0,"carbs":12.5,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0226';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.5,"carbs":1.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0227';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":18.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0228';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":22.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0229';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":15.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0230';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":7.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0231';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":9.0,"carbs":20.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0232';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":28.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0233';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":6.5,"carbs":15.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0234';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":7.5,"carbs":38.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0235';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":9.0,"carbs":25.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0236';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":8.0,"carbs":40.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0237';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":12.5,"carbs":1.0,"fat":17.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0238';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":7.5,"carbs":30.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0239';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":10.0,"carbs":15.0,"fat":13.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0240';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":290,"protein":6.5,"carbs":38.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0241';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":5.0,"carbs":38.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0242';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":0.4,"carbs":52.0,"fat":0.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0243';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":12.0,"carbs":15.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0244';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":10.0,"carbs":15.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0245';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":7.5,"carbs":7.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0246';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":7.0,"carbs":30.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0247';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":260,"protein":6.5,"carbs":30.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0248';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":10.5,"carbs":28.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0249';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":0.3,"carbs":60.0,"fat":0.1}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0250';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":14.0,"carbs":20.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0251';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":0.3,"carbs":58.0,"fat":0.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0252';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":9.0,"carbs":22.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0253';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":6.5,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0254';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":235,"protein":11.5,"carbs":10.0,"fat":16.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0255';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":4.2,"carbs":10.5,"fat":4.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0256';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.0,"carbs":8.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0257';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":2.5,"carbs":7.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0258';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":2.5,"carbs":7.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0259';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":5.0,"carbs":12.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0260';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":1.8,"carbs":9.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0261';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":2.0,"carbs":7.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0262';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":2.0,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0263';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":3.2,"carbs":18.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0264';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":3.2,"carbs":8.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0265';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":2.5,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0266';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":7.0,"carbs":12.5,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0267';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.5,"carbs":10.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0268';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":2.5,"carbs":15.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0269';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":3.2,"carbs":15.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0270';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.5,"carbs":8.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0271';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":5.0,"carbs":10.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0272';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":1.5,"carbs":10.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0273';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":1.8,"carbs":12.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0274';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":2.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0275';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":1.5,"carbs":10.0,"fat":1.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0276';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":1.5,"carbs":8.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0277';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":8.0,"carbs":10.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0278';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":7.0,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0279';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":5.0,"carbs":9.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0280';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":2.5,"carbs":9.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0281';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":1.5,"carbs":10.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0282';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":3.5,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0283';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":5.0,"carbs":15.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0284';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":145,"protein":5.2,"carbs":10.5,"fat":10.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0285';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.2,"carbs":15.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0286';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":3.5,"carbs":6.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0287';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":9.0,"carbs":6.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0288';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":3.5,"carbs":10.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0289';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":3.2,"carbs":7.5,"fat":2.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0290';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":3.5,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0291';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":80,"protein":1.5,"carbs":6.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0292';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":7.0,"carbs":10.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0293';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":3.5,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0294';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":1.8,"carbs":8.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0295';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":5.5,"carbs":14.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0296';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":45,"protein":1.5,"carbs":7.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0297';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":3.2,"carbs":15.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0298';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":4.0,"carbs":12.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0299';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":4.2,"carbs":8.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0300';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":5.0,"carbs":10.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0301';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":7.8,"carbs":18.5,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0302';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":6.5,"carbs":15.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0303';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":3.5,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0304';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":2.1,"carbs":7.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0305';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":2.1,"carbs":9.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0306';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":3.2,"carbs":18.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0307';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":3.2,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0308';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":170,"protein":15.0,"carbs":10.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0309';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":1.2,"carbs":12.5,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0310';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":2.5,"carbs":8.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0311';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":2.5,"carbs":8.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0312';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":90,"protein":4.5,"carbs":8.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0313';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":7.0,"carbs":12.5,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0314';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":5.0,"carbs":10.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0315';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.2,"carbs":8.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0316';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":3.2,"carbs":10.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0317';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":55,"protein":2.1,"carbs":11.0,"fat":0.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0318';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":3.5,"carbs":10.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0319';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":3.2,"carbs":12.5,"fat":3.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0320';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":5.0,"carbs":10.5,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0321';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.2,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0322';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":2.5,"carbs":15.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0323';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":2.5,"carbs":10.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0324';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":65,"protein":2.3,"carbs":10.5,"fat":2.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0325';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":2.5,"carbs":8.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0326';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.5,"carbs":12.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0327';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":30.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0328';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":38.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0329';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":370,"protein":5.5,"carbs":35.0,"fat":23.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0330';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":4.5,"carbs":28.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0331';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":4.0,"carbs":28.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0332';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.0,"carbs":35.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0333';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":38.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0334';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":35.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0335';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":6.5,"carbs":35.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0336';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":4.5,"carbs":28.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0337';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":430,"protein":6.5,"carbs":35.0,"fat":30.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0338';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":3.5,"carbs":30.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0339';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":40.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0340';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":410,"protein":6.5,"carbs":38.0,"fat":26.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0341';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":4.5,"carbs":30.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0342';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.5,"carbs":30.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0343';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":4.5,"carbs":35.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0344';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.5,"carbs":28.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0345';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":40.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0346';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":6.5,"carbs":40.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0347';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":3.5,"carbs":25.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0348';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":38.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0349';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":430,"protein":6.5,"carbs":45.0,"fat":25.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0350';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.2,"carbs":30.0,"fat":14.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0351';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.5,"carbs":25.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0352';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":6.5,"carbs":22.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0353';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":35.0,"fat":16.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0354';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":4.5,"carbs":28.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0355';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":35.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0356';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":7.5,"carbs":40.0,"fat":17.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0357';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":4.5,"carbs":30.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0358';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":370,"protein":7.5,"carbs":45.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0359';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":30.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0360';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.8,"carbs":30.0,"fat":18.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0361';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":6.5,"carbs":25.0,"fat":6.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0362';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":4.5,"carbs":30.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0363';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":35.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0364';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":5.5,"carbs":28.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0365';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":6.5,"carbs":45.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0366';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":5.0,"carbs":40.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0367';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":260,"protein":6.5,"carbs":25.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0368';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":5.2,"carbs":28.5,"fat":6.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0369';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":310,"protein":6.5,"carbs":45.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0370';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":7.5,"carbs":22.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0371';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.5,"carbs":20.0,"fat":23.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0372';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":4.5,"carbs":30.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0373';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":30.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0374';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":420,"protein":5.0,"carbs":50.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0375';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":40.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0376';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":4.0,"carbs":28.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0377';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":310,"protein":3.5,"carbs":35.0,"fat":17.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0378';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.5,"carbs":35.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0379';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":6.5,"carbs":35.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0380';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":30.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0381';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":38.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0382';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":55.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0383';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.5,"carbs":35.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0384';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":15.0,"carbs":7.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0385';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":22.0,"carbs":1.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0386';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.0,"carbs":8.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0387';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":18.0,"carbs":4.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0388';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":18.0,"carbs":0.5,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0389';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":18.0,"carbs":4.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0390';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":12.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0391';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":22.0,"carbs":1.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0392';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":20.0,"carbs":3.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0393';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":20.0,"carbs":2.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0394';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":2.5,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0395';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":18.0,"carbs":3.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0396';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":18.0,"carbs":8.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0397';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":20.0,"carbs":1.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0398';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":22.0,"carbs":0.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0399';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":22.0,"carbs":0.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0400';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":205,"protein":22.0,"carbs":0.0,"fat":13.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0401';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":22.0,"carbs":1.5,"fat":13.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0402';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":20.5,"carbs":0.0,"fat":1.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0403';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":18.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0404';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":13.0,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0405';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":10.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0406';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":20.0,"carbs":1.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0407';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.0,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0408';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":20.5,"carbs":0.5,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0409';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":15.0,"carbs":10.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0410';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0411';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":10.0,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0412';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":8.0,"carbs":3.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0413';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":15.0,"carbs":8.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0414';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":12.0,"carbs":5.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0415';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":8.0,"carbs":12.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0416';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":20.0,"carbs":3.5,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0417';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":14.0,"carbs":5.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0418';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":14.0,"carbs":10.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0419';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":13.0,"carbs":5.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0420';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":20.0,"carbs":3.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0421';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":14.0,"carbs":5.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0422';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":7.0,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0423';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":9.0,"carbs":12.5,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0424';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":15.0,"carbs":3.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0425';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":9.0,"carbs":4.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0426';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":14.0,"carbs":6.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0427';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":20.0,"carbs":2.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0428';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":18.0,"carbs":2.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0429';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":12.0,"carbs":18.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0430';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":20.0,"carbs":1.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0431';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":19.0,"carbs":5.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0432';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":14.0,"carbs":5.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0433';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":14.0,"carbs":4.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0434';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":15.0,"carbs":5.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0435';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":18.0,"carbs":0.5,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0436';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":14.0,"carbs":10.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0437';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":6.5,"carbs":30.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0438';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":5.0,"carbs":20.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0439';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.8,"carbs":18.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0440';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":5.0,"carbs":22.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0441';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.0,"carbs":18.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0442';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0443';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":6.5,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0444';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":8.0,"carbs":18.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0445';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":10.5,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0446';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":6.5,"carbs":28.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0447';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":5.5,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0448';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":20.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0449';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":7.5,"carbs":30.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0450';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":7.5,"carbs":12.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0451';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":20.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0452';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":5.0,"carbs":20.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0453';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":9.0,"carbs":12.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0454';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":9.0,"carbs":15.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0455';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":5.5,"carbs":20.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0456';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":5.0,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0457';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":8.5,"carbs":18.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0458';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":7.0,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0459';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":15.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0460';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":9.0,"carbs":12.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0461';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":8.5,"carbs":20.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0462';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":6.8,"carbs":18.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0463';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":11.0,"carbs":15.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0464';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.0,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0465';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":10.5,"carbs":18.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0466';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":5.0,"carbs":22.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0467';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":20.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0468';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.0,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0469';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":5.5,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0470';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":9.0,"carbs":12.5,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0471';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":5.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0472';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0473';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":12.0,"carbs":6.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0474';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":15.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0475';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":10.5,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0476';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":16.5,"carbs":6.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0477';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.5,"carbs":12.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0478';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":14.0,"carbs":12.0,"fat":16.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0479';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":170,"protein":9.0,"carbs":15.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0480';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":12.0,"carbs":7.0,"fat":11.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0481';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":10.5,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0482';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":8.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0483';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":10.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0484';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":14.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0485';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":15.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0486';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":11.0,"carbs":6.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0487';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":15.0,"carbs":8.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0488';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":18.0,"carbs":6.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0489';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":145,"protein":12.0,"carbs":8.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0490';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":16.0,"carbs":8.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0491';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":10.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0492';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":6.5,"carbs":25.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0493';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":12.5,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0494';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":14.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0495';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0496';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":15.0,"carbs":12.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0497';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":6.5,"carbs":9.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0498';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":9.0,"carbs":10.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0499';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.0,"carbs":4.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0500';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":6.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0501';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.0,"carbs":10.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0502';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":7.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0503';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":10.2,"carbs":12.5,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0504';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":12.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0505';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":8.0,"carbs":10.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0506';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.5,"carbs":22.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0507';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":18.0,"carbs":8.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0508';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":7.0,"carbs":22.0,"fat":2.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0509';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":170,"protein":14.0,"carbs":8.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0510';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.0,"carbs":8.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0511';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":7.0,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0512';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":16.5,"carbs":6.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0513';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":4.5,"carbs":20.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0514';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":14.0,"carbs":8.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0515';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":6.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0516';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":8.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0517';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":14.0,"carbs":10.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0518';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":5.5,"carbs":25.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0519';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":6.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0520';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":7.0,"carbs":22.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0521';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":14.0,"carbs":6.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0522';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":16.0,"carbs":5.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0523';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":12.0,"carbs":8.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0524';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":195,"protein":20.5,"carbs":7.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0525';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":11.0,"carbs":10.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0526';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":12.0,"carbs":6.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0527';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":12.5,"carbs":6.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0528';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":10.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0529';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.0,"carbs":8.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0530';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":135,"protein":10.5,"carbs":7.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0531';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":10.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0532';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":10.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0533';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":9.0,"carbs":10.5,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0534';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":8.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0535';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":12.0,"carbs":8.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0536';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":14.0,"carbs":12.5,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0537';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":12.5,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0538';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":16.5,"carbs":4.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0539';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0540';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":18.0,"carbs":3.0,"fat":16.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0541';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":20.0,"carbs":4.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0542';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":15.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0543';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.5,"carbs":5.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0544';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":14.0,"carbs":10.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0545';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":10.5,"carbs":8.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0546';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.5,"carbs":18.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0547';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":7.5,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0548';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":22.0,"carbs":2.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0549';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":15.0,"carbs":12.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0550';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":9.0,"carbs":12.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0551';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":18.0,"carbs":4.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0552';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":26.0,"carbs":2.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0553';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":14.0,"carbs":10.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0554';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":8.0,"carbs":9.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0555';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":8.5,"carbs":20.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0556';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":10.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0557';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":10.5,"carbs":6.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0558';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":85,"protein":6.0,"carbs":8.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0559';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":15.0,"carbs":4.5,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0560';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":4.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0561';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":26.0,"carbs":1.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0562';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":14.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0563';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.0,"carbs":6.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0564';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":235,"protein":21.0,"carbs":3.0,"fat":15.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0565';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":12.5,"carbs":15.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0566';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":9.0,"carbs":12.5,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0567';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":20.0,"carbs":0.5,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0568';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.0,"carbs":8.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0569';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":12.0,"carbs":8.5,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0570';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":11.0,"carbs":18.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0571';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":15.0,"carbs":5.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0572';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":14.0,"carbs":12.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0573';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":15.0,"carbs":5.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0574';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":15.0,"carbs":3.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0575';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":185,"protein":14.0,"carbs":4.5,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0576';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":4.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0577';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":170,"protein":19.0,"carbs":3.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0578';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":20.0,"carbs":0.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0579';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":18.0,"carbs":6.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0580';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":26.0,"carbs":0.5,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0581';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":4.5,"carbs":12.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0582';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":18.0,"carbs":8.5,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0583';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":13.0,"carbs":7.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0584';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":6.0,"fat":13.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0585';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":10.5,"carbs":8.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0586';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":9.0,"carbs":12.5,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0587';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":14.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0588';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":12.0,"carbs":7.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0589';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":15.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0590';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":12.0,"carbs":6.5,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0591';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":8.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0592';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":15.0,"carbs":6.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0593';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":8.0,"carbs":10.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0594';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":22.0,"carbs":1.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0595';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":19.0,"carbs":3.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0596';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":14.0,"carbs":4.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0597';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":18.0,"carbs":5.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0598';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":15.0,"carbs":12.5,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0599';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":7.0,"carbs":8.5,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0600';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":330,"protein":7.0,"carbs":35.0,"fat":16.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0601';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.5,"carbs":38.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0602';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":14.0,"carbs":15.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0603';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":14.0,"carbs":4.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0604';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.8,"carbs":18.5,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0605';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":9.0,"carbs":18.0,"fat":13.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0606';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":260,"protein":7.0,"carbs":40.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0607';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":310,"protein":6.5,"carbs":40.0,"fat":11.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0608';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":3.5,"carbs":55.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0609';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":35.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0610';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":16.0,"carbs":10.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0611';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":28.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0612';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":35.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0613';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":230,"protein":5.5,"carbs":30.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0614';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.5,"carbs":15.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0615';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":170,"protein":7.8,"carbs":14.5,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0616';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":6.5,"carbs":30.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0617';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":35.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0618';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":8.0,"carbs":20.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0619';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":6.5,"carbs":22.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0620';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.5,"carbs":14.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0621';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":13.0,"carbs":15.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0622';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":420,"protein":9.0,"carbs":55.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0623';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":75,"protein":1.5,"carbs":8.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0624';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.5,"carbs":14.0,"fat":5.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0625';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":10.2,"carbs":14.0,"fat":9.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0626';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":1.5,"carbs":8.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0627';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":6.5,"carbs":18.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0628';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":5.5,"carbs":35.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0629';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":18.0,"carbs":5.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0630';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":12.0,"carbs":10.5,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0631';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":480,"protein":7.0,"carbs":35.0,"fat":33.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0632';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":7.5,"carbs":22.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0633';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":3.2,"carbs":8.5,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0634';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":15.0,"carbs":8.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0635';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":7.0,"carbs":15.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0636';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":16.0,"carbs":4.5,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0637';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":7.5,"carbs":20.0,"fat":11.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0638';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":35.0,"fat":20.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0639';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":5.0,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0640';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":11.0,"carbs":20.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0641';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":9.0,"carbs":12.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0642';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":140,"protein":6.0,"carbs":18.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0643';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":120,"protein":11.0,"carbs":8.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0644';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":390,"protein":6.5,"carbs":40.0,"fat":22.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0645';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":5.5,"carbs":22.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0646';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":9.0,"carbs":22.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0647';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":110,"protein":5.0,"carbs":9.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0648';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":3.5,"carbs":38.0,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0649';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":3.0,"carbs":10.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0650';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":8.5,"carbs":25.0,"fat":8.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0651';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":180,"protein":4.0,"carbs":30.0,"fat":4.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0652';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":6.5,"carbs":18.0,"fat":12.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0653';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":15.0,"carbs":10.0,"fat":6.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0654';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":14.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0655';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.5,"carbs":30.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0656';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":16.0,"carbs":6.5,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0657';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":160,"protein":12.0,"carbs":5.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0658';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":5.0,"carbs":38.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0659';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":6.5,"carbs":15.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0660';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.0,"carbs":25.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0661';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":460,"protein":11.0,"carbs":38.0,"fat":28.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0662';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":7.5,"carbs":22.0,"fat":18.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0663';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":4.5,"carbs":20.0,"fat":10.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0664';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":70,"protein":1.2,"carbs":15.5,"fat":0.3}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0665';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":35.0,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0666';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.5,"carbs":18.0,"fat":24.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0667';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":12.0,"carbs":18.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0668';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":10.5,"carbs":15.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0669';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":165,"protein":16.0,"carbs":4.5,"fat":8.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0670';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":210,"protein":22.0,"carbs":8.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0671';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":7.0,"carbs":45.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0672';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":280,"protein":4.2,"carbs":30.5,"fat":15.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0673';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":8.0,"carbs":14.0,"fat":10.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0674';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":190,"protein":12.0,"carbs":18.0,"fat":7.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0675';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":320,"protein":6.5,"carbs":38.0,"fat":14.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0676';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":3.2,"carbs":7.5,"fat":9.8}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0677';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":130,"protein":4.0,"carbs":20.0,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0678';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":5.5,"carbs":25.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0679';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":4.5,"carbs":45.0,"fat":7.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0680';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":350,"protein":6.5,"carbs":55.0,"fat":12.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0681';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":220,"protein":12.0,"carbs":20.0,"fat":9.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0682';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":95,"protein":8.0,"carbs":7.5,"fat":3.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0683';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":250,"protein":8.0,"carbs":45.0,"fat":5.5}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0684';

update public.recipes
set macros = '{"basis":"per_100g","perServing":false,"calories":150,"protein":4.5,"carbs":18.0,"fat":6.0}'::jsonb,
    updated_at = coalesce(updated_at, now())
where id = 'recipe_0685';

commit;
