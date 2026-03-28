import 'package:flutter/material.dart';

class ServiceDropdownField extends StatelessWidget {
  const ServiceDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.validator,
  });

  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: const Text('Chon dich vu'),
      items: items
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

