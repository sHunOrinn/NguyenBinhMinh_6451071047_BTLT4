import 'package:flutter/material.dart';

class SliderSalary extends StatelessWidget {
  const SliderSalary({
	super.key,
	required this.label,
	required this.controller,
	required this.validator,
	this.min = 0,
	this.max = 30,
	this.divisions = 30,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final double min;
  final double max;
  final int divisions;

  @override
  Widget build(BuildContext context) {
	final parsedValue = double.tryParse(controller.text);
	final initialValue = parsedValue == null
		? 15.0
		: parsedValue.clamp(min, max).toDouble();

	return FormField<double>(
	  initialValue: initialValue,
	  validator: (value) => validator(value?.toString()),
	  builder: (state) {
		final currentValue = state.value ?? initialValue;
		controller.text = currentValue.toStringAsFixed(0);

		return Column(
		  crossAxisAlignment: CrossAxisAlignment.start,
		  children: [
			Text(label, style: Theme.of(context).textTheme.titleMedium),
			const SizedBox(height: 6),
			Text('Mức: ${currentValue.toStringAsFixed(0)} tr VND'),
			Slider(
			  value: currentValue,
			  min: min,
			  max: max,
			  divisions: divisions,
			  label: currentValue.toStringAsFixed(0),
			  onChanged: (value) {
				controller.text = value.toStringAsFixed(0);
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

