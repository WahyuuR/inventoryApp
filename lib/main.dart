// main.dart

import 'package:flutter/material.dart';
import 'package:projek_akhir/page/home_screen.dart';
// import 'package:projek_akhir/page/_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      home: HomeScreen(
        title: '',
      ), // Menetapkan halaman login sebagai halaman awal
    );
  }
}
