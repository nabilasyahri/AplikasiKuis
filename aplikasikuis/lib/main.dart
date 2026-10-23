import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      themeMode: quizProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        fontFamily: 'Creato Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3342CC),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'Creato Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3342CC),
          brightness: Brightness.dark,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}