// Base exception class
import 'package:chat_mobile/core/errors/failures.dart';

abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

// Network exceptions
class NetworkException extends AppException {
  const NetworkException({required super.message, super.code});

  @override
  String toString() => 'NetworkException: $message (Code: $code)';
}

class ServerException extends AppException {
  const ServerException({required super.message, super.code});

  @override
  String toString() => 'ServerException: $message (Code: $code)';
}

class ConnectionException extends AppException {
  const ConnectionException({
    super.message = 'No internet connection',
    super.code,
  });

  @override
  String toString() => 'ConnectionException: $message';
}

class TimeoutException extends AppException {
  const TimeoutException({super.message = 'Request timeout', super.code});

  @override
  String toString() => 'TimeoutException: $message';
}

// Authentication exceptions
class AuthenticationException extends AppException {
  const AuthenticationException({required super.message, super.code});

  @override
  String toString() => 'AuthenticationException: $message (Code: $code)';
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.code = 401,
  });

  @override
  String toString() => 'UnauthorizedException: $message';
}

class TokenExpiredException extends AppException {
  const TokenExpiredException({
    super.message = 'Token has expired',
    super.code = 401,
  });

  @override
  String toString() => 'TokenExpiredException: $message';
}

class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException({
    super.message = 'Invalid email or password',
    super.code = 401,
  });

  @override
  String toString() => 'InvalidCredentialsException: $message';
}

class AccountNotFoundException extends AppException {
  const AccountNotFoundException({
    super.message = 'Account not found',
    super.code = 404,
  });

  @override
  String toString() => 'AccountNotFoundException: $message';
}

class AccountAlreadyExistsException extends AppException {
  const AccountAlreadyExistsException({
    super.message = 'Account already exists',
    super.code = 409,
  });

  @override
  String toString() => 'AccountAlreadyExistsException: $message';
}

class EmailNotVerifiedException extends AppException {
  const EmailNotVerifiedException({
    super.message = 'Email not verified',
    super.code = 403,
  });

  @override
  String toString() => 'EmailNotVerifiedException: $message';
}

// Validation exceptions
class ValidationException extends AppException {
  const ValidationException({required super.message, super.code = 400});

  @override
  String toString() => 'ValidationException: $message';
}

class InvalidInputException extends AppException {
  const InvalidInputException({required super.message, super.code = 400});

  @override
  String toString() => 'InvalidInputException: $message';
}

class MissingRequiredFieldException extends AppException {
  const MissingRequiredFieldException({
    required String fieldName,
    super.code = 400,
  }) : super(message: '$fieldName is required');

  @override
  String toString() => 'MissingRequiredFieldException: $message';
}

// Collection exceptions
class CollectionException extends AppException {
  const CollectionException({required super.message, super.code});

  @override
  String toString() => 'CollectionException: $message (Code: $code)';
}

class CollectionNotFoundException extends AppException {
  const CollectionNotFoundException({
    super.message = 'Collection not found',
    super.code = 404,
  });

  @override
  String toString() => 'CollectionNotFoundException: $message';
}

class CollectionAccessDeniedException extends AppException {
  const CollectionAccessDeniedException({
    super.message = 'Access denied to collection',
    super.code = 403,
  });

  @override
  String toString() => 'CollectionAccessDeniedException: $message';
}

class CollectionFullException extends AppException {
  const CollectionFullException({
    super.message = 'Collection is full',
    super.code = 409,
  });

  @override
  String toString() => 'CollectionFullException: $message';
}

class AlreadyMemberException extends AppException {
  const AlreadyMemberException({
    super.message = 'Already a member of this collection',
    super.code = 409,
  });

  @override
  String toString() => 'AlreadyMemberException: $message';
}

class NotMemberException extends AppException {
  const NotMemberException({
    super.message = 'Not a member of this collection',
    super.code = 403,
  });

  @override
  String toString() => 'NotMemberException: $message';
}

// Chat exceptions
class ChatException extends AppException {
  const ChatException({required super.message, super.code});

  @override
  String toString() => 'ChatException: $message (Code: $code)';
}

class MessageSendException extends AppException {
  const MessageSendException({
    super.message = 'Failed to send message',
    super.code,
  });

  @override
  String toString() => 'MessageSendException: $message';
}

