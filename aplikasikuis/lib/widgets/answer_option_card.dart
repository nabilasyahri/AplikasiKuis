import 'package:flutter/material.dart';

class AnswerOptionCard extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOptionCard({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6C63FF).withOpacity(0.1) : Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          optionText,
          style: TextStyle(
            fontSize: 15,
            color: isSelected ? const Color(0xFF6C63FF) : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? const Color(0xFF6C63FF) : Colors.grey,
        ),
      ),
    );
  }
}