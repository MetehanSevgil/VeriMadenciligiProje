import 'package:flutter/material.dart';
import 'package:frontend/Page1.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 218, 250, 40)),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veri Madenciligi Proje',
      theme: theme,
      home: Page1Init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
