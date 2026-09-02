-- Intern Board schema for Supabase
-- Applied via: supabase db push
-- Manual setup in Supabase dashboard:
--   1. Create a project
--   2. supabase link --project-ref <ref>
--   3. supabase db push

-- Tickets table
create table if not exists public.tickets (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  due_date date not null,
  intern text not null,
  assignee text,
  hyperlink_1 text,
  hyperlink_title_1 text,
  hyperlink_2 text,
  hyperlink_title_2 text,
  notes text,
  status text not null default 'assigned'
    check (status in ('assigned', 'in_progress', 'complete')),
  created_at timestamptz not null default now()
);

-- Status updates per ticket: an append-only history of {date, text}
-- Each ticket expands to reveal (and add) these. Collapsed card shows the most recent.
create table if not exists public.status_updates (
  id uuid primary key default gen_random_uuid(),
  ticket_id uuid not null references public.tickets (id) on delete cascade,
  update_date date not null,
  body text not null check (char_length(body) <= 400),
  created_at timestamptz not null default now()
);

create index if not exists status_updates_ticket_id_idx
  on public.status_updates (ticket_id, update_date desc);

-- Row Level Security: allow public anon read/write for dev.
-- Lock this down if the board should not be publicly editable.
alter table public.tickets enable row level security;
alter table public.status_updates enable row level security;

create policy "allow all anon" on public.tickets
  for all to anon using (true) with check (true);

create policy "allow all anon" on public.status_updates
  for all to anon using (true) with check (true);
