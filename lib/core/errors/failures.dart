import 'package:equatable/equatable.dart';

// Base failure class
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// Network related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({
    super.message = 'No internet connection',
    super.code,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timeout',
    super.code,
  });
}

// Authentication failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.code,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access',
    super.code = 401,
  });
}

class TokenExpiredFailure extends Failure {
  const TokenExpiredFailure({
    super.message = 'Token has expired',
    super.code = 401,
  });
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = 'Invalid email or password',
    super.code = 401,
  });
}

class AccountNotFoundFailure extends Failure {
  const AccountNotFoundFailure({
    super.message = 'Account not found',
    super.code = 404,
  });
}

class AccountAlreadyExistsFailure extends Failure {
  const AccountAlreadyExistsFailure({
    super.message = 'Account already exists',
    super.code = 409,
  });
}

class EmailNotVerifiedFailure extends Failure {
  const EmailNotVerifiedFailure({
    super.message = 'Email not verified',
    super.code = 403,
  });
}

// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({
    required super.message,
    super.code = 400,
  });
}

class MissingRequiredFieldFailure extends Failure {
  const MissingRequiredFieldFailure({
    required String fieldName,
    super.code = 400,
  }) : super(message: '$fieldName is required');
}

// Collection related failures
class CollectionFailure extends Failure {
  const CollectionFailure({
    required super.message,
    super.code,
  });
}

class CollectionNotFoundFailure extends Failure {
  const CollectionNotFoundFailure({
    super.message = 'Collection not found',
    super.code = 404,
  });
}

class CollectionAccessDeniedFailure extends Failure {
  const CollectionAccessDeniedFailure({
    super.message = 'Access denied to collection',
    super.code = 403,
  });
}

class CollectionFullFailure extends Failure {
  const CollectionFullFailure({
    super.message = 'Collection is full',
    super.code = 409,
  });
}

class AlreadyMemberFailure extends Failure {
  const AlreadyMemberFailure({
    super.message = 'Already a member of this collection',
    super.code = 409,
  });
}

class NotMemberFailure extends Failure {
  const NotMemberFailure({
    super.message = 'Not a member of this collection',
    super.code = 403,
  });
}

// Chat related failures
class ChatFailure extends Failure {
  const ChatFailure({
    required super.message,
    super.code,
  });
}

class MessageSendFailure extends Failure {
  const MessageSendFailure({
    super.message = 'Failed to send message',
    super.code,
  });
}

class ChatRoomNotFoundFailure extends Failure {
  const ChatRoomNotFoundFailure({
    super.message = 'Chat room not found',
    super.code = 404,
  });
}

class CallFailure extends Failure {
  const CallFailure({
    required super.message,
    super.code,
  });
}

class CallConnectionFailure extends Failure {
  const CallConnectionFailure({
    super.message = 'Failed to connect call',
    super.code,
  });
}

class CallPermissionFailure extends Failure {
  const CallPermissionFailure({
    super.message = 'Permission denied for call',
    super.code = 403,
  });
}

// Profile related failures
class ProfileFailure extends Failure {
  const ProfileFailure({
    required super.message,
    super.code,
  });
}

class ProfileNotFoundFailure extends Failure {
  const ProfileNotFoundFailure({
    super.message = 'Profile not found',
    super.code = 404,
  });
}

class ProfileUpdateFailure extends Failure {
  const ProfileUpdateFailure({
    super.message = 'Failed to update profile',
    super.code,
  });
}

class ProfileIncompleteFailure extends Failure {
  const ProfileIncompleteFailure({
    super.message = 'Profile is incomplete',
    super.code = 400,
  });
}

// File upload failures
class FileUploadFailure extends Failure {
  const FileUploadFailure({
    required super.message,
    super.code,
  });
}

class FileSizeExceededFailure extends Failure {
  const FileSizeExceededFailure({
    super.message = 'File size exceeds limit',
    super.code = 413,
  });
}

class UnsupportedFileTypeFailure extends Failure {
  const UnsupportedFileTypeFailure({
    super.message = 'Unsupported file type',
    super.code = 415,
  });
}

class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure({
    super.message = 'File not found',
    super.code = 404,
  });
}

// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
  });
}

class CameraPermissionFailure extends Failure {
  const CameraPermissionFailure({
    super.message = 'Camera permission required',
    super.code = 403,
  });
}