class ChatRoomNotFoundException extends AppException {
  const ChatRoomNotFoundException({
    super.message = 'Chat room not found',
    super.code = 404,
  });

  @override
  String toString() => 'ChatRoomNotFoundException: $message';
}

class CallException extends AppException {
  const CallException({required super.message, super.code});

  @override
  String toString() => 'CallException: $message (Code: $code)';
}

class CallConnectionException extends AppException {
  const CallConnectionException({
    super.message = 'Failed to connect call',
    super.code,
  });

  @override
  String toString() => 'CallConnectionException: $message';
}

class CallPermissionException extends AppException {
  const CallPermissionException({
    super.message = 'Permission denied for call',
    super.code = 403,
  });

  @override
  String toString() => 'CallPermissionException: $message';
}

// Profile exceptions
class ProfileException extends AppException {
  const ProfileException({required super.message, super.code});

  @override
  String toString() => 'ProfileException: $message (Code: $code)';
}

class ProfileNotFoundException extends AppException {
  const ProfileNotFoundException({
    super.message = 'Profile not found',
    super.code = 404,
  });

  @override
  String toString() => 'ProfileNotFoundException: $message';
}

class ProfileUpdateException extends AppException {
  const ProfileUpdateException({
    super.message = 'Failed to update profile',
    super.code,
  });

  @override
  String toString() => 'ProfileUpdateException: $message';
}

class ProfileIncompleteException extends AppException {
  const ProfileIncompleteException({
    super.message = 'Profile is incomplete',
    super.code = 400,
  });

  @override
  String toString() => 'ProfileIncompleteException: $message';
}

// File upload exceptions
class FileUploadException extends AppException {
  const FileUploadException({required super.message, super.code});

  @override
  String toString() => 'FileUploadException: $message (Code: $code)';
}

class FileSizeExceededException extends AppException {
  const FileSizeExceededException({
    super.message = 'File size exceeds limit',
    super.code = 413,
  });

  @override
  String toString() => 'FileSizeExceededException: $message';
}

class UnsupportedFileTypeException extends AppException {
  const UnsupportedFileTypeException({
    super.message = 'Unsupported file type',
    super.code = 415,
  });

  @override
  String toString() => 'UnsupportedFileTypeException: $message';
}

class FileNotFoundException extends AppException {
  const FileNotFoundException({
    super.message = 'File not found',
    super.code = 404,
  });

  @override
  String toString() => 'FileNotFoundException: $message';
}

// Permission exceptions
class PermissionException extends AppException {
  const PermissionException({required super.message, super.code = 403});

  @override
  String toString() => 'PermissionException: $message';
}

class CameraPermissionException extends AppException {
  const CameraPermissionException({
    super.message = 'Camera permission required',
    super.code = 403,
  });

  @override
  String toString() => 'CameraPermissionException: $message';
}

class MicrophonePermissionException extends AppException {
  const MicrophonePermissionException({
    super.message = 'Microphone permission required',
    super.code = 403,
  });

  @override
  String toString() => 'MicrophonePermissionException: $message';
}

class StoragePermissionException extends AppException {
  const StoragePermissionException({
    super.message = 'Storage permission required',
    super.code = 403,
  });

  @override
  String toString() => 'StoragePermissionException: $message';
}

class LocationPermissionException extends AppException {
  const LocationPermissionException({
    super.message = 'Location permission required',
    super.code = 403,
  });

  @override
  String toString() => 'LocationPermissionException: $message';
}

// Cache exceptions
class CacheException extends AppException {
  const CacheException({required super.message, super.code});

  @override
  String toString() => 'CacheException: $message (Code: $code)';
}

class CacheNotFoundException extends AppException {
  const CacheNotFoundException({
    super.message = 'Data not found in cache',
    super.code = 404,
  });

  @override
  String toString() => 'CacheNotFoundException: $message';
}

class CacheWriteException extends AppException {
  const CacheWriteException({
    super.message = 'Failed to write data to cache',
    super.code = 500,
  });

  @override
  String toString() => 'CacheWriteException: $message';
}

class CacheReadException extends AppException {
  const CacheReadException({
    super.message = 'Failed to read data from cache',
    super.code = 500,
  });

  @override
  String toString() => 'CacheReadException: $message';
}
