import 'package:cau3/utils/form_validators.dart';
import 'package:cau3/widget/interest_checkbox_group.dart';
import 'package:flutter/material.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final Set<String> _selectedInterests = <String>{};
  String? _selectedSatisfaction;

  static const _interestOptions = <InterestOption>[
    InterestOption(label: 'Phim ảnh (Movies)', icon: Icons.movie),
    InterestOption(label: 'Thể thao (Sports)', icon: Icons.sports_soccer),
    InterestOption(label: 'Âm nhạc (Music)', icon: Icons.music_note),
    InterestOption(label: 'Du lịch (Travel)', icon: Icons.card_travel),
  ];

  static const _satisfactionOptions = <String>[
    'Hài lòng (Satisfied)',
    'Bình thường (Neutral)',
    'Chưa hài lòng (Unsatisfied)',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submitSurvey() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã gửi khảo sát: ${_selectedInterests.length} sở thích, $_selectedSatisfaction',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'SỞ THÍCH (INTERESTS) - Nguyễn Bình Minh - 6451071047',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                InterestCheckboxGroup(
                  options: _interestOptions,
                  selectedValues: _selectedInterests,
                  validator: FormValidators.validateAtLeastOneInterest,
                  onChanged: (updatedValues) {
                    setState(() {
                      _selectedInterests
                        ..clear()
                        ..addAll(updatedValues);
                    });
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'MỨC ĐỘ HÀI LÒNG (SATISFACTION LEVEL)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                FormField<String>(
                  initialValue: _selectedSatisfaction,
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'mức độ hài lòng'),
                  builder: (state) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            for (final option in _satisfactionOptions)
                              RadioListTile<String>(
                                value: option,
                                groupValue: _selectedSatisfaction,
                                title: Text(option),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSatisfaction = value;
                                  });
                                  state.didChange(value);
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'GHI CHÚ THÊM (ADDITIONAL NOTES)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Ghi chú thêm...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitSurvey,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Gửi khảo sát',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

