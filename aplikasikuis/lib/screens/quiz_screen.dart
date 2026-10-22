import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_option_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  final String userName;

  const QuizScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        // Jika kuis selesai, arahkan ke ResultScreen
        if (quizProvider.isFinished) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(userName: userName),
              ),
            );
          });
        }

        final currentQuestion = quizProvider.questions[quizProvider.currentIndex];
        final selectedAnswerIndex = quizProvider.selectedAnswers[quizProvider.currentIndex];

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            title: Text('Halo, $userName!'),
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Indikator Progres Soal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Soal ${quizProvider.currentIndex + 1} dari ${quizProvider.questions.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF718096),
                      ),
                    ),
                    Text(
                      'Skor Sementara: ${quizProvider.score}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Kartu Pertanyaan
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    currentQuestion.questionText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Pilihan Jawaban (Menggunakan Reusable Widget)
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      return AnswerOptionCard(
                        optionText: currentQuestion.options[index],
                        isSelected: selectedAnswerIndex == index,
                        onTap: () {
                          quizProvider.selectAnswer(quizProvider.currentIndex, index);
                        },
                      );
                    },
                  ),
                ),

                // Tombol Navigasi Bawah
                Row(
                  children: [
                    if (quizProvider.currentIndex > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            quizProvider.previousQuestion();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Color(0xFF6C63FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Sebelumnya', style: TextStyle(color: Color(0xFF6C63FF))),
                        ),
                      ),
                    if (quizProvider.currentIndex > 0) const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: selectedAnswerIndex == null
                            ? null // Nonaktifkan jika belum memilih
                            : () {
                          quizProvider.nextQuestion();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          quizProvider.currentIndex == quizProvider.questions.length - 1
                              ? 'Selesai'
                              : 'Selanjutnya',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}