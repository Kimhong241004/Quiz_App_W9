import 'package:flutter/material.dart';
import '../../data/models/quiz.dart';
import '../widgets/answer_card.dart';
import '../widgets/app_button.dart';

class QuestionScreen extends StatefulWidget {
  final List<Question> questions;
  final VoidCallback onFinished;

  const QuestionScreen({
    Key? key,
    required this.questions,
    required this.onFinished,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  late List<String?> userAnswers;

  @override
  void initState() {
    super.initState();
    userAnswers = List<String?>.filled(widget.questions.length, null);
  }

  void _onAnswerSelected(String answer) {
    setState(() {
      userAnswers[currentQuestionIndex] = answer;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      widget.onFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];
    final isAnswered = userAnswers[currentQuestionIndex] != null;

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
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${currentQuestionIndex + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...question.choices.map((choice) {
                        final isSelected =
                            userAnswers[currentQuestionIndex] == choice;
                        return AnswerCard(
                          answer: choice,
                          isSelected: isSelected,
                          isCorrect: choice == question.correctAnswer,
                          onTap: () => _onAnswerSelected(choice),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: AppButton(
                label: currentQuestionIndex == widget.questions.length - 1
                    ? 'Finish'
                    : 'Next',
                onTap: isAnswered ? _nextQuestion : () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
