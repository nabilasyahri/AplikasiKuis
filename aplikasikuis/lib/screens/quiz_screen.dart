import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_option_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required String userName});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final currentQuestion = quizProvider.questions[quizProvider.currentQuestionIndex];
    final selectedAnswerIndex = quizProvider.userAnswers[quizProvider.currentQuestionIndex];
    final screenSize = MediaQuery.of(context).size;

    return Scaffold (
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text('Halo, ${quizProvider.userName}! ^^'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dynamic Progress Bar & Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Soal ${quizProvider.currentQuestionIndex + 1} dari ${quizProvider.questions.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.04,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF6C63FF)),
                        const SizedBox(width: 4),
                        Text(
                          'UTS Mobile',
                          style: TextStyle(
                            color: const Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.012),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (quizProvider.currentQuestionIndex + 1) / quizProvider.questions.length,
                  backgroundColor: Colors.grey.shade300,
                  color: const Color(0xFF6C63FF),
                  minHeight: 8,
                ),
              ),
              SizedBox(height: screenSize.height * 0.025),

              // Question Card & Options Area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenSize.width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.help_outline_rounded, color: Color(0xFF6C63FF), size: 30),
                            SizedBox(height: screenSize.height * 0.01),
                            Text(
                              currentQuestion.questionText,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.045,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),

                      // Reusable Answer Options List
                      ...List.generate(
                        currentQuestion.options.length,
                            (index) => AnswerOptionCard(
                          optionText: currentQuestion.options[index],
                          isSelected: selectedAnswerIndex == index,
                          onTap: () {
                            quizProvider.selectAnswer(quizProvider.currentQuestionIndex, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Navigation Controls
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                child: Row(
                  children: [
                    if (quizProvider.currentQuestionIndex > 0)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => quizProvider.previousQuestion(),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: const Text('Sebelumnya'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    if (quizProvider.currentQuestionIndex > 0)
                      SizedBox(width: screenSize.width * 0.03),
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
                              MaterialPageRoute(builder: (context) => const ResultScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 2,
                        ),
                        child: Text(
                          quizProvider.currentQuestionIndex == quizProvider.questions.length - 1
                              ? 'Selesai Kuis'
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
    );
  }
}