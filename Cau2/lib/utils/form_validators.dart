class FormValidators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }
    return null;
  }


  static String? validateAge(String? value) {
    final requiredError = validateRequired(value, 'tuoi');
    if (requiredError != null) {
      return requiredError;
    }

    final age = int.tryParse(value!.trim());
    if (age == null || age <= 0) {
      return 'Tuổi không hợp lệ';
    }
    return null;
  }

  static String? validateRelationship(String? value) {
    return validateRequired(value, 'tình trạng hôn nhân');
  }

  static String? validateSalary(String? value) {
    final parsedSalary = double.tryParse(value?.trim() ?? '');
    if (parsedSalary == null || parsedSalary <= 0) {
      return 'Mức thu nhập phải lớn hơn 0';
    }
    return null;
  }
}

