create table if not exists points_system (
  id text primary key,
  persons jsonb default '[]'::jsonb,
  teams jsonb default '[]'::jsonb,
  history jsonb default '[]'::jsonb,
  updated_at timestamptz default now()
);

-- 如果表已经存在，补充 teams 列
alter table points_system add column if not exists teams jsonb default '[]'::jsonb;

alter table points_system enable row level security;
drop policy if exists "Allow all access" on points_system;
create policy "Allow all access" on points_system
  for all using (true) with check (true);

alter publication supabase_realtime add table points_system;