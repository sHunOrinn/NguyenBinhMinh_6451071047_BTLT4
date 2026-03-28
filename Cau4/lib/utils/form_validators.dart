import 'package:flutter/material.dart';

String? validateAppointmentDate(DateTime? selectedDate) {
  if (selectedDate == null) {
    return 'Vui long chon ngay';
  }

  final DateTime today = DateTime.now();
  final DateTime normalizedToday = DateTime(today.year, today.month, today.day);
  final DateTime normalizedSelectedDate =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

  if (normalizedSelectedDate.isBefore(normalizedToday)) {
    return 'Ngay khong hop le (trong qua khu)';
  }

  return null;
}

String? validateAppointmentTime(TimeOfDay? selectedTime) {
  if (selectedTime == null) {
    return 'Vui long chon gio';
  }

  return null;
}

String? validateService(String? selectedService) {
  if (selectedService == null || selectedService.isEmpty) {
    return 'Vui long chon dich vu';
  }

  return null;
}

