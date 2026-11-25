# Faith Mission App

A fluid mobile faith mission app built with Flutter. The complete King James Bible is bundled for offline reading; accounts, the blog and the chat rooms are online with Firebase. This app provides a comprehensive platform for believers to grow in their faith journey through daily Bible readings, community discussions, and spiritual growth tracking.

## Features

### Core Features
- **Daily Verse**: Receive a new Bible verse every day with beautiful backgrounds
- **KJV Bible**: Complete King James Version Bible with search and navigation
- **Blog Platform**: Read and publish faith-based articles and devotionals
- **Gospel Chat**: Community chat rooms focused on gospel discussions only

### Faith Journey Tracking
- **Role Progression**: Advance through faith roles based on consistent Bible reading
  - **Believer**: 7 consecutive days of reading
  - **Preacher**: 30 consecutive days of reading
  - **Shepherd**: 1 year (365 days) of reading
  - **Bishop**: 1000+ followers or pay to skip the ladder
- **Reading Statistics**: Track your reading habits, streaks, and progress
- **Milestones**: Celebrate achievements in your faith journey
- **Custom Titles**: Choose from various titles when you reach Bishop level

### Content Moderation
- **Automated Filtering**: Keyword-based moderation (whole-word matching, Scripture-safe) to prevent:
  - Political discussions
  - Offensive language
  - Toxic content
- **Manual Reporting**: Users can flag inappropriate content
- **Gospel-Focused**: Ensures all discussions stay focused on the Gospel

### Free features and Bishop access

> **Every feature is free.** The only locked item is skipping the faith-journey ladder straight to Bishop (which unlocks blog posting). In APKs shared directly, users contact the admin to arrange payment, and the admin then grants Bishop in the Firebase console; the Google Play build keeps it locked with no payment instructions. See `docs/firebase-setup.md` and `docs/google-play.md`.

The items below are the original plan and are not implemented:

- **Advanced Search**: Enhanced Bible search capabilities
- **Offline Mode**: Download and read the Bible without internet
- **Premium Content**: Access to exclusive devotionals, commentaries, and Bible studies
- **Reading Plans**: Guided Bible reading plans
- **Custom Themes**: Personalize the app appearance
- **Ad-Free Experience**: Remove all advertisements
- **Ladder Skip**: Pay to skip the faith journey ladder and become a Bishop immediately

### Social Features
- **Follow Users**: Connect with other believers
- **Like and Save**: Bookmark your favorite verses and posts
- **Comments**: Engage with blog posts through comments
- **Chat Rooms**: Join different discussion groups

## Getting Started

### Prerequisites
- Flutter SDK 3.38.4 or newer (stable channel)
- Android Studio (Android) and/or Xcode (iOS)

### Run it

```bash
git clone https://github.com/ephraimru/bible.git
cd bible
flutter pub get
flutter run            # pick a device, or: flutter run -d chrome
```

Accounts, blog and chat need a Firebase project: see
[`docs/firebase-setup.md`](docs/firebase-setup.md). To try everything without
one, run the local emulators and build against them:

```bash
firebase emulators:start --project demo-faith-mission --only auth,firestore
flutter run -d chrome --dart-define=USE_FIREBASE_EMULATOR=true
```

### Tests

```bash
flutter test
```

The tests cover the bundled Bible (all 66 books / 1,189 chapters / 31,102
verses, lookup and search), accounts and profile sync, the blog and chat
service, on-device storage, moderation rules, and reading streaks / role
promotion. The Firestore security rules have separate tests that run on the
emulator (see `docs/firebase-setup.md`).

### Regenerating models

