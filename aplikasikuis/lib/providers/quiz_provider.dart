import 'package:flutter/foundation.dart';
import '../models/question_model.dart';
import '../data/dummy_questions.dart';

class QuizProvider with ChangeNotifier {
  final List<Question> _questions = dummyQuestions;
  int _currentIndex = 0;
  int _score = 0;
  final Map<int, int> _selectedAnswers = {}; // Menyimpan jawaban: key = index soal, value = pilihan jawaban
  bool _isFinished = false;

  // Getter untuk mengakses data dari UI
  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  Map<int, int> get selectedAnswers => _selectedAnswers;
  bool get isFinished => _isFinished;

  // Fungsi saat pengguna memilih jawaban
  void selectAnswer(int questionIndex, int optionIndex) {
    _selectedAnswers[questionIndex] = optionIndex;
    notifyListeners();
  }

  // Pindah ke soal berikutnya atau selesaikan kuis
  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    } else {
      _isFinished = true;
      calculateScore();
      notifyListeners();
    }
  }

  // Pindah ke soal sebelumnya
  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Menghitung total skor akhir
  void calculateScore() {
    _score = 0;
    _selectedAnswers.forEach((questionIndex, selectedOption) {
      if (_questions[questionIndex].correctOptionIndex == selectedOption) {
        _score += 20; // Asumsi 5 soal, masing-masing bobot 20 poin (total 100)
      }
    });
  }

  // Reset kuis untuk mengulang dari awal
  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _selectedAnswers.clear();
    _isFinished = false;
    notifyListeners();
  }
}