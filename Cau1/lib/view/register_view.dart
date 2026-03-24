import 'package:cau1/utils/form_validators.dart';
import 'package:cau1/widget/custom_text_field.dart';
import 'package:cau1/widget/terms_checkbox.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _agreedToTerms = false;
  bool _isSubmitEnabled = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_refreshSubmitState);
    _emailController.addListener(_refreshSubmitState);
    _passwordController.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _refreshSubmitState() {
    final nameValid = _fullNameController.text.trim().isNotEmpty;
    final emailValid = FormValidators.isEmailValid(_emailController.text);
    final passwordValid = _passwordController.text.trim().isNotEmpty;
    final shouldEnable =
        nameValid && emailValid && passwordValid && _agreedToTerms;

    if (shouldEnable != _isSubmitEnabled) {
      setState(() {
        _isSubmitEnabled = shouldEnable;
      });
    }
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false) || !_agreedToTerms) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dang ky thanh cong')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Đăng Ký Tài Khoản'),
          centerTitle: true,
          backgroundColor: Colors.teal,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.account_circle, size: 34),
                          ),
                          SizedBox(height: 8),
                          Text('Account Circle'),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Đã có tài khoản?'),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Đăng Nhập'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Họ và Tên',
                  hint: 'Nhâp họ và tên',
                  controller: _fullNameController,
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'họ và tên'),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Email',
                  hint: 'example@domain.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Mật Khẩu',
                  hint: 'Nhâp mật khẩu',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: FormValidators.validatePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                TermsCheckbox(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                    _refreshSubmitState();
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isSubmitEnabled ? _handleSubmit : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.fromMap({
                      WidgetState.disabled: Colors.grey,
                      WidgetState.any: Colors.teal,
                    }),
                  ),
                  child: const Text('Đăng Ký'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

