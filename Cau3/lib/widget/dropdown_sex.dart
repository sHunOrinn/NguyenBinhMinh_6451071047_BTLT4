import 'package:flutter/material.dart';

class DropdownSex extends StatelessWidget {
  const DropdownSex({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: controller.text.isEmpty ? null : controller.text,
      items: const [
        DropdownMenuItem(value: 'Nam', child: Text('Nam')),
        DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
        DropdownMenuItem(value: 'Khác', child: Text('Khác')),
      ],
      onChanged: (value) {
        controller.text = value ?? '';
      },
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
