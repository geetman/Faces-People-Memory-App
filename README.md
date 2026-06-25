# 𝓕 Faces — People Memory App

> Never forget a face, a name, or a story again.
By Krishaang Kaushik & Nanometer Horizon

![GitHub Pages](https://img.shields.io/badge/Deployed%20on-GitHub%20Pages-222222?style=for-the-badge&logo=github)
![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![Vanilla JS](https://img.shields.io/badge/Built%20with-Vanilla%20JS-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![PWA](https://img.shields.io/badge/PWA-Ready-5A0FC8?style=for-the-badge&logo=pwa&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

---

Faces is a mobile-first progressive web app that helps you remember the people in your life — their names, nicknames, categories, tags, voice memos, and a full encounter timeline. Built with vanilla JS and Supabase as the backend.

---

## Screenshots & Features

### Core Features

| Feature | Details |
|---|---|
| 👤 **Person Cards** | Photo, name, nickname, category colour tab, totem emoji, tags, memory hook |
| 📷 **Photo Upload** | Camera or gallery, auto-cropped and compressed to a square |
| 🎙 **Voice Memos** | Hold-to-record up to 10 seconds, stored as base64 audio |
| 🏷 **Tags** | Freeform tags per person, colour-coded by name hash |
| ⭐ **Favourites** | Star any person, filter to favourites instantly |
| 🗂 **Categories** | Family, Friend, Acquaintance, Work, Professor, Doctor, Business Partner — each with a unique colour |
| 🔍 **Search** | Live search by name or nickname |
| 🔗 **Also Known By** | Link people who know each other |
| 📅 **Encounter Timeline** | Log every time you see someone — where, when, and what happened |
| 🔒 **Passphrase Lock** | Simple app-wide password stored in Supabase |
| 🌊 **Animated Background** | Three-layer wave + ambient blob background |

---

## Tech Stack

- **Frontend:** Vanilla HTML, CSS, JavaScript (ES Modules)
- **Backend / Database:** [Supabase](https://supabase.com) (PostgreSQL + Row Level Security)
- **Fonts:** Nunito via Google Fonts
- **Hosting:** GitHub Pages (or any static host)

---

## Installation & Setup

### 1. Clone or Download

```bash
git clone https://github.com/YOUR_USERNAME/faces-app.git
cd faces-app
```

Or download the ZIP from GitHub and extract it.

You should have these four files:
```
index.html
style.css
script.js
supabase_setup.sql
```

---

### 2. Set Up Supabase

#### What is `supabase_setup.sql`?

The repo includes a file called `supabase_setup.sql`. This is a ready-to-run SQL script that sets up your entire database in one go. It:

- Drops any existing Faces tables so you start clean
- Creates all 5 tables (`categories`, `people`, `person_connections`, `encounter_timeline`, `app_config`)
- Seeds the default categories (Family, Friend, Work, etc.) with their colours
- Inserts the default app passphrase (`change-me-now`)
- Enables Row Level Security on every table and applies the correct access policies

> [!CAUTION]
> This script **wipes and recreates** all Faces tables at the top (`drop table if exists … cascade`). Only run it on a fresh project, or if you are happy to lose existing data.

#### Running the Script

1. Go to [supabase.com](https://supabase.com) and create a free account
2. Click **New Project**, give it a name (e.g. `faces`), choose a region close to you, and set a database password — save it somewhere safe
3. Wait for the project to provision (~1 minute)
4. In the left sidebar go to **SQL Editor**
5. Click **New Query**
6. Open `supabase_setup.sql` from your local copy of the repo, select all the text, and paste it into the editor
7. Click **Run**

> [!NOTE]
> If everything worked you will see all 5 tables appear in the left sidebar under **Table Editor**: `categories`, `people`, `person_connections`, `encounter_timeline`, `app_config`.

#### Change Your App Password

> [!CAUTION]
> The default passphrase is `change-me-now`. **Do not leave it as the default** — anyone who finds your app URL will be able to get in.

To change it, go to **SQL Editor** in your Supabase project, click **New Query**, and run:

```sql
update app_config set value = 'your-new-passphrase' where key = 'app_password';
```

Replace `your-new-passphrase` with whatever you want your password to be, then click **Run**.

> [!TIP]
> To double-check what your current passphrase is set to, run this in the SQL Editor:
> ```sql
> select value from app_config where key = 'app_password';
> ```

> [!NOTE]
> This passphrase is stored in plain text in your database and checked client-side. It is a lightweight lock to keep casual visitors out — not a substitute for full authentication. See the security section below if you need stronger protection.

#### Get Your Supabase Credentials

1. In your Supabase project, go to **Project Settings** → **API**
2. Copy your **Project URL** (looks like `https://xxxxxxxxxxxx.supabase.co`)
3. Copy your **anon / public** key (long JWT string)

---

### 3. Add Your Credentials to script.js

Open `script.js` and find these two lines near the top:

```js
const SUPABASE_URL  = 'Edit-Me';
const SUPABASE_ANON = 'Edit-Me';
```

Replace them with your actual values:

```js
const SUPABASE_URL  = 'https://xxxxxxxxxxxx.supabase.co';
const SUPABASE_ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

> [!NOTE]
> The anon key is safe to expose in frontend code — it is public by design. Your data is protected by Row Level Security (RLS) policies, not by keeping this key secret.

---

### 4. Deploy to GitHub Pages

1. Push your three files (`index.html`, `style.css`, `script.js`) to a GitHub repository
2. Go to your repo on GitHub → **Settings** → **Pages**
3. Under **Source**, select **Deploy from a branch**
4. Choose **main** branch and **/ (root)** folder
5. Click **Save**
6. After ~60 seconds your app will be live at:
   ```
   https://YOUR_USERNAME.github.io/REPO_NAME/
   ```

> [!TIP]
> Every time you push changes to the main branch, GitHub Pages will automatically redeploy.

---

## Install as a Mobile App (PWA)

Faces works as a full-screen app on both iOS and Android — no App Store required.

### iOS (Safari)

1. Open your GitHub Pages URL in **Safari** (must be Safari, not Chrome)
2. Tap the **Share** button (box with arrow pointing up)
3. Scroll down and tap **Add to Home Screen**
4. Give it a name (e.g. `Faces`) and tap **Add**
5. The app icon will appear on your home screen and open full-screen with no browser UI

### Android (Chrome)

1. Open your GitHub Pages URL in **Chrome**
2. Tap the **three-dot menu** (⋮) in the top right
3. Tap **Add to Home screen** (or **Install app** if shown)
4. Tap **Add** on the confirmation prompt
5. The app will appear on your home screen and launch like a native app

> [!TIP]
> On Android you may also see an **Install app** banner appear automatically at the bottom of the screen after a few visits.

---

## Supabase Security — How It Works

This app uses **Row Level Security (RLS)** on all Supabase tables. Here is what the setup SQL creates:

| Table | Policy |
|---|---|
| `categories` | Anyone can **read** (anon select) |
| `people` | Anyone can **read, insert, update, delete** (anon full access) |
| `person_connections` | Anyone can **read, insert, update, delete** (anon full access) |
| `encounter_timeline` | Anyone can **read, insert, update, delete** (anon full access) |
| `app_config` | Anyone can **read** (anon select only — no writes) |

The app is protected by a **passphrase** stored in `app_config`. Without the correct passphrase, the app will not unlock and data will not be displayed.

> [!IMPORTANT]
> If you want stronger security, replace the passphrase system with Supabase Auth (email/password or magic link) and scope RLS policies to `auth.uid()`. This is left as an enhancement for advanced users.

---

## Database Schema

```
categories
  id       uuid PK
  name     text
  colour   text (hex)

people
  id                    uuid PK
  name                  text
  nickname              text
  relationship_category uuid → categories.id
  memory_hook           text
  photo_url             text (base64)
  totem_emoji           text
  tags                  text[]
  voice_memo            text (base64)
  last_seen             date
  favourite             boolean
  created_at            timestamptz

person_connections
  id        uuid PK
  person_a  uuid → people.id
  person_b  uuid → people.id

encounter_timeline
  id         uuid PK
  person_id  uuid → people.id
  seen_at    timestamptz
  location   text
  note       text

app_config
  key   text PK
  value text
```

---

## Common Issues & Fixes

### 🔴 "Could not reach the server. Check your config."

**Cause:** `SUPABASE_URL` or `SUPABASE_ANON` in `script.js` are still set to `'Edit-Me'` or are incorrect.

**Fix:** Double-check both values in `script.js` match exactly what is shown in Supabase → Project Settings → API.

---

### 🔴 "Wrong passphrase. Try again."

**Cause:** You are entering the wrong password, or you haven't changed it from the default yet.

**Fix:** Run this in Supabase SQL Editor to check or update it:
```sql
select value from app_config where key = 'app_password';
update app_config set value = 'your-passphrase' where key = 'app_password';
```

---

### 🔴 App is blank / white screen after deploy

**Cause:** Browser is blocking the Supabase JS import from the CDN, or there is a JS error.

**Fix:**
- Open browser DevTools (F12) → Console tab and look for errors
- Make sure your repo is public if using the free GitHub Pages tier
- Check that all three files (`index.html`, `style.css`, `script.js`) are in the root of the repo, not inside a subfolder

---

### 🔴 Cards showing in a single column instead of a grid

**Cause:** An older version of `script.js` was wrapping cards in a redundant inner `div.cards-grid`.

**Fix:** Make sure you are using the latest `script.js` where cards are appended directly to `#cards-container`.

---

### 🔴 Photos / voice memos not saving

> [!WARNING]
> Supabase has a **row size limit of ~1MB** per row. Large photos or long voice recordings stored as base64 can exceed this.

**Fix:**
- Photos are already auto-compressed to 300×300px JPEG — avoid taking very high-res photos
- Keep voice memos under 10 seconds (the app enforces this)
- If you need larger storage, consider using Supabase Storage instead of base64 columns

---

### 🔴 "Add to Home Screen" not appearing on iOS

**Cause:** You are using Chrome or Firefox on iOS — they use Safari's engine but the PWA install prompt only works from Safari itself.

**Fix:** Open the URL in **Safari** specifically, then use the Share → Add to Home Screen flow.

---

### 🔴 App resets / forgets login after closing

**Cause:** The auth state is stored in `sessionStorage`, which clears when the browser tab is fully closed.

**Fix:** This is by design for security. Just re-enter your passphrase. If you want persistent login, change `sessionStorage` to `localStorage` in `script.js`:
```js
// Find these two lines and change sessionStorage → localStorage
if (sessionStorage.getItem('faces_auth') === '1') unlock();
sessionStorage.setItem('faces_auth', '1');
```

---

### 🔴 Voice recording not working

**Cause:** Browser microphone permission was denied, or the page is served over HTTP (not HTTPS).

**Fix:**
- GitHub Pages serves over HTTPS automatically — use that URL, not a local `file://` path
- If testing locally, use `localhost` (browsers allow mic on localhost)
- Check browser site settings and make sure microphone is allowed for the domain

---

## Local Development

> [!CAUTION]
> You cannot open `index.html` directly as a `file://` URL because ES Modules and the Supabase CDN import require HTTP. Use a simple local server:

```bash
# Python 3
python3 -m http.server 8000

# Node.js (npx)
npx serve .
```

Then open `http://localhost:8000` in your browser.

---

## Customising Categories

To add or change categories, run SQL in the Supabase SQL Editor:

```sql
-- Add a new category
insert into categories (name, colour) values ('Neighbour', '#0D9488');

-- Change a colour
update categories set colour = '#BE185D' where name = 'Friend';

-- Remove a category (people in it will have their category set to null)
delete from categories where name = 'Acquaintance';
```

---

## License

Licensed under CC BY 4.0 — https://creativecommons.org/licenses/by/4.0/

---


