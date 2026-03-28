import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.controller,
    required this.onTap,
    required this.validator,
  });

  final TextEditingController controller;
  final Future<void> Function() onTap;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Chon gio',
        suffixIcon: Icon(Icons.access_time),
      ),
      onTap: onTap,
      validator: validator,
    );
  }
}

