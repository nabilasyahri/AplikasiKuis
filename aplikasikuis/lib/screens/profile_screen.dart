import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final isDark = quizProvider.isDarkMode;
    final userName = quizProvider.userName.isEmpty ? 'User' : quizProvider.userName;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFF3342CC),
                          child: Icon(Icons.person_rounded, size: 45, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Mahasiswa / Pengguna Kuis',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SwitchListTile(
                      value: isDark,
                      onChanged: (val) => quizProvider.toggleTheme(),
                      title: const Text('Mode Gelap', style: TextStyle(fontWeight: FontWeight.w600)),
                      secondary: Icon(
                        isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: const Color(0xFF3342CC),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                      title: const Text('Keluar / Ganti Nama', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                      onTap: () {
                        quizProvider.resetQuiz();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}