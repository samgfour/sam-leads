-- For an EXISTING leads table (skip schema.sql). Run in the Supabase SQL editor.

alter table public.leads
  add column if not exists user_id uuid default auth.uid() references auth.users(id) on delete cascade;

alter table public.leads enable row level security;

-- remove whatever policies were there before
do $$
declare p record;
begin
  for p in select policyname from pg_policies where schemaname = 'public' and tablename = 'leads' loop
    execute format('drop policy %I on public.leads', p.policyname);
  end loop;
end $$;

create policy "own leads: select" on public.leads for select to authenticated using (user_id = auth.uid());
create policy "own leads: insert" on public.leads for insert to authenticated with check (user_id = auth.uid());
create policy "own leads: update" on public.leads for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own leads: delete" on public.leads for delete to authenticated using (user_id = auth.uid());

-- AFTER you have signed in once, claim your old rows (put your email in):
-- update public.leads set user_id = (select id from auth.users where email = 'you@example.com') where user_id is null;
