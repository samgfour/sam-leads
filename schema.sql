-- Sales Cycle Tracker: schema for new installs (run in the Supabase SQL editor).
-- Each signed-in user can only see and change their own leads.

create table if not exists public.leads (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name          text not null,
  company       text not null,
  phone         text,
  stage         text not null default 'New'
                check (stage in ('New','Contacted','Proposal Sent','Negotiation','Won','Lost')),
  last_contact  date,
  follow_up     date,
  reminder_time text not null default '09:00',  -- stored as HH:MM text
  notes         text,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

create or replace function public.set_updated_at() returns trigger
language plpgsql as $$
begin new.updated_at = now(); return new; end $$;

drop trigger if exists leads_set_updated_at on public.leads;
create trigger leads_set_updated_at before update on public.leads
  for each row execute function public.set_updated_at();

alter table public.leads enable row level security;

create policy "own leads: select" on public.leads for select to authenticated using (user_id = auth.uid());
create policy "own leads: insert" on public.leads for insert to authenticated with check (user_id = auth.uid());
create policy "own leads: update" on public.leads for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own leads: delete" on public.leads for delete to authenticated using (user_id = auth.uid());
