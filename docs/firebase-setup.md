# Firebase setup (accounts, blog and chat)

Faith Mission uses Firebase for accounts and the shared blog and chat. The
Bible, reading progress and settings stay on the device. Firebase's free
"Spark" plan is enough to start (about 50,000 reads and 20,000 writes per day);
no credit card is needed.

## 1. Create the project (about 10 minutes)

1. Go to https://console.firebase.google.com and sign in with your Google
   account. Click **Create a project**, name it `faith-mission`, and finish
   the steps (Google Analytics is not needed).
2. **Authentication:** Build → Authentication → Get started → Sign-in method
   → **Email/Password** → Enable → Save.
3. **Firestore:** Build → Firestore Database → Create database → choose a
   location near your users → start in **production mode**.
4. **Security rules:** Firestore Database → **Rules** tab → replace everything
   with the contents of [`firestore.rules`](../firestore.rules) → **Publish**.
5. **Android app:** Project Overview → Add app → Android →
   package name `com.faithmission.app` → Register app →
   **Download `google-services.json`**. You can skip the remaining steps.
6. Send `google-services.json` to the developer (it is not a secret). It goes
   into `lib/firebase_options.dart`; the next app build then uses the project.
   (Or run `flutterfire configure` yourself, which writes that file.)

## 2. Bishop

Members become Bishop **automatically when they reach 1,000 followers**
(the security rules check the real count). You can also grant it yourself,
for example after someone pays to skip the ladder:

1. Firebase console → Authentication → **Users**: find the buyer's email and
   copy their **User UID**.
2. Firestore Database → **Data** → `users` → the document with that UID.
3. Click the `role` field and change its value to `bishop` → Update.

The buyer's app switches to Bishop within seconds (they can publish blog
posts). To undo, set `role` back to `believer`. Apart from the 1,000-follower
rule, only the console can make someone a Bishop; the security rules forbid
users from granting it to themselves.

## 3. Moderation

- **Reports:** Firestore → Data → `reports`. Each report has the reason, a short
  excerpt, `contentPath` (where the reported item is) and the author's UID.
- **Removing content:** open the `contentPath` (for example
  `rooms/general/messages/abc123`) in Firestore → Data and delete the document.
- **Blocking a person from the whole app:** Authentication → Users → ⋮ →
  **Disable account**.

## 4. Where the data lives

| Firestore path | What |
|---|---|
| `users/{uid}` | Public profile: name, bio, title, role, follower count. Never the email. |
| `users/{uid}/followers/{followerUid}` | One document per follower |
| `users/{uid}/following/{targetUid}` | Who the member follows |
| `users/{uid}/private/progress` | The member's reading progress, saved verses, bookmarks, blocked people and settings, synced between their devices. Only they can read it. |
| `posts/{postId}` | Blog posts (`likedBy` holds who liked it) |
| `posts/{postId}/comments/{commentId}` | Comments |
| `rooms/{roomId}/messages/{messageId}` | Chat messages; rooms are `general`, `prayer`, `bible-study`, `testimonies` |
| `reports/{reportId}` | Reports; only visible in the console |

Emails and passwords are kept by Firebase Authentication, not in Firestore.

## For developers

- Local testing without a real project:
  `firebase emulators:start --project demo-faith-mission --only auth,firestore`
  and build with `--dart-define=USE_FIREBASE_EMULATOR=true`.
- Security-rule tests:
  `firebase emulators:exec --only firestore --project demo-faith-mission "npm --prefix test/firestore_rules test"`
  (run `npm --prefix test/firestore_rules install` once first).
- Deploy rule changes: `firebase deploy --only firestore:rules`.
