import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class HistoryScreen extends StatelessWidget {
  final VoidCallback onBack;

  const HistoryScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: const Text(
                'Quiz History',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: const Text(
                  'No history yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: AppButton(
                label: 'Back',
                onTap: onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
