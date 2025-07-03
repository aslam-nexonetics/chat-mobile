import 'package:flutter/services.dart';

class Validators {
  // Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (cleanNumber.length > 15) {
      return 'Phone number cannot exceed 15 digits';
    }

    return null;
  }

  // Name validation
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }

    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }

    if (name.trim().length > 50) {
      return 'Name cannot exceed 50 characters';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name.trim())) {
      return 'Name can only contain letters and spaces';
    }

    return null;
  }

  // Age validation
  static String? validateAge(String? age) {
    if (age == null || age.isEmpty) {
      return 'Age is required';
    }

    final ageInt = int.tryParse(age);
    if (ageInt == null) {
      return 'Please enter a valid age';
    }

    if (ageInt < 18) {
      return 'You must be at least 18 years old';
    }

    if (ageInt > 120) {
      return 'Please enter a valid age';
    }

    return null;
  }

  // Username validation
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }

    if (username.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    if (username.length > 20) {
      return 'Username cannot exceed 20 characters';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    if (username.startsWith('_') || username.endsWith('_')) {
      return 'Username cannot start or end with underscore';
    }

    return null;
  }

  // URL validation
  static String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return null; // URL is optional in most cases
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(url)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // Bio/Description validation
  static String? validateBio(String? bio, {int maxLength = 500}) {
    if (bio == null || bio.isEmpty) {
      return null; // Bio is usually optional
    }

    if (bio.length > maxLength) {
      return 'Bio cannot exceed $maxLength characters';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Salary validation (for job profiles)
  static String? validateSalary(String? salary) {
    if (salary == null || salary.isEmpty) {
      return null; // Salary might be optional
    }

    final salaryValue = double.tryParse(salary.replaceAll(',', ''));
    if (salaryValue == null) {
      return 'Please enter a valid salary amount';
    }

    if (salaryValue < 0) {
      return 'Salary cannot be negative';
    }

    if (salaryValue > 10000000) {
      return 'Please enter a realistic salary amount';
    }

    return null;
  }

  // Experience validation (for job profiles)
  static String? validateExperience(String? experience) {
    if (experience == null || experience.isEmpty) {
      return null; // Experience might be optional
    }

    final expValue = double.tryParse(experience);
    if (expValue == null) {
      return 'Please enter a valid experience value';
    }

    if (expValue < 0) {
      return 'Experience cannot be negative';
    }

    if (expValue > 50) {
      return 'Please enter a realistic experience value';
    }

    return null;
  }

  // Collection name validation
  static String? validateCollectionName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Collection name is required';
    }

    if (name.length < 3) {
      return 'Collection name must be at least 3 characters long';
    }

    if (name.length > 30) {
      return 'Collection name cannot exceed 30 characters';
    }

    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(name)) {
      return 'Collection name can only contain letters, numbers, and spaces';
    }

    return null;
  }

  // Chat message validation
  static String? validateChatMessage(String? message) {
    if (message == null || message.trim().isEmpty) {
      return 'Message cannot be empty';
    }

    if (message.trim().length > 1000) {
      return 'Message cannot exceed 1000 characters';
    }

    return null;
  }

  // Date validation
  static String? validateDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Date is required';
    }

    try {
      DateTime.parse(date);
      return null;
    } catch (e) {
      return 'Please enter a valid date';
    }
  }

  // Credit card validation (if payment features are added)
  static String? validateCreditCard(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) {
      return 'Card number is required';
    }

    final cleanNumber = cardNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return 'Please enter a valid card number';
    }

    // Luhn algorithm validation
    int sum = 0;
    bool alternate = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return 'Please enter a valid card number';
    }

    return null;
  }

  // Custom validation for combining multiple validators
  static String? validateMultiple(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  // Text input formatter for phone numbers
  static List<TextInputFormatter> phoneNumberFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(15),
  ];

  // Text input formatter for names
  static List<TextInputFormatter> nameFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
    LengthLimitingTextInputFormatter(50),
  ];

  // Text input formatter for usernames
  static List<TextInputFormatter> usernameFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
    LengthLimitingTextInputFormatter(20),
  ];

  // Text input formatter for numeric values
  static List<TextInputFormatter> numericFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  ];

  // Text input formatter for age
  static List<TextInputFormatter> ageFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(3),
  ];
}
