# Intern Board

A single-page, GitHub Pages–hosted Jira-style board for interns. Staff can submit new tickets; interns' work is shown in a Kanban view (Assigned / In Progress / Completed). Backend is Supabase.

## Features
- **Kanban board**: Assigned and In Progress by default, with an optional **Completed** column toggled on/off.
- **Expandable tickets**: click "Status updates" on a card to expand it. Each ticket keeps a history of status updates, each with a **date** and up to **400 words** of text (live word counter).
- **Latest update preview**: collapsed cards show the most recent status update — its date plus a 20-word preview.
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

1. Create a project at [supabase.com](https://supabase.com) (or link this repo to an existing one).
2. Apply the schema with the CLI: `supabase db push` (this creates the `tickets` and `status_updates` tables, with RLS allowing public anon access for demo — tighten if the board should not be publicly editable).
3. Copy the project **URL** and **anon key** (Project Settings → API) into `index.html` under `// CONFIG`.

This repo is already linked to the `intern-board` project (`gvvajesgltbaakxnqzbs`) and the schema is applied.

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
