import '../models/question_model.dart';

final List<Question> dummyQuestions = [
  Question(
    id: 'q1',
    questionText: 'Apa bahasa pemrograman utama yang digunakan untuk framework Flutter?',
    options: ['Java', 'Python', 'Dart', 'C++'],
    correctOptionIndex: 2,
  ),
  Question(
    id: 'q2',
    questionText: 'Widget apa yang digunakan untuk membuat tata letak vertikal di Flutter?',
    options: ['Row', 'Column', 'Stack', 'Container'],
    correctOptionIndex: 1,
  ),
  Question(
    id: 'q3',
    questionText: 'Manakah widget yang sifatnya tidak memiliki state internal yang berubah-ubah?',
    options: ['StatefulWidget', 'StatelessWidget', 'ChangeNotifier', 'State'],
    correctOptionIndex: 1,
  ),
  Question(
    id: 'q4',
    questionText: 'Apa fungsi utama dari pubspec.yaml dalam proyek Flutter?',
    options: [
      'Menulis kode logika UI',
      'Mengatur dependensi dan aset',
      'Mengompilasi aplikasi ke iOS',
      'Menjalankan database lokal'
    ],
    correctOptionIndex: 1,
  ),
  Question(
    id: 'q5',
    questionText: 'State management apa yang sering digunakan untuk memisahkan logika bisnis dari UI di Flutter?',
    options: ['Provider', 'Scaffold', 'MediaQuery', 'AppBar'],
    correctOptionIndex: 0,
  ),
];