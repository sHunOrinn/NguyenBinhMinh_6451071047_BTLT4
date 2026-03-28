import 'package:flutter/material.dart';

import '../view/register_form_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bai 6 - Form dang ky nang cao',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          errorMaxLines: 2,
        ),
      ),
      home: const RegisterFormView(),
    );
  }
}