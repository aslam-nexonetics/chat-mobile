import 'package:flutter/material.dart';

/// Enum defining different types of collections in the app
enum CollectionType {
  dating,
  jobs,
  socialMedia,
  learning,
  gaming,
  business,
  fitness,
  travel,
  food,
  music,
  art,
  sports,
  technology,
  books,
  movies,
  general;

  /// Get display name for the collection type
  String get displayName {
    switch (this) {
      case CollectionType.dating:
        return 'Dating';
      case CollectionType.jobs:
        return 'Jobs';
      case CollectionType.socialMedia:
        return 'Social Media';
      case CollectionType.learning:
        return 'Learning';
      case CollectionType.gaming:
        return 'Gaming';
      case CollectionType.business:
        return 'Business';
      case CollectionType.fitness:
        return 'Fitness';
      case CollectionType.travel:
        return 'Travel';
      case CollectionType.food:
        return 'Food';
      case CollectionType.music:
        return 'Music';
      case CollectionType.art:
        return 'Art';
      case CollectionType.sports:
        return 'Sports';
      case CollectionType.technology:
        return 'Technology';
      case CollectionType.books:
        return 'Books';
      case CollectionType.movies:
        return 'Movies';
      case CollectionType.general:
        return 'General';
    }
  }

  /// Get the navigation items for this collection type
  List<CollectionNavItem> get navigationItems {
    switch (this) {
      case CollectionType.dating:
        return [
          CollectionNavItem(
            label: 'Swipe',
            icon: Icons.touch_app,
            route: '/swipe',
          ),
          CollectionNavItem(
            label: 'Matches',
            icon: Icons.favorite,
            route: '/matches',
          ),
          CollectionNavItem(label: 'Chat', icon: Icons.chat, route: '/chat'),
          CollectionNavItem(
            label: 'Profile',
            icon: Icons.person,
            route: '/profile',
          ),
        ];
      case CollectionType.jobs:
        return [
          CollectionNavItem(label: 'Jobs', icon: Icons.work, route: '/jobs'),
          CollectionNavItem(
            label: 'Applications',
            icon: Icons.assignment,
            route: '/applications',
          ),
          CollectionNavItem(label: 'Chat', icon: Icons.chat, route: '/chat'),
          CollectionNavItem(
            label: 'Profile',
            icon: Icons.person,
            route: '/profile',
          ),
        ];
      case CollectionType.socialMedia:
        return [
          CollectionNavItem(label: 'Feed', icon: Icons.home, route: '/feed'),
          CollectionNavItem(
            label: 'Explore',
            icon: Icons.search,
            route: '/explore',
          ),
          CollectionNavItem(label: 'Chat', icon: Icons.chat, route: '/chat'),
          CollectionNavItem(
            label: 'Profile',
            icon: Icons.person,
            route: '/profile',
          ),
        ];
      case CollectionType.learning:
        return [
          CollectionNavItem(
            label: 'Courses',
            icon: Icons.school,
            route: '/courses',
          ),
          CollectionNavItem(
            label: 'Progress',
            icon: Icons.trending_up,
            route: '/progress',
          ),
          CollectionNavItem(label: 'Chat', icon: Icons.chat, route: '/chat'),
          CollectionNavItem(
            label: 'Profile',
            icon: Icons.person,
            route: '/profile',
          ),
        ];
      case CollectionType.gaming:
        return [
          CollectionNavItem(label: 'Lobby', icon: Icons.games, route: '/lobby'),
          CollectionNavItem(
            label: 'Leaderboard',
            icon: Icons.emoji_events,
            route: '/leaderboard',
          ),
          CollectionNavItem(label: 'Chat', icon: Icons.chat, route: '/chat'),
          CollectionNavItem(
            label: 'Profile',
            icon: Icons.person,
            route: '/profile',
          ),
        ];
      default:
        return [
          CollectionNavItem(label: 'Home', icon: Icons.home, route: '/home'),
          CollectionNavItem(label: 'Chat', icon: Icons.chat, route: '/chat'),
          CollectionNavItem(
            label: 'Profile',
            icon: Icons.person,
            route: '/profile',
          ),
        ];
    }
  }

//   /// Get features available for this collection type
//   List<CollectionFeature> get features {
//     switch (this) {
//       case CollectionType.dating:
//         return [
//           CollectionFeature.swipe,
//           CollectionFeature.match,
//           CollectionFeature.chat,
//           CollectionFeature.videoCall,
//           CollectionFeature.audioCall,
//           CollectionFeature.profile,
//         ];
//       case CollectionType.jobs:
//         return [
//           CollectionFeature.jobListing,
//           CollectionFeature.jobSearch,
//           CollectionFeature.jobApplication,
//           CollectionFeature.chat,
//           CollectionFeature.profile,
//           CollectionFeature.networking,
//         ];
//       case CollectionType.socialMedia:
//         return [
//           CollectionFeature.feed,
//           CollectionFeature.post,
//           CollectionFeature.like,
//           CollectionFeature.comment,
//           CollectionFeature.share,
//           CollectionFeature.chat,
//           CollectionFeature.profile,
//         ];
//       case CollectionType.learning:
//         return [
//           CollectionFeature.courses,
//           CollectionFeature.lessons,
//           CollectionFeature.quiz,
//           CollectionFeature.progress,
//           CollectionFeature.chat,
//           CollectionFeature.profile,
//         ];
//       case CollectionType.gaming:
//         return [
//           CollectionFeature.games,
//           CollectionFeature.leaderboard,
//           CollectionFeature.tournament,
//           CollectionFeature.chat,
//           CollectionFeature.profile,
//         ];
//       default:
//         return [CollectionFeature.chat, CollectionFeature.profile];
//     }
//   }

//   /// Check if this collection type supports a specific feature
//   bool hasFeature(CollectionFeature feature) {
//     return features.contains(feature);
//   }

//   /// Get the default home route for this collection type
//   String get defaultHomeRoute {
//     switch (this) {
//       case CollectionType.dating:
//         return '/swipe';
//       case CollectionType.jobs:
//         return '/jobs';
//       case CollectionType.socialMedia:
//         return '/feed';
//       case CollectionType.learning:
//         return '/courses';
//       case CollectionType.gaming:
//         return '/lobby';
//       default:
//         return '/home';
//     }
//   }
}

