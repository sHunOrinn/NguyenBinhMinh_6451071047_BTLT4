class FormValidators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }
    return null;
  }

  static bool isEmailValid(String value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(value.trim());
  }

  static String? validateEmail(String? value) {
    final requiredError = validateRequired(value, 'email');
    if (requiredError != null) {
      return requiredError;
    }

    if (!isEmailValid(value!.trim())) {
      return 'Email khong hop le';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    return validateRequired(value, 'mat khau');
  }
}

