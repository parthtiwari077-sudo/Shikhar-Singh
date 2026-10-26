# Classified Files: Shikhar Singh

A React + Vite meme scrapbook gift site. It includes the photos and five videos supplied in the conversation, an animated reveal, categorized photo gallery/lightbox, video cinema, humorous awards and stats, an editable friendship message, finale secret, and an admin sign-in/upload UI.

## Run locally

1. Install Node.js 20+.
2. In this folder run `npm install`.
3. Run `npm run dev` and open the local URL printed by Vite.
4. `npm run build` creates the production site in `dist/`.

The bundled sample photos and videos work without any backend. In preview mode, additional uploads use temporary browser object URLs and are not permanent. Use Supabase setup below for online persistent uploads.

## Persistent storage and admin authentication

1. Create a Supabase project.
2. In Supabase SQL Editor, run `supabase.sql`.
3. In Authentication > Users, create the owner account with email/password.
4. Copy `.env.example` to `.env` and fill `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` with your project URL and publishable/anon key. Never put a service-role key in this frontend.
5. Restart `npm run dev`. Use **Owner login** to sign in. Uploads made while signed in are stored in the `gift-media` bucket and metadata in `gift_media`.

### Privacy / production note

The bundled media in `public/media` is public static site content. Anyone who can access the published website can fetch those files. For a genuinely private gift, do not deploy private photos/videos in `public/`; use private Supabase Storage and a server-side Edge Function or API that authenticates the owner, issues recipient-scoped signed URLs, and enforces a gift/passcode token. The included SQL is a starter, not a complete production access-control system; review and tighten its storage and row-level policies before publishing sensitive media. The optional in-app passcode UI is a simple front-end gate, not strong security. The website currently uses a local demo mode until Supabase is configured.

## Publish and share

Build with `npm run build`, then deploy the project to a static host such as Vercel or Netlify. Set the same Vite environment variables in the host's project settings and redeploy. Share the resulting site URL with Shikhar. Before sharing, decide whether the bundled photos/videos are okay to be accessible to anyone with the URL, and implement recipient authentication/signed URLs if you need actual privacy.
