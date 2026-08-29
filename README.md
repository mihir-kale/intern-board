# Intern Board

A single-page, GitHub Pages–hosted Jira-style board for interns. Staff can submit new tickets; interns' work is shown in a Kanban view (Not Started / Started / Complete). Backend is Supabase.

## Features
- **3-column board**: Not Started, Started, Complete, with card colors and move buttons.
- **Tag toggles** above the board to filter by intern (one per intern, plus "All").
- **Location box** on the right showing each intern's status: Remote, In Office, or Next Time.
- **Ticket cards**: title, due date (with overdue highlighting), assigned intern, optional assignee, up to two hyperlink/title pairs, and optional notes.

## Interns (hard-coded)
Edit the `INTERNS` object at the top of `index.html` (under `// CONFIG`) to change names or locations:

```js
const INTERNS = {
  'Lydia Love':   'remote',
  'Mihir Kale':   'office',
  'Colin Tierney':'next',
  'Eli Bright':   'remote',
};
```

Location values: `remote`, `office`, or `next`.

## Backend (Supabase)

1. Create a project at [supabase.com](https://supabase.com).
2. Open **SQL Editor**, paste and run `supabase/schema.sql` to create the `tickets` table (RLS allows public anon access for demo — tighten this if the board should not be publicly editable).
3. Copy the project **URL** and **anon key** (Project Settings → API).

**Note:** If you have the Supabase CLI set up, you can apply the schema with `supabase db push`, but hosting this static site still needs the URL + anon key placed in `index.html`.

## Configure

In `index.html`, under `// CONFIG`, set:

```js
const SUPABASE_URL = 'https://<your-project-ref>.supabase.co';
const SUPABASE_ANON_KEY = '<your-anon-key>';
```

## Deploy to GitHub Pages

1. Push this repo to GitHub.
2. Repo → **Settings → Pages** → set Source to **Deploy from a branch** → select `main` and `/ (root)` → Save.
3. Your board is live at `https://<user>.github.io/<repo>/`.

## Security note

This setup uses the Supabase anon key in the browser, so anyone with the link can read/write tickets. For public demo this is fine. For internal use, restrict RLS to authenticated users and add auth (see `supabase/schema.sql` for the demo policy).
