# Faith Mission App

A fluid mobile faith mission app built with Flutter and Firebase. This app provides a comprehensive platform for believers to grow in their faith journey through daily Bible readings, community discussions, and spiritual growth tracking.

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
- **Automated Filtering**: Machine learning-based moderation to prevent:
  - Political discussions
  - Offensive language
  - Toxic content
- **Manual Reporting**: Users can flag inappropriate content
- **Gospel-Focused**: Ensures all discussions stay focused on the Gospel

### Premium Features
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
- Flutter SDK 3.0.0 or higher
- Dart 3.0.0 or higher
- Firebase project
- Android Studio / Xcode

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/ephraimru/bible.git
cd bible
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Configure Firebase**:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and iOS apps to your project
   - Download the configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS
   - Place them in the respective directories

4. **Update Firebase configuration**:
   - Run `flutterfire configure` to generate `firebase_options.dart`
   - Or manually update the configuration in `lib/firebase_options.dart`

5. **Set up Firestore Security Rules**:
   - Deploy the rules from `firestore.rules`
   - Deploy the storage rules from `storage.rules`

6. **Add Bible Data**:
   - Import KJV Bible data into Firestore
   - The app expects verses in the `verses` collection
   - See the data structure in the models

7. **Configure In-App Purchases**:
   - Set up products in Google Play Console and App Store Connect
   - Update product IDs in `lib/services/premium_service.dart`

8. **Run the app**:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # App configuration
├── config/
│   ├── theme.dart               # App theme configuration
│   └── router.dart              # Navigation routing
├── models/                      # Data models
│   ├── user_model.dart          # User model
│   ├── verse_model.dart         # Bible verse model
│   ├── blog_model.dart          # Blog post model
│   ├── chat_model.dart          # Chat message model
│   ├── faith_journey_model.dart # Faith journey model
│   └── premium_model.dart       # Premium features model
├── services/                    # Business logic services
│   ├── auth_service.dart       # Authentication service
│   ├── database_service.dart   # Firestore database service
│   ├── bible_service.dart      # Bible-related service
│   ├── moderation_service.dart # Content moderation service
│   ├── faith_journey_service.dart # Faith journey tracking
│   ├── notification_service.dart # Notification service
│   └── premium_service.dart     # Premium features service
├── screens/                     # App screens
│   ├── splash_screen.dart      # Splash screen
│   ├── auth/                    # Authentication screens
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   └── welcome_screen.dart
│   ├── home/                    # Home screens
│   │   └── home_screen.dart
│   ├── daily_verse/             # Daily verse screens
│   │   └── daily_verse_screen.dart
│   ├── bible/                   # Bible screens
│   │   ├── bible_screen.dart
│   │   ├── book_screen.dart
│   │   └── verse_detail_screen.dart
│   ├── blog/                    # Blog screens
│   │   ├── blog_screen.dart
│   │   ├── create_post_screen.dart
│   │   └── post_detail_screen.dart
│   ├── chat/                    # Chat screens
│   │   ├── chat_screen.dart
│   │   └── chat_room_screen.dart
│   ├── profile/                 # Profile screens
│   │   └── profile_screen.dart
│   ├── faith_journey/           # Faith journey screens
│   │   └── faith_journey_screen.dart
│   ├── settings/                # Settings screens
│   │   └── settings_screen.dart
│   └── premium/                 # Premium screens
│       └── premium_screen.dart
└── widgets/                     # Reusable widgets
    ├── verse_card.dart
    ├── daily_verse_section.dart
    ├── faith_progress_card.dart
    ├── faith_progress_indicator.dart
    ├── reading_streak_card.dart
    ├── quick_action_buttons.dart
    ├── book_card.dart
    ├── blog_post_card.dart
    ├── chat_room_card.dart
    ├── message_bubble.dart
    ├── comment_section.dart
    ├── profile_header.dart
    ├── stats_card.dart
    ├── role_progress_card.dart
    ├── milestone_card.dart
    ├── search_bar.dart
    └── category_chip.dart
