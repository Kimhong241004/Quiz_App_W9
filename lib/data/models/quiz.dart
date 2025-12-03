class Question {
  final String id;
  final String question;
  final List<String> choices;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      question: json['question'] as String,
      choices: List<String>.from(json['choices'] as List),
      correctAnswer: json['correctAnswer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices,
      'correctAnswer': correctAnswer,
    };
  }
}

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  factory Quiz.fromJson(List<dynamic> json) {
    return Quiz(
      questions: (json).map((q) => Question.fromJson(q as Map<String, dynamic>)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return questions.map((q) => q.toJson()).toList();
  }
}

// Mock quiz data
final mockQuizData = [
  {
    'id': '1',
    'question': 'Who is the best teacher?',
    'choices': ['Ronan', 'Hondly', 'Leangsiv'],
    'correctAnswer': 'Ronan',
  },
  {
    'id': '2',
    'question': 'What is the best color?',
    'choices': ['Blue', 'Red', 'Green'],
    'correctAnswer': 'Blue',
  },
];
