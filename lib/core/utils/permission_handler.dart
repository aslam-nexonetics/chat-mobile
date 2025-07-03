import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

enum PermissionType {
  camera,
  microphone,
  storage,
  photos,
  location,
  notification,
  contacts,
  phone,
}

class AppPermissionHandler {
  // Private constructor
  AppPermissionHandler._();

  static final AppPermissionHandler _instance = AppPermissionHandler._();
  static AppPermissionHandler get instance => _instance;

  // Map permission types to Permission objects
  static const Map<PermissionType, Permission> _permissionMap = {
    PermissionType.camera: Permission.camera,
    PermissionType.microphone: Permission.microphone,
    PermissionType.storage: Permission.storage,
    PermissionType.photos: Permission.photos,
    PermissionType.location: Permission.location,
    PermissionType.notification: Permission.notification,
    PermissionType.contacts: Permission.contacts,
    PermissionType.phone: Permission.phone,
  };

  // Get permission status
  Future<PermissionStatus> getPermissionStatus(
    PermissionType permissionType,
  ) async {
    final permission = _permissionMap[permissionType];
    if (permission == null) {
      return PermissionStatus.denied;
    }
    return await permission.status;
  }

  // Request single permission
  Future<PermissionStatus> requestPermission(
    PermissionType permissionType,
  ) async {
    final permission = _permissionMap[permissionType];
    if (permission == null) {
      return PermissionStatus.denied;
    }
    return await permission.request();
  }

