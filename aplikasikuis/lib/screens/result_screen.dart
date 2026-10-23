import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'main_navigation_screen.dart';

class ResultScreen extends StatelessWidget {
  final String userName;

  const ResultScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final score = quizProvider.calculateScore();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3342CC), Color(0xFF4834DF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      size: 90,
                      color: Color(0xFFFFB300),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Selamat, $userName!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.055,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kamu telah menyelesaikan seluruh pertanyaan kuis.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF718096), fontSize: 13),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'SKOR AKHIR',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color(0xFF718096),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$score',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3342CC),
                            ),
                          ),
                          Text(
                            'Jawaban Benar: ${score ~/ 20} / ${quizProvider.questions.length}',
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4A5568)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton.icon(
                      onPressed: () {
                        quizProvider.resetQuiz();
                        // Kembali ke halaman utama (MainNavigationScreen)
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                              (route) => false,
                        );
                      },
                      icon: const Icon(Icons.home_rounded),
                      label: const Text('Kembali ke Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3342CC),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}