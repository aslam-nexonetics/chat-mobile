class AppConstants {
  // App Information
  static const String appName = 'CollectionApp';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Multi-collection social app';

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyCollections = 'user_collections';
  static const String keySelectedCollection = 'selected_collection';
  static const String keyAppTheme = 'app_theme';
  static const String keyLanguage = 'app_language';
  static const String keyNotificationSettings = 'notification_settings';

  // Database
  static const String databaseName = 'collection_app.db';
  static const int databaseVersion = 1;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Token Refresh
  static const int tokenRefreshThreshold = 300; // 5 minutes before expiry

  // Chat Constants
  static const int maxMessageLength = 1000;
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> supportedVideoFormats = ['mp4', 'mov', 'avi'];
  static const List<String> supportedAudioFormats = ['mp3', 'wav', 'aac'];
  static const List<String> supportedDocumentFormats = ['pdf', 'doc', 'docx', 'txt'];

  // Call Constants
  static const int maxCallDuration = 3600; // 1 hour
  static const int callTimeoutDuration = 60; // 1 minute

  // Validation Constants
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  static const int maxBioLength = 500;

  // Collection Constants
  static const int maxCollectionsPerUser = 50;
  static const int maxMembersPerCollection = 10000;

  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Network connection failed. Please check your internet connection.';
  static const String authErrorMessage = 'Authentication failed. Please login again.';
  static const String permissionErrorMessage = 'Permission denied. Please grant required permissions.';
  static const String validationErrorMessage = 'Please check your input and try again.';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registrationSuccessMessage = 'Registration successful!';
  static const String logoutSuccessMessage = 'Logout successful!';
  static const String profileUpdateSuccessMessage = 'Profile updated successfully!';
  static const String collectionJoinSuccessMessage = 'Joined collection successfully!';
  static const String collectionLeaveSuccessMessage = 'Left collection successfully!';

  // Dating Collection Constants
  static const int maxSwipesPerDay = 100;
  static const int minAgeForDating = 18;
  static const int maxAgeForDating = 99;
  static const int maxDistanceForDating = 500; // km

  // Job Collection Constants
  static const int maxJobApplicationsPerDay = 10;
  static const List<String> jobCategories = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Marketing',
    'Sales',
    'Design',
    'Engineering',
    'Management',
    'Others'
  ];

  // Social Media Collection Constants
  static const int maxPostsPerDay = 50;
  static const int maxHashtagsPerPost = 30;
  static const int maxPostLength = 2000;

  // Animation Durations
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 300;
  static const int longAnimationDuration = 500;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 12.0;
  static const double smallRadius = 8.0;
  static const double largeRadius = 20.0;

  // Image Constants
  static const String defaultAvatarPath = 'assets/images/default_avatar.png';
  static const String defaultCollectionImage = 'assets/images/default_collection.png';
  static const String appLogo = 'assets/images/app_logo.png';

  // Regular Expressions
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';
  static const String usernameRegex = r'^[a-zA-Z0-9_]{3,20}$';

  // Notification Types
  static const String notificationTypeMessage = 'message';
  static const String notificationTypeCall = 'call';
  static const String notificationTypeCollectionUpdate = 'collection_update';
  static const String notificationTypeMatch = 'match';
  static const String notificationTypeJobAlert = 'job_alert';

  // Deep Link Schemes
  static const String deepLinkScheme = 'collectionapp';
  static const String deepLinkHost = 'app';

  // Cache Constants
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // Feature Flags
  static const bool enableVideoCall = true;
  static const bool enableAudioCall = true;
  static const bool enableFileSharing = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
}