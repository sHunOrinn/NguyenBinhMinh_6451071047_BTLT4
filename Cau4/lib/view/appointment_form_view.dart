import 'package:cau4/utils/appointment_constants.dart';
import 'package:cau4/utils/form_validators.dart';
import 'package:cau4/widget/date_picker_field.dart';
import 'package:cau4/widget/service_dropdown_field.dart';
import 'package:cau4/widget/time_picker_field.dart';
import 'package:flutter/material.dart';

class AppointmentFormView extends StatefulWidget {
  const AppointmentFormView({super.key});

  @override
  State<AppointmentFormView> createState() => _AppointmentFormViewState();
}

class _AppointmentFormViewState extends State<AppointmentFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedDate ?? now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
      _dateController.text = formatDate(pickedDate);
    });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime == null) {
      return;
    }

    setState(() {
      _selectedTime = pickedTime;
      _timeController.text = formatTime(pickedTime.hour, pickedTime.minute);
    });
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dat lich thanh cong'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ĐẶT LỊCH HẸN'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Chọn ngày',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DatePickerField(
                  controller: _dateController,
                  onTap: _pickDate,
                  validator: (_) => validateAppointmentDate(_selectedDate),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Chọn giờ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TimePickerField(
                  controller: _timeController,
                  onTap: _pickTime,
                  validator: (_) => validateAppointmentTime(_selectedTime),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Chọn dịch vụ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ServiceDropdownField(
                  value: _selectedService,
                  items: AppointmentConstants.serviceOptions,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedService = value;
                    });
                  },
                  validator: validateService,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Xac nhan Dat lich'),
                ),
                const SizedBox(height: 24),
                
                Text(
                    "Nguyễn Bình Minh - 6451071047",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
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

