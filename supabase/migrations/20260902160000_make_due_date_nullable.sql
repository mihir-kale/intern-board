-- Allow tickets without a due date (blank / "n/a" in the source sheet).
alter table public.tickets
  alter column due_date drop not null;
