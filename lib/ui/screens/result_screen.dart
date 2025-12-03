import 'package:flutter/material.dart';
import '../../data/models/quiz.dart';
import '../widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<String?> userAnswers;
  final VoidCallback onRestart;

  const ResultScreen({
    Key? key,
    required this.questions,
    required this.userAnswers,
    required this.onRestart,
  }) : super(key: key);

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswer) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final score = _calculateScore();
    final percentage = ((score / questions.length) * 100).toStringAsFixed(1);

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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Text(
                          '$score/${questions.length}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Results:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...questions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final question = entry.value;
                    final isCorrect = userAnswers[index] == question.correctAnswer;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? Colors.green.withOpacity(0.3)
                              : Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ${question.question}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Your answer: ${userAnswers[index] ?? "Not answered"}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                            if (!isCorrect)
                              Text(
                                'Correct: ${question.correctAnswer}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.greenAccent,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Restart Quiz',
                    onTap: onRestart,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
