import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_option_card.dart';
import 'main_navigation_screen.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  final String userName;

  const QuizScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        final currentQuestion = quizProvider.questions[quizProvider.currentQuestionIndex];
        final selectedAnswerIndex = quizProvider.userAnswers[quizProvider.currentQuestionIndex];

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FB),
          body: SafeArea(
            child: Column(
              children: [
                // Header Biru dengan Tombol Kembali & Sudut Melengkung
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3342CC),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Tombol Kembali ke MainNavigationScreen (Home)
                          IconButton(
                            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                            onPressed: () {
                              quizProvider.resetQuiz();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainNavigationScreen(),
                                ),
                              );
                            },
                          ),
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white24,
                            child: Icon(Icons.person_rounded, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Halo, $userName! ^^',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.038,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Konten Soal & Opsi Jawaban
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: 12.0,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.all(screenSize.width * 0.05),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    currentQuestion.questionText,
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.043,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2D3748),
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Opsi Jawaban A, B, C, D
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: currentQuestion.options.length,
                                  itemBuilder: (context, index) {
                                    return AnswerOptionCard(
                                      index: index,
                                      optionText: currentQuestion.options[index],
                                      isSelected: selectedAnswerIndex == index,
                                      onTap: () {
                                        quizProvider.selectAnswer(quizProvider.currentQuestionIndex, index);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Tombol Navigasi Bawah
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
                          child: Row(
                            children: [
                              if (quizProvider.currentQuestionIndex > 0)
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      quizProvider.previousQuestion();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE8ECF8),
                                      side: BorderSide.none,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sebelumnya',
                                      style: TextStyle(
                                        color: Color(0xFF3342CC),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              if (quizProvider.currentQuestionIndex > 0) const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: selectedAnswerIndex == null
                                      ? null
                                      : () {
                                    if (quizProvider.currentQuestionIndex < quizProvider.questions.length - 1) {
                                      quizProvider.nextQuestion();
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultScreen(userName: userName),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3342CC),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 1,
                                  ),
                                  child: Text(
                                    quizProvider.currentQuestionIndex == quizProvider.questions.length - 1
                                        ? 'Selesai'
                                        : 'Selanjutnya',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}