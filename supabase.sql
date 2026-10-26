-- Run this in Supabase SQL Editor. Create an Auth user for the site owner in Authentication > Users.
create table if not exists public.gift_media (
  id uuid primary key default gen_random_uuid(),
  title text not null default 'Untitled evidence',
  caption text not null default 'Exhibit A: absolute nonsense.',
  media_type text not null check (media_type in ('photo','video')),
  category text not null default 'Caught in 4K',
  storage_path text not null,
  created_at timestamptz not null default now()
);
alter table public.gift_media enable row level security;
-- Public recipient gallery can read metadata; storage bucket is private and signed URLs are generated for display.
create policy "gift media metadata can be read" on public.gift_media for select using (true);
create policy "authenticated owner can add media" on public.gift_media for insert to authenticated with check (true);
create policy "authenticated owner can edit media" on public.gift_media for update to authenticated using (true) with check (true);
create policy "authenticated owner can delete media" on public.gift_media for delete to authenticated using (true);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('gift-media','gift-media',false,524288000,array['image/jpeg','image/png','image/webp','image/gif','video/mp4','video/webm','video/quicktime'])
on conflict (id) do nothing;
create policy "authenticated owner uploads gift media" on storage.objects for insert to authenticated with check (bucket_id = 'gift-media');
create policy "gift media objects can be read for signed urls" on storage.objects for select using (bucket_id = 'gift-media');
create policy "authenticated owner updates gift media" on storage.objects for update to authenticated using (bucket_id = 'gift-media');
create policy "authenticated owner deletes gift media" on storage.objects for delete to authenticated using (bucket_id = 'gift-media');
