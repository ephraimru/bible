# Publishing Faith Mission on Google Play

## Builds

There are two Android builds:

| Build | Command | Bishop skip |
|-------|---------|-------------|
| Google Play | `flutter build appbundle --release --dart-define=DISTRIBUTION=play` | Locked. No outside-payment instructions (Play's payments policy requires Google Play Billing for in-app features). |
| Direct APK (shared yourself) | `flutter build apk --release` | Locked; shows the admin email. After payment the admin grants Bishop in the Firebase console. |

Both need the Firebase project connected first (see
[firebase-setup.md](firebase-setup.md)); otherwise sign-in shows "Online
accounts are not set up in this version yet".

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

## Granting Bishop

Members become Bishop automatically at 1,000 followers. After a buyer pays
(direct APK only), set `role` to `bishop` on their `users/{uid}` document in
the Firebase console. Step by step:
[firebase-setup.md → Granting Bishop](firebase-setup.md#2-granting-bishop-after-someone-pays).

## Play Console checklist

1. Create a developer account at https://play.google.com/console (one-time
   US$25). New personal accounts must run a **closed test with at least 12
   testers for 14 days** before they can publish to production.
2. Create the app: name "Faith Mission", default language English, App, Free.
3. **Privacy policy:** publish `docs/privacy-policy.html` at a public URL and
   paste the URL in App content → Privacy policy.
4. **App access:** reviewers can create a free account in the app (email and
   password). Blog posting is limited to Bishops; to let reviewers try it,
   create a test account, make it a Bishop in the Firebase console, and give
   its email and password under App access.
5. **Ads:** No ads.
6. **Content rating:** complete the questionnaire. Answer "yes" to users
   interacting and sharing content (blog, comments and chat). The app has
   reporting, blocking and automatic filtering, as Play's user-generated
   content policy requires.
7. **Target audience:** 13 and over.
8. **Data safety:**
   - Collects data: **Yes**. Shares data with third parties: **No** (Firebase
     is a service provider, which Play does not count as sharing).
   - Personal info → **Email address**: collected, required, for *Account
     management*. **Name**: collected, required, for *App functionality*.
   - Messages → **Other in-app messages** (chat): *App functionality*.
   - App activity → **Other user-generated content** (posts, comments):
     *App functionality*. **Other actions** (reading progress, follows):
     *App functionality*.
   - Encrypted in transit: **Yes**. Users can request deletion: **Yes**
     (Settings → Delete Account, or email the admin).
   - Account deletion URL (required): use the privacy policy URL; its
     "Deleting your data" section explains how.
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
Mark chapters as read, build a daily reading streak, and grow from Believer to Preacher (30 days) and Shepherd (365 days), then to Bishop at 1,000 followers. Your progress follows you to any phone you sign in on.

COMMUNITY
Follow other members, read the blog, like and comment on posts, and join live chat rooms for gospel discussion, prayer requests, Bible study and testimonies. Moderation keeps conversations respectful while letting you quote Scripture freely, and you can report or block anyone.

GENTLE REMINDERS
Optional daily reminders help you keep your reading habit.

FREE AND PRIVATE
Every feature is free, and there are no ads. Your reading progress stays on your device.
