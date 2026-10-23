import 'package:flutter/material.dart';
import '../data/dummy_questions.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {};
  bool _isDarkMode = false; // State untuk Dark Mode

  List<Question> get questions => dummyQuestions;
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, int> get userAnswers => _userAnswers;
  bool get isDarkMode => _isDarkMode;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    _userAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < dummyQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  int calculateScore() {
    int score = 0;
    _userAnswers.forEach((index, answer) {
      if (answer == dummyQuestions[index].correctOptionIndex) {
        score += 20;
      }
    });
    return score;
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    notifyListeners();
  }
}