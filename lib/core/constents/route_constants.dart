class RouteConstants {
  // Auth Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';
  static const String onboarding = '/onboarding';

  // Main App Routes
  static const String home = '/home';
  static const String collections = '/collections';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';

  // Collection Routes
  static const String collectionDetail = '/collection/:id';
  static const String collectionHome = '/collection/:id/home';
  static const String collectionChat = '/collection/:id/chat';
  static const String collectionProfile = '/collection/:id/profile';
  static const String collectionMembers = '/collection/:id/members';
  static const String collectionSettings = '/collection/:id/settings';
  static const String joinCollection = '/collection/:id/join';
  static const String createCollection = '/collection/create';
  static const String editCollection = '/collection/:id/edit';

  // Chat Routes
  static const String chatRoom = '/collection/:collectionId/chat/:chatId';
  static const String chatSettings = '/collection/:collectionId/chat/:chatId/settings';
  static const String chatMembers = '/collection/:collectionId/chat/:chatId/members';
  static const String chatMedia = '/collection/:collectionId/chat/:chatId/media';

  // Call Routes
  static const String voiceCall = '/collection/:collectionId/call/voice/:callId';
  static const String videoCall = '/collection/:collectionId/call/video/:callId';
  static const String incomingCall = '/call/incoming/:callId';
  static const String callHistory = '/call/history';

  // Dating Collection Specific Routes
  static const String datingSwipe = '/collection/:id/dating/swipe';
  static const String datingMatches = '/collection/:id/dating/matches';
  static const String datingProfile = '/collection/:id/dating/profile';
  static const String datingSettings = '/collection/:id/dating/settings';
  static const String datingChat = '/collection/:id/dating/chat/:matchId';

  // Job Collection Specific Routes
  static const String jobListing = '/collection/:id/jobs/listing';
  static const String jobDetail = '/collection/:id/jobs/:jobId';
  static const String jobSearch = '/collection/:id/jobs/search';
  static const String jobApplications = '/collection/:id/jobs/applications';
  static const String jobProfile = '/collection/:id/jobs/profile';
  static const String jobSettings = '/collection/:id/jobs/settings';
  static const String postJob = '/collection/:id/jobs/post';
  static const String editJob = '/collection/:id/jobs/:jobId/edit';

  // Social Media Collection Specific Routes
  static const String socialFeed = '/collection/:id/social/feed';
  static const String socialPost = '/collection/:id/social/post/:postId';
  static const String socialProfile = '/collection/:id/social/profile';
  static const String socialSettings = '/collection/:id/social/settings';
  static const String createPost = '/collection/:id/social/create-post';
  static const String editPost = '/collection/:id/social/post/:postId/edit';
  static const String socialFollowing = '/collection/:id/social/following';
  static const String socialFollowers = '/collection/:id/social/followers';

  // Learning Collection Specific Routes
  static const String learningCourses = '/collection/:id/learning/courses';
  static const String learningCourse = '/collection/:id/learning/course/:courseId';
  static const String learningLesson = '/collection/:id/learning/lesson/:lessonId';
  static const String learningQuiz = '/collection/:id/learning/quiz/:quizId';
  static const String learningProgress = '/collection/:id/learning/progress';
  static const String learningProfile = '/collection/:id/learning/profile';
  static const String learningSettings = '/collection/:id/learning/settings';

  // Gaming Collection Specific Routes
  static const String gamingLobby = '/collection/:id/gaming/lobby';
  static const String gamingRoom = '/collection/:id/gaming/room/:roomId';
  static const String gamingLeaderboard = '/collection/:id/gaming/leaderboard';
  static const String gamingProfile = '/collection/:id/gaming/profile';
  static const String gamingSettings = '/collection/:id/gaming/settings';
  static const String gamingTournament = '/collection/:id/gaming/tournament/:tournamentId';

  // Profile Routes
  static const String editProfile = '/profile/edit';
  static const String changePassword = '/profile/change-password';
  static const String accountSettings = '/profile/account-settings';
  static const String privacySettings = '/profile/privacy-settings';
  static const String notificationSettings = '/profile/notification-settings';
  static const String blockList = '/profile/block-list';
  static const String deleteAccount = '/profile/delete-account';

  // Media Routes
  static const String mediaViewer = '/media/:mediaId';
  static const String imageViewer = '/image/:imageId';
  static const String videoPlayer = '/video/:videoId';
  static const String audioPlayer = '/audio/:audioId';
  static const String documentViewer = '/document/:documentId';

  // Search Routes
  static const String search = '/search';
  static const String searchResults = '/search/results';
  static const String searchUsers = '/search/users';
  static const String searchCollections = '/search/collections';

  // Error Routes
  static const String error = '/error';
  static const String notFound = '/not-found';
  static const String offline = '/offline';

  // Route Parameters
  static const String paramId = 'id';
  static const String paramCollectionId = 'collectionId';
  static const String paramChatId = 'chatId';
  static const String paramCallId = 'callId';
  static const String paramMatchId = 'matchId';
  static const String paramJobId = 'jobId';
  static const String paramPostId = 'postId';
  static const String paramCourseId = 'courseId';
  static const String paramLessonId = 'lessonId';
  static const String paramQuizId = 'quizId';
  static const String paramRoomId = 'roomId';
  static const String paramTournamentId = 'tournamentId';
  static const String paramMediaId = 'mediaId';
  static const String paramImageId = 'imageId';
  static const String paramVideoId = 'videoId';
  static const String paramAudioId = 'audioId';
  static const String paramDocumentId = 'documentId';

  // Query Parameters
  static const String queryPage = 'page';
  static const String queryLimit = 'limit';
  static const String querySearch = 'search';
  static const String queryFilter = 'filter';
  static const String querySort = 'sort';
  static const String queryCategory = 'category';
  static const String queryType = 'type';
  static const String queryStatus = 'status';

  // Helper methods
  static String getCollectionRoute(String collectionId, String route) {
    return route.replaceAll(':id', collectionId);
  }

  static String getChatRoute(String collectionId, String chatId) {
    return chatRoom
        .replaceAll(':collectionId', collectionId)
        .replaceAll(':chatId', chatId);
  }

  static String getCallRoute(String collectionId, String callId, {bool isVideo = false}) {
    final route = isVideo ? videoCall : voiceCall;
    return route
        .replaceAll(':collectionId', collectionId)
        .replaceAll(':callId', callId);
  }

  static String getJobRoute(String collectionId, String jobId) {
    return jobDetail
        .replaceAll(':id', collectionId)
        .replaceAll(':jobId', jobId);
  }

  static String getPostRoute(String collectionId, String postId) {
    return socialPost
        .replaceAll(':id', collectionId)
        .replaceAll(':postId', postId);
  }

  static String getCourseRoute(String collectionId, String courseId) {
    return learningCourse
        .replaceAll(':id', collectionId)
        .replaceAll(':courseId', courseId);
  }

  static String getMediaRoute(String mediaId, String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return imageViewer.replaceAll(':imageId', mediaId);
      case 'video':
        return videoPlayer.replaceAll(':videoId', mediaId);
      case 'audio':
        return audioPlayer.replaceAll(':audioId', mediaId);
      case 'document':
        return documentViewer.replaceAll(':documentId', mediaId);
      default:
        return mediaViewer.replaceAll(':mediaId', mediaId);
    }
  }
}