```

## Data Models

### User
- `id`: Unique user identifier
- `email`: User email address
- `displayName`: Display name
- `photoUrl`: Profile picture URL
- `role`: Faith journey role (believer, preacher, shepherd, bishop)
- `premiumTier`: Premium subscription tier
- `followingCount`: Number of users this user follows
- `followersCount`: Number of followers
- `savedVersesCount`: Number of saved verses
- `likedVersesCount`: Number of liked verses
- `readingStats`: Reading statistics
- `consecutiveReadingDays`: Current reading streak
- `hasPaidToSkipLadder`: Whether user paid to skip the ladder
- `chosenTitle`: Custom title for Bishop users

### Verse
- `id`: Unique verse identifier
- `reference`: Verse reference (e.g., "John 3:16")
- `text`: Verse text
- `book`: Book name
- `chapter`: Chapter number
- `verse`: Verse number
- `translation`: Bible translation (KJV)
- `imageUrl`: Optional image URL
- `likes`: Number of likes
- `saves`: Number of saves
- `tags`: Verse tags

### Blog Post
- `id`: Unique post identifier
- `title`: Post title
- `content`: Post content
- `authorId`: Author user ID
- `category`: Post category
- `status`: Publication status
- `tags`: Post tags
- `views`: Number of views
- `likes`: Number of likes
- `comments`: Number of comments
- `publishedAt`: Publication date

### Chat Message
- `id`: Unique message identifier
- `roomId`: Chat room ID
- `senderId`: Sender user ID
- `content`: Message content
- `type`: Message type (text, image, voice, etc.)
- `moderationStatus`: Content moderation status
- `toxicityScore`: ML toxicity score
- `offensiveScore`: ML offensive score
- `politicalScore`: ML political score
- `requiresReview`: Whether message needs moderation review

## Firebase Setup

### Collections Structure

```
users/
  {userId}/
    - email
    - displayName
    - photoUrl
    - role
    - premiumTier
    - ...

verses/
  {verseId}/
    - reference
    - text
    - book
    - chapter
    - verse
    - translation
    - ...

daily_verses/
  {date}/
    - verse (reference)
    - backgroundImageUrl
    - themeColor
    - ...

blog_posts/
  {postId}/
    - title
    - content
    - authorId
    - category
    - status
    - ...
    comments/
      {commentId}/
        - content
        - authorId
        - ...

chat_rooms/
  {roomId}/
    - name
    - type
    - memberIds
    - ...
    messages/
      {messageId}/
        - content
        - senderId
        - ...

faith_journeys/
  {userId}/
    - currentRole
    - consecutiveDays
    - longestStreak
    - versesRead
    - ...

reading_habits/
  {userId}/
    - preferredHours
    - preferredDays
    - notificationsEnabled
    - ...

subscriptions/
  {subscriptionId}/
    - userId
    - plan
    - startDate
    - endDate
    - isActive
    - ...

payments/
  {paymentId}/
    - userId
    - amount
    - currency
    - status
    - ...

moderation_reports/
  {reportId}/
    - messageId
    - roomId
    - reportedBy
    - reason
    - status
    - ...
```

### Security Rules

The app uses comprehensive Firestore security rules to ensure:
- Users can only access their own data
- Content moderation is enforced
- Only authorized users can create content
- Premium features are restricted to subscribers

## Moderation System

The app implements a multi-layer moderation system:

1. **Automated Moderation**:
   - Uses ML-based text analysis
   - Checks for toxicity, offensive language, and political content
   - Blocks messages that violate guidelines

2. **Manual Reporting**:
   - Users can flag inappropriate content
   - Reports are reviewed by moderators

3. **Gospel Focus**:
   - Content is checked to ensure it's gospel-focused
   - Political discussions are automatically flagged

## Premium Features Implementation

Premium features are implemented using:
- Firebase In-App Purchases for subscriptions
- Firestore to track subscription status
- Security rules to restrict access
- Local state management with Riverpod

### Subscription Plans
- **Free**: Basic features
- **Basic**: Advanced search, offline mode, ad-free
- **Pro**: All basic features + commentaries, devotionals, reading plans
- **Bishop**: All features including blog posting and title selection

### One-Time Purchases
- **Ladder Skip**: Pay to become a Bishop immediately

## Notifications

The app uses Firebase Cloud Messaging and local notifications for:
- Daily Bible reading reminders
- Reading streak notifications
- Milestone achievements
- New messages in chat rooms
- New blog posts from followed users

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please contact the project maintainer.

---

**Note**: This is a comprehensive faith-based mobile application. Make sure to:
1. Configure Firebase properly
2. Set up the Bible data in Firestore
3. Configure in-app purchases for premium features
4. Test all features thoroughly before production deployment
