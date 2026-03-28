import 'package:cau2/utils/form_validators.dart';
import 'package:cau2/widget/custom_text_field.dart';
import 'package:cau2/widget/dropdown_sex.dart';
import 'package:cau2/widget/relationship_radio.dart';
import 'package:cau2/widget/slider_salary.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sexController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _sexController.dispose();
    _relationshipController.dispose();
    _salaryController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM THÔNG TIN CÁ NHÂN'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('Back button pressed');
          },
        ),
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
                CustomTextField(
                  label: 'Họ và Tên',
                  hint: 'Nguyễn Bình Minh - 6451071047',
                  controller: _fullNameController,
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'họ và tên'),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Tuổi',
                  hint: 'Nhâp tuổi của bạn',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  validator: FormValidators.validateAge,
                  // suffixIcon: Icon(Icons.person),
                ),
                const SizedBox(height: 12),
                DropdownSex(
                  label: 'Giới tính',
                  hint: 'Chọn giới tính',
                  controller: _sexController,
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'giới tính'),
                ),
                const SizedBox(height: 12),
                RelationshipRadio(
                  label: 'Tình trạng hôn nhân',
                  controller: _relationshipController,
                  validator: FormValidators.validateRelationship,
                ),
                const SizedBox(height: 12),
                SliderSalary(
                  label: 'Mức thu nhập',
                  controller: _salaryController,
                  validator: FormValidators.validateSalary,
                ),
                const SizedBox(height: 8),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