Models use [Freezed](https://pub.dev/packages/freezed). The generated
`*.freezed.dart` / `*.g.dart` files are committed, so you only need this after
changing a model:

```bash
dart run build_runner build
```

### Google Play and direct builds

See [`docs/google-play.md`](docs/google-play.md) for the two Android builds
(Google Play bundle and direct APK), signing, Bishop unlock codes, the privacy
policy and the Play Console checklist.

### Android release signing

Create `android/key.properties` (it is git-ignored) with `storeFile`,
`storePassword`, `keyAlias` and `keyPassword`. Without it, release builds are
signed with the debug key.

## How it works

### Bible
`assets/data/bible_kjv.json` contains the full KJV (1769, public domain; text
sourced from [aruljohn/Bible-kjv](https://github.com/aruljohn/Bible-kjv), MIT)
plus a curated list of daily verses. `BibleService` loads it once at start-up
and provides:
- chapters and verses (`getVersesByChapter`, `getVerse`, `getVerseById`)
- search by phrase (`living water`) or by reference (`John 3:16`, `Ps 23`, `1 Cor 13:4-7`)
- a verse of the day that is the same for everyone on a given date

Verse ids are readable: `John.3.16`, `1 John.4.8`.

### Accounts
Email-and-password accounts with Firebase Authentication (`AuthService`),
including password-reset emails. Each account has a public profile at
`users/{uid}` in Firestore (name, bio, title, role; never the email) and a
copy on the device for the offline features. Bishop comes automatically at 1,000
followers, or is granted by the admin in the Firebase console, and syncs to the app.

### Blog and chat
`CommunityService` stores posts, comments, likes and chat messages in
Firestore and updates screens live. Only Bishops can publish posts; everyone
signed in can like, comment and chat in four fixed rooms. Members can report
content (to `reports`, read by the admin in the console) and block people.
Access is enforced by [`firestore.rules`](firestore.rules), which has its own
emulator tests in `test/firestore_rules`.

### Following and Bishop
Members follow each other from member profile pages (tap an author's name, or
long-press a chat message). Follower counts can't be faked: the security rules
only allow a count change together with the matching follower record. At
1,000 followers the app promotes the member to Bishop, which the rules also
verify. The admin can grant Bishop in the console too.

### Progress on every device
`ProgressSyncService` mirrors reading progress, saved and liked verses,
bookmarks, blocked people and settings to `users/{uid}/private/progress`
(readable only by the member) and merges changes from the member's other
devices live: chapters are combined, totals keep the larger value, and the
current streak comes from the most recently used device.

### Storage on the device
The Bible, reading progress, settings, saved verses, bookmarks and blocked
people live in [Hive](https://pub.dev/packages/hive) boxes via
`LocalStorageService`, stored as JSON. If the platform refuses persistent
storage, the app falls back to in-memory storage and says so.

### Faith journey
Mark a chapter as read at the end of it in the reader. Streaks count calendar
days (several chapters in one day count once; missing a day resets the streak).

| Role | Requirement |
|------|-------------|
| Believer | Starting role |
| Preacher | 30 consecutive days of reading |
| Shepherd | 365 consecutive days of reading |
| Bishop | 1,000+ followers (or the planned ladder-skip purchase) |

### Moderation
`ModerationService` checks chat messages, comments and posts:
- profanity and slurs are rejected
- insults are delivered but flagged for review
- two or more clearly political terms without gospel content are rejected
- words that appear in the KJV itself (devil, hell, kill, war, ...) are allowed, so Scripture can be quoted freely

Members can also flag messages, which files a moderation report.

### Notifications
Reading reminders and milestone notifications use
`flutter_local_notifications` on Android and iOS. They are disabled on web.

## Project Structure

```
lib/
├── main.dart, app.dart          # Start-up and MaterialApp
├── config/                      # theme, router (go_router + auth redirect), constants
├── models/                      # Freezed models (+ generated code)
├── services/
│   ├── bible_service.dart       # Bundled KJV: books, chapters, search, daily verse
│   ├── local_auth_service.dart  # On-device accounts
│   ├── local_storage_service.dart, json_box.dart  # Hive persistence
│   ├── faith_journey_service.dart
│   ├── moderation_service.dart
│   ├── notification_service.dart
│   └── premium_service.dart
├── screens/                     # auth, home, bible, blog, chat, profile, settings, premium, ...
└── widgets/                     # reusable UI pieces
assets/data/bible_kjv.json       # the complete KJV
test/                            # unit tests
```

## Known limitations

- In-app purchases and Google/Apple sign-in are not implemented.
- Notifications for new followers, comments or messages are not implemented.

## License

This project is licensed under the MIT License. The KJV text is in the public
domain.
