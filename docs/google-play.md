# Publishing Faith Mission on Google Play

## Builds

There are two Android builds:

| Build | Command | Bishop skip |
|-------|---------|-------------|
| Google Play | `flutter build appbundle --release --dart-define=DISTRIBUTION=play` | Locked; Bishop only via 1,000 followers. No outside-payment instructions (Play's payments policy requires Google Play Billing for in-app features). |
| Direct APK (shared yourself) | `flutter build apk --release` | Locked; shows the admin email and an "Enter unlock code" box. |

Output: `build/app/outputs/bundle/release/app-release.aab` and
`build/app/outputs/flutter-apk/app-release.apk`.

Before each new upload, raise `version:` in `pubspec.yaml` (for example
`1.0.1+2`; the number after `+` must always increase).

## Signing (upload key)

Release builds are signed with the **upload key** when `android/key.properties`
exists (it is git-ignored):

```
storePassword=...
keyPassword=...
keyAlias=upload
storeFile=/absolute/path/to/faith-mission-upload.jks
```

Keep `faith-mission-upload.jks` and its password backed up and private. With
Play App Signing (the default), Google holds the final app-signing key; if the
upload key is ever lost, you can ask Google Play support to reset it.

## Bishop unlock codes (direct APK only)

- Private key: `faith-mission-bishop-private-key.txt`. Keep it secret and
  backed up; never commit it. Anyone with it can unlock any account.
- Make a code: open `tool/bishop_code_generator.html` in a browser (or
  `dart run tool/bishop_codes.dart sign <key-file> <email>`), using the buyer's
  **Faith Mission account email**. The code only works for that email.
- The buyer pastes it in Profile → How to become a Bishop → Enter unlock code.

## Play Console checklist

1. Create a developer account at https://play.google.com/console (one-time
   US$25). New personal accounts must run a **closed test with at least 12
   testers for 14 days** before they can publish to production.
2. Create the app: name "Faith Mission", default language English, App, Free.
3. **Privacy policy:** publish `docs/privacy-policy.html` at a public URL and
   paste the URL in App content → Privacy policy.
4. **App access:** all features are available after creating a free account
   in the app; no special login is needed for review.
5. **Ads:** No ads.
6. **Content rating:** complete the questionnaire. Answer "yes" to users
   creating content (blog posts and chat messages), which stay on the device.
7. **Target audience:** 13 and over.
8. **Data safety:** the app does not send any data off the device, so:
   - Does your app collect or share any of the required user data types? **No**
   - (Data stored only on the device is not "collected" under Play's definition.)
9. **Store listing:** use the text below and the graphics (512×512 icon,
   1024×500 feature graphic, phone screenshots 1080×1920).
10. Upload `app-release.aab` to the closed testing track, add testers, and
    after the testing period, promote it to Production.

## Store listing text

**App name:** Faith Mission

**Short description (80 characters max):**
The complete King James Bible offline, with daily verses and reading streaks.

**Full description:**

Faith Mission helps you read the Bible every day and grow in your faith.

THE WHOLE KING JAMES BIBLE, OFFLINE
All 66 books are built into the app, so you can read anywhere, with no internet connection needed.

FIND ANY VERSE FAST
Search by word or phrase ("living water"), or jump straight to a reference such as John 3:16, Psalm 23 or 1 Corinthians 13:4-7.

A VERSE FOR EVERY DAY
Start each day with a hand-picked verse of the day.

GROW ON YOUR FAITH JOURNEY
Mark chapters as read, build a daily reading streak, and grow from Believer to Preacher (30 days) and Shepherd (365 days). Reach milestones and choose a title as you go.

COMMUNITY
Read the blog and join gospel-focused discussions, with moderation that keeps the conversation respectful and lets you quote Scripture freely.

GENTLE REMINDERS
Optional daily reminders help you keep your reading habit.

FREE AND PRIVATE
Every feature is free. There are no ads, and your account and reading progress stay on your device.
