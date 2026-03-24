import 'package:flutter/material.dart';

class RelationshipRadio extends StatelessWidget {
  const RelationshipRadio({
	super.key,
	required this.label,
	required this.controller,
	required this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
	return FormField<String>(
	  initialValue: controller.text.isEmpty ? null : controller.text,
	  validator: validator,
	  builder: (state) {
		return Column(
		  crossAxisAlignment: CrossAxisAlignment.start,
		  children: [
			Text(label, style: Theme.of(context).textTheme.titleMedium),
			RadioListTile<String>(
			  title: const Text('Độc thân'),
			  value: 'Độc thân',
			  groupValue: state.value,
			  onChanged: (value) {
				controller.text = value ?? '';
				state.didChange(value);
			  },
			),
			RadioListTile<String>(
			  title: const Text('Kết hôn'),
			  value: 'Kết hôn',
			  groupValue: state.value,
			  onChanged: (value) {
				controller.text = value ?? '';
				state.didChange(value);
			  },
			),
			RadioListTile<String>(
			  title: const Text('Ly hôn'),
			  value: 'Ly hôn',
			  groupValue: state.value,
			  onChanged: (value) {
				controller.text = value ?? '';
				state.didChange(value);
			  },
			),
			if (state.hasError)
			  Padding(
				padding: const EdgeInsets.only(left: 12),
				child: Text(
				  state.errorText ?? '',
				  style: TextStyle(
					color: Theme.of(context).colorScheme.error,
					fontSize: 12,
				  ),
				),
			  ),
		  ],
		);
	  },
	);
  }
}

