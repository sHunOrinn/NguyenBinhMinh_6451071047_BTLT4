import 'package:flutter/material.dart';

class InterestOption {
  const InterestOption({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

class InterestCheckboxGroup extends StatelessWidget {
  const InterestCheckboxGroup({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.validator,
  });

  final List<InterestOption> options;
  final Set<String> selectedValues;
  final ValueChanged<Set<String>> onChanged;
  final String? Function(Set<String>?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<Set<String>>(
      initialValue: Set<String>.from(selectedValues),
      validator: validator,
      builder: (state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                for (final option in options)
                  CheckboxListTile(
                    value: selectedValues.contains(option.label),
                    title: Text(option.label),
                    secondary: Icon(option.icon),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (checked) {
                      final updated = Set<String>.from(selectedValues);
                      if (checked ?? false) {
                        updated.add(option.label);
                      } else {
                        updated.remove(option.label);
                      }
                      onChanged(updated);
                      state.didChange(updated);
                    },
                  ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
