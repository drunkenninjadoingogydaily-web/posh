# POSH — Point of Sale Hub

> A smart, offline-first Point of Sale web app for small business owners. Built as a Progressive Web App (PWA) with Firebase cloud sync and authentication.

---

## Features

- Fast sales with cart and change calculator
- Real-time inventory and stock alerts
- Credit book for tracking customer debts
- Daily dashboard with profit, revenue and goal tracking
- Reports with charts and PDF export
- Firebase cloud sync — data safe even if phone is lost
- Secure login with email and password per user
- Works 100% offline after first load
- Installable on Android and iPhone as a PWA

---

## Tech Stack

- Vanilla HTML, CSS, JavaScript — no frameworks
- Firebase Authentication (email/password)
- Firebase Firestore (cloud database)
- Service Worker (offline support)
- Netlify (hosting + build injection)

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/posh-pos.git
cd posh-pos
```

### 2. Create a Firebase project

1. Go to [console.firebase.google.com](https://console.firebase.google.com)
2. Click **Add Project** → name it anything
3. Go to **Authentication** → Enable **Email/Password**
4. Go to **Firestore Database** → Create Database → Start in test mode
5. Go to **Project Settings** → Your Apps → click **</>** Web
6. Register the app and copy the config values

### 3. Set up environment variables

Copy the example file:
```bash
cp .env.example .env
```

Fill in your Firebase values in `.env`:
```
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.firebasestorage.app
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
```

### 4. Test locally

```bash
bash build.sh
python3 -m http.server 8080
```

Open `http://localhost:8080` in Chrome.

### 5. Deploy to Netlify

**Option A — Connect GitHub (recommended):**
1. Push your repo to GitHub
2. Go to [netlify.com](https://netlify.com) → New site from Git
3. Connect your GitHub repo
4. Go to **Site Settings → Environment Variables**
5. Add all 6 Firebase variables from your `.env` file
6. Redeploy — done!

**Option B — Manual deploy:**
1. Run `bash build.sh` locally
2. Drag and drop your folder to [netlify.com/drop](https://netlify.com/drop)

---

## Firestore Security Rules

After testing, update your Firestore rules to this for proper security:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /shops/{userId} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;
    }
  }
}
```

---

## Project Structure

```
posh-pos/
├── index.html          # Main app (UI + logic)
├── sw.js               # Service worker (offline)
├── manifest.json       # PWA manifest
├── build.sh            # Netlify build script (injects env vars)
├── netlify.toml        # Netlify configuration
├── icon-192.png        # App icon (small)
├── icon-512.png        # App icon (large)
├── .env.example        # Environment variables template
├── .env                # Your secrets (never committed)
├── .gitignore          # Git ignore rules
└── README.md           # This file
```

---

## Environment Variables

| Variable | Description |
|---|---|
| `FIREBASE_API_KEY` | Firebase API key |
| `FIREBASE_AUTH_DOMAIN` | Firebase auth domain |
| `FIREBASE_PROJECT_ID` | Firebase project ID |
| `FIREBASE_STORAGE_BUCKET` | Firebase storage bucket |
| `FIREBASE_MESSAGING_SENDER_ID` | Firebase messaging sender ID |
| `FIREBASE_APP_ID` | Firebase app ID |

---

## License

Copyright (c) 2026 POSH — Point of Sale Hub

See [LICENSE](LICENSE) for full terms.

---

## Author

Built with care for small business owners across Kenya and beyond.

---

> POSH works on any phone, any browser, any network condition.
