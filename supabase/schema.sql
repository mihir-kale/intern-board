-- Intern Board schema for Supabase
-- Run this in the Supabase SQL editor (https://supabase.com/dashboard -> SQL Editor)

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
  status text not null default 'not_started'
    check (status in ('not_started', 'started', 'complete')),
  created_at timestamptz not null default now()
);

-- Row Level Security: allow public anon read/write for dev.
-- Lock this down if the board should not be publicly editable.
alter table public.tickets enable row level security;

create policy "allow all anon"
  on public.tickets
  for all
  to anon
  using (true)
  with check (true);

-- Optional: a view of interns -> latest location (hosted client-side, not needed here)
