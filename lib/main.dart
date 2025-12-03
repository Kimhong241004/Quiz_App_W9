import 'package:flutter/material.dart';
import 'data/models/quiz.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/question_screen.dart';
import 'ui/screens/result_screen.dart';
import 'ui/screens/history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const QuizAppHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizAppHome extends StatefulWidget {
  const QuizAppHome({super.key});

  @override
  State<QuizAppHome> createState() => _QuizAppHomeState();
}

class _QuizAppHomeState extends State<QuizAppHome> {
  late List<Question> questions;
  late List<String?> userAnswers;
  int currentScreen = 0; // 0: Welcome, 1: Question, 2: Result, 3: History

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  void _initializeQuiz() {
    questions = Quiz.fromJson(mockQuizData).questions;
    userAnswers = List<String?>.filled(questions.length, null);
  }

  void _startQuiz() {
    setState(() {
      _initializeQuiz();
      currentScreen = 1;
    });
  }

  void _finishQuiz() {
    setState(() {
      currentScreen = 2;
    });
  }

  void _restartQuiz() {
    setState(() {
      currentScreen = 0;
    });
  }

  void _goToHistory() {
    setState(() {
      currentScreen = 3;
    });
  }

  void _backFromHistory() {
    setState(() {
      currentScreen = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case 0:
        return WelcomeScreen(onStart: _startQuiz);
      case 1:
        return QuestionScreen(
          questions: questions,
          onFinished: _finishQuiz,
        );
      case 2:
        return ResultScreen(
          questions: questions,
          userAnswers: userAnswers,
          onRestart: _restartQuiz,
        );
      case 3:
        return HistoryScreen(onBack: _backFromHistory);
      default:
        return WelcomeScreen(onStart: _startQuiz);
    }
  }
}
