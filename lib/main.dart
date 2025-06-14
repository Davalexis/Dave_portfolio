import 'package:dave_portfolio/Features/Landing_page/LandingPage_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dave portfolio',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: textTheme.apply(
          bodyColor: const Color(0xFF1A1A1A),
          displayColor: const Color(0xFF1A1A1A),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: const Color(0xFF1A1A1A)),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: const Color(0xFF1A1A1A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: LandingPagePortfolio(),
    );
  }
}
