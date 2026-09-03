-- Enable Postgres Realtime for tickets & status_updates so the board
-- live-syncs across tabs/browsers without a manual refresh.
alter publication supabase_realtime add table public.tickets;
alter publication supabase_realtime add table public.status_updates;