/// Navigation item for collection bottom navigation
class CollectionNavItem {
  final String label;
  final IconData icon;
  final String route;
  final bool requiresAuth;
  final List<CollectionFeature> requiredFeatures;

  const CollectionNavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.requiresAuth = true,
    this.requiredFeatures = const [],
  });
}

/// Features available in different collection types
enum CollectionFeature {
  // Dating features
  swipe,
  match,

  // Job features
  jobListing,
  jobSearch,
  jobApplication,
  networking,

  // Social media features
  feed,
  post,
  like,
  comment,
  share,
  follow,

  // Learning features
  courses,
  lessons,
  quiz,
  progress,

  // Gaming features
  games,
  leaderboard,
  tournament,

  // Communication features
  chat,
  audioCall,
  videoCall,

  // Profile features
  profile,

  // Media features
  imageSharing,
  videoSharing,
  audioSharing,
  documentSharing,

  // General features
  notifications,
  search,
  settings;

  String get displayName {
    switch (this) {
      case CollectionFeature.swipe:
        return 'Swipe';
      case CollectionFeature.match:
        return 'Match';
      case CollectionFeature.jobListing:
        return 'Job Listing';
      case CollectionFeature.jobSearch:
        return 'Job Search';
      case CollectionFeature.jobApplication:
        return 'Job Application';
      case CollectionFeature.networking:
        return 'Networking';
      case CollectionFeature.feed:
        return 'Feed';
      case CollectionFeature.post:
        return 'Post';
      case CollectionFeature.like:
        return 'Like';
      case CollectionFeature.comment:
        return 'Comment';
      case CollectionFeature.share:
        return 'Share';
      case CollectionFeature.follow:
        return 'Follow';
      case CollectionFeature.courses:
        return 'Courses';
      case CollectionFeature.lessons:
        return 'Lessons';
      case CollectionFeature.quiz:
        return 'Quiz';
      case CollectionFeature.progress:
        return 'Progress';
      case CollectionFeature.games:
        return 'Games';
      case CollectionFeature.leaderboard:
        return 'Leaderboard';
      case CollectionFeature.tournament:
        return 'Tournament';
      case CollectionFeature.chat:
        return 'Chat';
      case CollectionFeature.audioCall:
        return 'Audio Call';
      case CollectionFeature.videoCall:
        return 'Video Call';
      case CollectionFeature.profile:
        return 'Profile';
      case CollectionFeature.imageSharing:
        return 'Image Sharing';
      case CollectionFeature.videoSharing:
        return 'Video Sharing';
      case CollectionFeature.audioSharing:
        return 'Audio Sharing';
      case CollectionFeature.documentSharing:
        return 'Document Sharing';
      case CollectionFeature.notifications:
        return 'Notifications';
      case CollectionFeature.search:
        return 'Search';
      case CollectionFeature.settings:
        return 'Settings';
    }
  }
}

