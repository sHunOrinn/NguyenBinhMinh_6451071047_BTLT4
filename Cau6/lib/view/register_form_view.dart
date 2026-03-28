import 'package:flutter/material.dart';

import '../utils/form_validators.dart';
import '../widget/custom_text_field.dart';

class RegisterFormView extends StatefulWidget {
  const RegisterFormView({super.key});

  @override
  State<RegisterFormView> createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get _isFormValid {
    return FormValidators.validateFullName(_nameController.text) == null &&
        FormValidators.validateEmail(_emailController.text) == null &&
        FormValidators.validatePassword(_passwordController.text) == null &&
        FormValidators.validateConfirmPassword(
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
            ) ==
            null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dang ky thanh cong')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Đăng ký nâng cao'),
        backgroundColor: Colors.blue.shade700,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Đăng ký tài khoản',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Họ tên',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  validator: FormValidators.validateFullName,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: FormValidators.validateEmail,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Mật khẩu',
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscurePassword,
                  validator: FormValidators.validatePassword,
                  onFieldSubmitted: (_) {
                    _confirmPasswordFocus.requestFocus();
                  },
                  onChanged: (_) => setState(() {}),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Xác nhận mật khẩu',
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    return FormValidators.validateConfirmPassword(
                      password: _passwordController.text,
                      confirmPassword: value,
                    );
                  },
                  onChanged: (_) => setState(() {}),
                  onFieldSubmitted: (_) => _submit(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  FormValidators.passwordStrengthText(_passwordController.text),
                  style: TextStyle(
                    color: FormValidators.passwordStrengthColor(
                      _passwordController.text,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.lightBlue,
                    ),
                    onPressed: _isFormValid ? _submit : null,
                    child: const Text(
                      'Đăng ký',
                       style: TextStyle(
                        color: Colors.white,
                    ),
                    ),
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

