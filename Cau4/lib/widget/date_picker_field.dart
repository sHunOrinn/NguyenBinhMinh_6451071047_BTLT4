import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
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
        hintText: 'Select Date',
        suffixIcon: Icon(Icons.calendar_month),
      ),
      onTap: onTap,
      validator: validator,
    );
  }
}

