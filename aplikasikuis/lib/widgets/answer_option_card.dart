import 'package:flutter/material.dart';

class AnswerOptionCard extends StatelessWidget {
  final int index;
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOptionCard({
    super.key,
    required this.index,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  // Warna badge A, B, C, D
  static const List<Color> _badgeColors = [
    Color(0xFF3342CC), // A: Biru
    Color(0xFFFF6B6B), // B: Merah
    Color(0xFF2EC4B6), // C: Hijau Toska
    Color(0xFFFFB703), // D: Kuning
  ];

  static const List<String> _optionLetters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final badgeColor = _badgeColors[index % _badgeColors.length];
    final letter = index < _optionLetters.length ? _optionLetters[index] : '${index + 1}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3342CC).withOpacity(0.08) : Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFF3342CC) : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.035,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: onTap,
        leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              letter,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        title: Text(
          optionText,
          style: TextStyle(
            fontSize: screenSize.width * 0.038,
            color: isSelected ? const Color(0xFF3342CC) : const Color(0xFF2D3748),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? const Color(0xFF3342CC) : Colors.grey.shade400,
          size: 22,
        ),
      ),
    );
  }
}