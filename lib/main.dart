// main.dart

import 'package:flutter/material.dart';
import 'package:projek_akhir/page/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      home: LoginScreen(), // Menetapkan halaman login sebagai halaman awal
    );
  }
}