/// Extension methods for CollectionType
extension CollectionTypeExtension on CollectionType {
  /// Convert string to CollectionType
  static CollectionType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dating':
        return CollectionType.dating;
      case 'jobs':
        return CollectionType.jobs;
      case 'socialmedia':
      case 'social_media':
        return CollectionType.socialMedia;
      case 'learning':
        return CollectionType.learning;
      case 'gaming':
        return CollectionType.gaming;
      case 'business':
        return CollectionType.business;
      case 'fitness':
        return CollectionType.fitness;
      case 'travel':
        return CollectionType.travel;
      case 'food':
        return CollectionType.food;
      case 'music':
        return CollectionType.music;
      case 'art':
        return CollectionType.art;
      case 'sports':
        return CollectionType.sports;
      case 'technology':
        return CollectionType.technology;
      case 'books':
        return CollectionType.books;
      case 'movies':
        return CollectionType.movies;
      default:
        return CollectionType.general;
    }
  }

  /// Convert CollectionType to string
  String get value {
    switch (this) {
      case CollectionType.socialMedia:
        return 'social_media';
      default:
        return name;
    }
  }
}

/// Collection configuration class
class CollectionConfig {
  final CollectionType type;
  final String name;
  final String description;
  final bool isPrivate;
  final int maxMembers;
  final List<CollectionFeature> enabledFeatures;
  final Map<String, dynamic> customSettings;

  const CollectionConfig({
    required this.type,
    required this.name,
    required this.description,
    this.isPrivate = false,
    this.maxMembers = 1000,
    required this.enabledFeatures,
    this.customSettings = const {},
  });

//   /// Create a default configuration for a collection type
//   factory CollectionConfig.defaultFor(CollectionType type) {
//     return CollectionConfig(
//       type: type,
//       name: type.displayName,
//       description: type.description,
//       enabledFeatures: type.features,
//       maxMembers: _getDefaultMaxMembers(type),
//       customSettings: _getDefaultSettings(type),
//     );
//   }

//   static int _getDefaultMaxMembers(CollectionType type) {
//     switch (type) {
//       case CollectionType.dating:
//         return 10000;
//       case CollectionType.jobs:
//         return 5000;
//       case CollectionType.socialMedia:
//         return 50000;
//       case CollectionType.learning:
//         return 1000;
//       case CollectionType.gaming:
//         return 100;
//       default:
//         return 1000;
//     }
//   }

//   static Map<String, dynamic> _getDefaultSettings(CollectionType type) {
//     switch (type) {
//       case CollectionType.dating:
//         return {
//           'ageRange': {'min': 18, 'max': 99},
//           'maxDistance': 50,
//           'showOnlineStatus': true,
//           'allowVideoCall': true,
//         };
//       case CollectionType.jobs:
//         return {
//           'allowJobPosting': true,
//           'requireVerification': true,
//           'showSalaryRange': true,
//         };
//       case CollectionType.socialMedia:
//         return {
//           'allowPublicPosts': true,
//           'enableHashtags': true,
//           'allowLiveStreaming': false,
//         };
//       case CollectionType.learning:
//         return {
//           'allowCourseCreation': false,
//           'requireProgress': true,
//           'enableCertificates': true,
//         };
//       case CollectionType.gaming:
//         return {
//           'allowTournaments': true,
//           'enableRanking': true,
//           'maxPlayersPerGame': 8,
//         };
//       default:
//         return {};
//     }
//   }
}
