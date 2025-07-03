import 'package:intl/intl.dart';

class DateUtils {
  // Private constructor to prevent instantiation
  DateUtils._();

  // Common date formats
  static const String defaultDateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String chatTimeFormat = 'hh:mm a';
  static const String chatDateFormat = 'MMM dd';
  static const String fullDateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const String birthdateFormat = 'dd/MM/yyyy';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';

  // Format date to string
  static String formatDate(DateTime date, [String format = displayDateFormat]) {
    try {
      return DateFormat(format).format(date);
    } catch (e) {
      return DateFormat(displayDateFormat).format(date);
    }
  }

  // Parse string to date
  static DateTime? parseDate(String dateString, [String format = defaultDateFormat]) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      // Try common formats if the provided format fails
      final commonFormats = [
        defaultDateFormat,
        displayDateFormat,
        dateTimeFormat,
        apiDateTimeFormat,
        birthdateFormat,
        'dd-MM-yyyy',
        'MM/dd/yyyy',
      ];

      for (String commonFormat in commonFormats) {
        try {
          return DateFormat(commonFormat).parse(dateString);
        } catch (e) {
          continue;
        }
      }
      return null;
    }
  }

  // Get current date as string
  static String getCurrentDate([String format = defaultDateFormat]) {
    return formatDate(DateTime.now(), format);
  }

  // Get current time as string
  static String getCurrentTime([String format = timeFormat]) {
    return formatDate(DateTime.now(), format);
  }

  // Get current date and time as string
  static String getCurrentDateTime([String format = dateTimeFormat]) {
    return formatDate(DateTime.now(), format);
  }

  // Calculate age from birthdate
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }

  // Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  // Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }

  // Check if date is this week
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
           date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  // Get time difference in human readable format
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  // Format time for chat messages
  static String formatChatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (isToday(dateTime)) {
      return formatDate(dateTime, chatTimeFormat);
    } else if (isYesterday(dateTime)) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(dateTime); // Day name
    } else {
      return formatDate(dateTime, chatDateFormat);
    }
  }

  // Get last seen format
  static String formatLastSeen(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Online';
    } else if (difference.inMinutes < 60) {
      return 'Last seen ${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return 'Last seen ${difference.inHours} hours ago';
    } else if (isYesterday(dateTime)) {
      return 'Last seen yesterday at ${formatDate(dateTime, chatTimeFormat)}';
    } else {
      return 'Last seen ${formatDate(dateTime, 'MMM dd')} at ${formatDate(dateTime, chatTimeFormat)}';
    }
  }

  // Check if user is online (last seen within 5 minutes)
  static bool isOnline(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    return difference.inMinutes <= 5;
  }

  // Get start of day
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Get end of day
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  // Get start of week (Monday)
  static DateTime getStartOfWeek(DateTime date) {
    final startOfDay = getStartOfDay(date);
    return startOfDay.subtract(Duration(days: startOfDay.weekday - 1));
  }

  // Get end of week (Sunday)
  static DateTime getEndOfWeek(DateTime date) {
    final startOfWeek = getStartOfWeek(date);
    return getEndOfDay(startOfWeek.add(const Duration(days: 6)));
  }

  // Get start of month
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  // Get end of month
  static DateTime getEndOfMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    return getEndOfDay(nextMonth.subtract(const Duration(days: 1)));
  }

  // Check if date is valid
  static bool isValidDate(String dateString, [String format = defaultDateFormat]) {
    try {
      DateFormat(format).parseStrict(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Check if birthdate is valid (person should be at least 18)
  static bool isValidBirthdate(DateTime birthDate) {
    final age = calculateAge(birthDate);
    return age >= 18 && age <= 120;
  }

  // Get days between two dates
  static int daysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  // Add business days (excluding weekends)
  static DateTime addBusinessDays(DateTime date, int days) {
    DateTime result = date;
    int addedDays = 0;
    
    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      // Skip weekends (Saturday = 6, Sunday = 7)
      if (result.weekday != 6 && result.weekday != 7) {
        addedDays++;
      }
    }
    
    return result;
  }

  // Check if date is weekend
  static bool isWeekend(DateTime date) {
    return date.weekday == 6 || date.weekday == 7; // Saturday or Sunday
  }

  // Get month name
  static String getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  // Get day name
  static String getDayName(int weekday) {
    const dayNames = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return dayNames[weekday - 1];
  }

  // Format duration
  static String formatDuration(Duration duration) {
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m';
    } else if (duration.inHours < 24) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    } else {
      final days = duration.inDays;
      final hours = duration.inHours % 24;
      return hours > 0 ? '${days}d ${hours}h' : '${days}d';
    }
  }

  // Get date for API calls (ISO format)
  static String toApiFormat(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  // Parse date from API response
  static DateTime? fromApiFormat(String dateString) {
    try {
      return DateTime.parse(dateString).toLocal();
    } catch (e) {
      return null;
    }
  }

  // Get timezone offset string
  static String getTimezoneOffset() {
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final sign = offset.isNegative ? '-' : '+';
    return '$sign$hours:$minutes';
  }

  // Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }

  // Get birthday greeting message
  static String getBirthdayMessage(DateTime birthDate) {
    final today = DateTime.now();
    final age = calculateAge(birthDate);
    
    if (today.month == birthDate.month && today.day == birthDate.day) {
      return 'Happy ${age}th Birthday! 🎉';
    }
    
    return '';
  }

  // Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  // Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }
}