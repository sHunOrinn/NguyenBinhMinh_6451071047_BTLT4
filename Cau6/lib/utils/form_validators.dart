import 'package:flutter/material.dart';

class FormValidators {
  static String? validateFullName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Vui long nhap ho ten';
    }
    if (text.length < 3) {
      return 'Ho ten phai tu 3 ky tu tro len';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Vui long nhap email';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(text)) {
      return 'Email khong hop le';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Vui long nhap mat khau';
    }
    if (text.length < 8) {
      return 'Mat khau phai co it nhat 8 ky tu';
    }
    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return 'Mat khau can it nhat 1 chu in hoa';
    }
    if (!RegExp(r'[a-z]').hasMatch(text)) {
      return 'Mat khau can it nhat 1 chu thuong';
    }
    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return 'Mat khau can it nhat 1 chu so';
    }
    return null;
  }

  static String? validateConfirmPassword({
    required String password,
    required String? confirmPassword,
  }) {
    final text = confirmPassword ?? '';
    if (text.isEmpty) {
      return 'Vui long xac nhan mat khau';
    }
    if (password != text) {
      return 'Mat khau xac nhan chua khop';
    }
    return null;
  }

  static int passwordStrengthScore(String value) {
    var score = 0;
    if (value.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[a-z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(value)) score++;
    return score;
  }

  static String passwordStrengthText(String value) {
    if (value.isEmpty) {
      return 'Hay nhap mat khau manh';
    }

    final score = passwordStrengthScore(value);
    if (score <= 2) {
      return 'Yeu, hay them ky tu dac biet';
    }
    if (score == 3 || score == 4) {
      return 'Tam on, ban co the them ky tu dac biet';
    }
    return 'Rat tot, mat khau kha manh';
  }

  static Color passwordStrengthColor(String value) {
    final score = passwordStrengthScore(value);
    if (score <= 2) {
      return Colors.red.shade700;
    }
    if (score <= 4) {
      return Colors.orange.shade700;
    }
    return Colors.green.shade700;
  }
}

