import 'package:flutter/material.dart';

class InspirationCard extends StatelessWidget {
  final String message;
  final String? imagePath;

  const InspirationCard({super.key, required this.message, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            flex: 2,
            child: imagePath != null
                ? Image.asset(
                    imagePath!,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.auto_awesome_rounded,
                        size: 80,
                        color: Colors.grey.shade400,
                      );
                    },
                  )
                : Icon(
                    Icons.auto_awesome_rounded,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
          ),
        ],
      ),
    );
  }
}
