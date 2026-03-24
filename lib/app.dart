import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/select_screenshot_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //this line makes sure the standard red debug button doesn't show in my design
      debugShowCheckedModeBanner: false,
      title: 'Phishing Check',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        fontFamily: 'Arial',
        // colorScheme builds a colorscheme from my main blue (seedcolor), this can be used if I don't specify a color for something myself
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B6EF5),
        ),
        // useMaterial3 tells flutter to use the newer styles, material3 is a newer style that is more modern. It also has newer widgets
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/upload': (context) => const SelectScreenshotScreen(),
      },
    );
  }
}