class MicrophonePermissionFailure extends Failure {
  const MicrophonePermissionFailure({
    super.message = 'Microphone permission required',
    super.code = 403,
  });
}

class StoragePermissionFailure extends Failure {
  const StoragePermissionFailure({
    super.message = 'Storage permission required',
    super.code = 403,
  });
}

class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure({
    super.message = 'Location permission required',
    super.code = 403,
  });
}

// Cache failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

class CacheNotFoundFailure extends Failure {
  const CacheNotFoundFailure({
    super.message = 'Data not found in cache',
    super.code = 404,
  });
}

class CacheExpiredFailure extends Failure {
  const CacheExpiredFailure({
    super.message = 'Cached data has expired',
    super.code,
  });
}

// General failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unknown error occurred',
    super.code,
  });
}

class NotImplementedFailure extends Failure {
  const NotImplementedFailure({
    super.message = 'Feature not implemented',
    super.code = 501,
  });
}

class MaintenanceFailure extends Failure {
  const MaintenanceFailure({
    super.message = 'Service is under maintenance',
    super.code = 503,
  });
}

// API specific failures
class BadRequestFailure extends Failure {
  const BadRequestFailure({
    required super.message,
    super.code = 400,
  });
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    super.message = 'Forbidden',
    super.code = 403,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found',
    super.code = 404,
  });
}

class ConflictFailure extends Failure {
  const ConflictFailure({
    required super.message,
    super.code = 409,
  });
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure({
    super.message = 'Too many requests',
    super.code = 429,
  });
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure({
    super.message = 'Internal server error',
    super.code = 500,
  });
}

class BadGatewayFailure extends Failure {
  const BadGatewayFailure({
    super.message = 'Bad gateway',
    super.code = 502,
  });
}

class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure({
    super.message = 'Service unavailable',
    super.code = 503,
  });
}

// Dating app specific failures
class MatchFailure extends Failure {
  const MatchFailure({
    required super.message,
    super.code,
  });
}

class SwipeFailure extends Failure {
  const SwipeFailure({
    super.message = 'Failed to process swipe',
    super.code,
  });
}

class NoMoreProfilesFailure extends Failure {
  const NoMoreProfilesFailure({
    super.message = 'No more profiles available',
    super.code = 204,
  });
}

// Job app specific failures
class JobFailure extends Failure {
  const JobFailure({
    required super.message,
    super.code,
  });
}

class JobNotFoundFailure extends Failure {
  const JobNotFoundFailure({
    super.message = 'Job not found',
    super.code = 404,
  });
}

class ApplicationFailure extends Failure {
  const ApplicationFailure({
    super.message = 'Failed to submit application',
    super.code,
  });
}

class AlreadyAppliedFailure extends Failure {
  const AlreadyAppliedFailure({
    super.message = 'Already applied to this job',
    super.code = 409,
  });
}

// Helper class for failure mapping
class FailureMapper {
  static Failure mapHttpStatusCodeToFailure(int statusCode, String message) {
    switch (statusCode) {
      case 400:
        return BadRequestFailure(message: message);
      case 401:
        return UnauthorizedFailure(message: message);
      case 403:
        return ForbiddenFailure(message: message);
      case 404:
        return NotFoundFailure(message: message);
      case 409:
        return ConflictFailure(message: message);
      case 429:
        return TooManyRequestsFailure(message: message);
      case 500:
        return InternalServerErrorFailure(message: message);
      case 502:
        return BadGatewayFailure(message: message);
      case 503:
        return ServiceUnavailableFailure(message: message);
      default:
        return ServerFailure(message: message, code: statusCode);
    }
  }

  static Failure mapExceptionToFailure(Exception exception) {
    final message = exception.toString();
    
    if (message.contains('SocketException') || 
        message.contains('HandshakeException')) {
      return const ConnectionFailure();
    }
    
    if (message.contains('TimeoutException')) {
      return const TimeoutFailure();
    }
    
    if (message.contains('FormatException')) {
      return ValidationFailure(message: 'Invalid data format: $message');
    }
    
    return UnknownFailure(message: message);
  }
}
// Usage example
// try {
//   // Some operation that may throw an exception
// } catch (e) {
//   final failure = FailureMapper.mapExceptionToFailure(e);  