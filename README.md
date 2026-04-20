# mealprep

Flutter meal prep app with Supabase Auth + basic database schema.

## Supabase setup

Create a Supabase project manually, then configure the app:

1. Create a `.env` file in the project root (already included locally, ignored by git):

```
SUPABASE_URL=YOUR_SUPABASE_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

2. Install packages:

```bash
flutter pub get
```

## Database migrations (Supabase SQL)

Migration SQL files live in `migrations/`:

- `001_create_users_table.sql`
- `002_create_inventory_table.sql`
- `003_create_recipes_table.sql`
- `004_create_shopping_list_table.sql`
- `005_create_saved_recipes_table.sql`
- `006_create_user_dietary_preferences_table.sql`
- `007_create_user_premium_status_table.sql`

To apply them:

1. Open Supabase Dashboard → SQL Editor
2. Run the migration files in order (001 → 007)

Notes:

- RLS policies are enabled in each migration to protect user data.
- `public.users` is a profile table linked to `auth.users`.
- Recipes are readable by anyone (shared content). User-owned tables are restricted by `auth.uid()`.

## Auth flow (email/password)

The app uses Supabase email/password auth:

- Sign up: email + password (+ optional full name)
- Login: email + password
- Logout: signs out from Supabase
- Password reset: sends email reset link (handled by Supabase)
- Auto-login: session is restored automatically on app launch