  // Request multiple permissions
  Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<PermissionType> permissionTypes,
  ) async {
    final permissions =
        permissionTypes
            .map((type) => _permissionMap[type])
            .where((permission) => permission != null)
            .cast<Permission>()
            .toList();

    return await permissions.request();
  }

  // Check if permission is granted
  Future<bool> isPermissionGranted(PermissionType permissionType) async {
    final status = await getPermissionStatus(permissionType);
    return status == PermissionStatus.granted;
  }

  // Check if permission is permanently denied
  Future<bool> isPermissionPermanentlyDenied(
    PermissionType permissionType,
  ) async {
    final status = await getPermissionStatus(permissionType);
    return status == PermissionStatus.permanentlyDenied;
  }

  // Handle camera permission for profile photos and video calls
  Future<bool> requestCameraPermission() async {
    final status = await requestPermission(PermissionType.camera);
    return status == PermissionStatus.granted;
  }

  // Handle microphone permission for voice/video calls
  Future<bool> requestMicrophonePermission() async {
    final status = await requestPermission(PermissionType.microphone);
    return status == PermissionStatus.granted;
  }

  // Handle storage permission for file uploads
  Future<bool> requestStoragePermission() async {
    final status = await requestPermission(PermissionType.storage);
    return status == PermissionStatus.granted;
  }

  // Handle photos permission for gallery access
  Future<bool> requestPhotosPermission() async {
    final status = await requestPermission(PermissionType.photos);
    return status == PermissionStatus.granted;
  }

  // Handle location permission for location-based matching
  Future<bool> requestLocationPermission() async {
    final status = await requestPermission(PermissionType.location);
    return status == PermissionStatus.granted;
  }

  // Handle notification permission
  Future<bool> requestNotificationPermission() async {
    final status = await requestPermission(PermissionType.notification);
    return status == PermissionStatus.granted;
  }

  // Request permissions needed for video calls
  Future<Map<PermissionType, bool>> requestVideoCallPermissions() async {
    final results = await requestMultiplePermissions([
      PermissionType.camera,
      PermissionType.microphone,
    ]);

    return {
      PermissionType.camera:
          results[_permissionMap[PermissionType.camera]] ==
          PermissionStatus.granted,
      PermissionType.microphone:
          results[_permissionMap[PermissionType.microphone]] ==
          PermissionStatus.granted,
    };
  }

  // Request permissions needed for voice calls
  Future<bool> requestVoiceCallPermissions() async {
    return await requestMicrophonePermission();
  }

  // Request permissions needed for profile setup
  Future<Map<PermissionType, bool>> requestProfilePermissions() async {
    final results = await requestMultiplePermissions([
      PermissionType.camera,
      PermissionType.photos,
      PermissionType.storage,
    ]);

    return {
      PermissionType.camera:
          results[_permissionMap[PermissionType.camera]] ==
          PermissionStatus.granted,
      PermissionType.photos:
          results[_permissionMap[PermissionType.photos]] ==
          PermissionStatus.granted,
      PermissionType.storage:
          results[_permissionMap[PermissionType.storage]] ==
          PermissionStatus.granted,
    };
  }

  // Show permission dialog with explanation
  Future<bool> showPermissionDialog(
    BuildContext context,
    PermissionType permissionType,
  ) async {
    final permissionName = _getPermissionName(permissionType);
    final permissionReason = _getPermissionReason(permissionType);

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Required'),
          content: Text(permissionReason),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Grant Permission'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final status = await requestPermission(permissionType);
      return status == PermissionStatus.granted;
    }

    return false;
  }

  // Show settings dialog when permission is permanently denied
  Future<void> showSettingsDialog(
    BuildContext context,
    PermissionType permissionType,
  ) async {
    final permissionName = _getPermissionName(permissionType);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: Text(
            '$permissionName permission is required for this feature. '
            'Please enable it in the app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  // Check and request permission with proper flow
  Future<bool> checkAndRequestPermission(
    BuildContext context,
    PermissionType permissionType, {
    bool showDialog = true,
  }) async {
    final status = await getPermissionStatus(permissionType);

    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        if (showDialog) {
          return await showPermissionDialog(context, permissionType);
        } else {
          final newStatus = await requestPermission(permissionType);
          return newStatus == PermissionStatus.granted;
        }
      case PermissionStatus.permanentlyDenied:
        if (showDialog) {
          await showSettingsDialog(context, permissionType);
        }
        return false;
      case PermissionStatus.restricted:
        return false;
      default:
        return false;
    }
  }

  // Bulk permission checker for features
  Future<Map<PermissionType, bool>> checkMultiplePermissions(
    List<PermissionType> permissionTypes,
  ) async {
    final Map<PermissionType, bool> results = {};

    for (final permissionType in permissionTypes) {
      results[permissionType] = await isPermissionGranted(permissionType);
    }

    return results;
  }

  // Get permission name for display
  String _getPermissionName(PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.camera:
        return 'Camera';
      case PermissionType.microphone:
        return 'Microphone';
      case PermissionType.storage:
        return 'Storage';
      case PermissionType.photos:
        return 'Photos';
      case PermissionType.location:
        return 'Location';
      case PermissionType.notification:
        return 'Notification';
      case PermissionType.contacts:
        return 'Contacts';
      case PermissionType.phone:
        return 'Phone';
    }
  }

  // Get permission reason for display
  String _getPermissionReason(PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.camera:
        return 'Camera access is needed to take photos for your profile and make video calls.';
      case PermissionType.microphone:
        return 'Microphone access is needed to make voice and video calls.';
      case PermissionType.storage:
        return 'Storage access is needed to save and upload photos and files.';
      case PermissionType.photos:
        return 'Photos access is needed to select images from your gallery for your profile.';
      case PermissionType.location:
        return 'Location access is needed to find people and collections near you.';
      case PermissionType.notification:
        return 'Notification permission is needed to send you messages and updates.';
      case PermissionType.contacts:
        return 'Contacts access is needed to help you find friends who are already using the app.';
      case PermissionType.phone:
        return 'Phone access is needed to verify your phone number and make calls.';
    }
  }

  // Feature-specific permission handlers

  // For video calling feature
  Future<bool> handleVideoCallPermissions(BuildContext context) async {
    final cameraGranted = await checkAndRequestPermission(
      context,
      PermissionType.camera,
      showDialog: true,
    );

    if (!cameraGranted) return false;

    final microphoneGranted = await checkAndRequestPermission(
      context,
      PermissionType.microphone,
      showDialog: true,
    );

    return microphoneGranted;
  }

  // For voice calling feature
  Future<bool> handleVoiceCallPermissions(BuildContext context) async {
    return await checkAndRequestPermission(
      context,
      PermissionType.microphone,
      showDialog: true,
    );
  }

  // For profile photo upload feature
  Future<bool> handleProfilePhotoPermissions(BuildContext context) async {
    final cameraGranted = await checkAndRequestPermission(
      context,
      PermissionType.camera,
      showDialog: true,
    );

    final photosGranted = await checkAndRequestPermission(
      context,
      PermissionType.photos,
      showDialog: true,
    );

    return cameraGranted && photosGranted;
  }

  // For location-based features
  Future<bool> handleLocationPermissions(BuildContext context) async {
    return await checkAndRequestPermission(
      context,
      PermissionType.location,
      showDialog: true,
    );
  }

  // For notification features
  Future<bool> handleNotificationPermissions(BuildContext context) async {
    return await checkAndRequestPermission(
      context,
      PermissionType.notification,
      showDialog: true,
    );
  }

  // Check if all critical permissions are granted
  Future<bool> areAllCriticalPermissionsGranted() async {
    final criticalPermissions = [
      PermissionType.camera,
      PermissionType.microphone,
      PermissionType.notification,
    ];

    for (final permission in criticalPermissions) {
      if (!await isPermissionGranted(permission)) {
        return false;
      }
    }

    return true;
  }

  // Get permission status summary
  Future<Map<String, bool>> getPermissionStatusSummary() async {
    final allPermissions = PermissionType.values;
    final Map<String, bool> summary = {};

    for (final permission in allPermissions) {
      final name = _getPermissionName(permission);
      summary[name] = await isPermissionGranted(permission);
    }

    return summary;
  }

  // Handle permission result and show appropriate message
  void handlePermissionResult(
    BuildContext context,
    PermissionType permissionType,
    bool granted,
  ) {
    if (!granted) {
      final permissionName = _getPermissionName(permissionType);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$permissionName permission is required for this feature.',
          ),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }
  }

  // Request permissions on app startup
  Future<void> requestInitialPermissions(BuildContext context) async {
    // Request notification permission first (less intrusive)
    await checkAndRequestPermission(
      context,
      PermissionType.notification,
      showDialog: false,
    );

    // Other permissions will be requested when needed
  }
}
// Usage example:
// final permissionHandler = AppPermissionHandler.instance;
// final cameraStatus = await permissionHandler.getPermissionStatus(PermissionType.camera);
// final isCameraGranted = await permissionHandler.isPermissionGranted(PermissionType.camera);
// final requestStatus = await permissionHandler.requestPermission(PermissionType.camera);
// final isGranted = await permissionHandler.checkAndRequestPermission(context, PermissionType.camera);
// final videoCallPermissions = await permissionHandler.requestVideoCallPermissions();
// final voiceCallPermissions = await permissionHandler.requestVoiceCallPermissions();
// final profilePermissions = await permissionHandler.requestProfilePermissions();
// final allPermissionsGranted = await permissionHandler.areAllCriticalPermissionsGranted();
// final permissionSummary = await permissionHandler.getPermissionStatusSummary();
// permissionHandler.handlePermissionResult(context, PermissionType.camera, isCameraGranted); 