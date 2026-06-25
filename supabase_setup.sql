-- ═══════════════════════════════════════════════════
--  FACES — People Memory App · Supabase Setup v2
--  Run this in Supabase SQL Editor (fresh wipe first)
-- ═══════════════════════════════════════════════════

drop table if exists person_connections cascade;
drop table if exists encounter_timeline cascade;
drop table if exists people cascade;
drop table if exists categories cascade;
drop table if exists app_config cascade;

-- 1. Categories (with colour)
create table categories (
  id     uuid primary key default gen_random_uuid(),
  name   text not null unique,
  colour text not null default '#9a7de0'
);

insert into categories (name, colour) values
  ('Family',           '#7C3AED'),
  ('Friend',           '#059669'),
  ('Acquaintance',     '#D97706'),
  ('Work',             '#2563EB'),
  ('Professor',        '#EA580C'),
  ('Doctor',           '#0891B2'),
  ('Business Partner', '#DC2626');

-- 2. People
create table people (
  id                    uuid primary key default gen_random_uuid(),
  name                  text not null,
  nickname              text,
  relationship_category uuid references categories(id) on delete set null,
  memory_hook           text,
  photo_url             text,        -- base64 data URI
  totem_emoji           text,        -- single emoji e.g. 🎸
  tags                  text[],      -- array of freeform tag strings
  voice_memo            text,        -- base64 audio
  last_seen             date,
  favourite             boolean not null default false,
  created_at            timestamptz default now()
);

-- 3. Also Known By — bidirectional connections between people
create table person_connections (
  id         uuid primary key default gen_random_uuid(),
  person_a   uuid not null references people(id) on delete cascade,
  person_b   uuid not null references people(id) on delete cascade,
  created_at timestamptz default now(),
  unique(person_a, person_b),
  check (person_a <> person_b)
);

-- 4. Encounter timeline
create table encounter_timeline (
  id         uuid primary key default gen_random_uuid(),
  person_id  uuid not null references people(id) on delete cascade,
  seen_at    timestamptz not null default now(),
  location   text,
  note       text,
  created_at timestamptz default now()
);

-- 5. App config (password)
create table app_config (
  key   text primary key,
  value text not null
);

insert into app_config (key, value)
  values ('app_password', 'change-me-now');

-- ═══════════════════════════════════════════════════
-- 6. Row Level Security
-- ═══════════════════════════════════════════════════
alter table categories         enable row level security;
alter table people             enable row level security;
alter table person_connections enable row level security;
alter table encounter_timeline enable row level security;
alter table app_config         enable row level security;

create policy "anon read categories"          on categories         for select using (true);
create policy "anon full people"              on people             for all    using (true) with check (true);
create policy "anon full connections"         on person_connections for all    using (true) with check (true);
create policy "anon full timeline"            on encounter_timeline for all    using (true) with check (true);
create policy "anon read app_config"          on app_config         for select using (true);
