class AppointmentConstants {
  static const List<String> serviceOptions = <String>[
    'Kiem tra tong quat',
    'Dich vu 2',
    'Dich vu 3',
  ];
}

String formatDate(DateTime date) {
  final String day = date.day.toString().padLeft(2, '0');
  final String month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}

String formatTime(int hour, int minute) {
  final String hourText = hour.toString().padLeft(2, '0');
  final String minuteText = minute.toString().padLeft(2, '0');
  return '$hourText:$minuteText';
}

