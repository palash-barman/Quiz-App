import 'package:flutter/material.dart';
import 'package:quiz_app/pages/answer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> _scoreTrackar = [];
  int _quetionIndex = 0;
  int _totalScore = 0;
  bool aanswerWasSelected = false;
  bool endofQuiz = false;
  bool curentSelected = false;

  void questionAnswerd(bool answerScore) {
    setState(() {
      // answerwasselected
      aanswerWasSelected = true;
      // total score
      if (answerScore) {
        _totalScore++;
        curentSelected = true;
      }
      // score trackar
      _scoreTrackar.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      // when the quiz ends
      if (_quetionIndex + 1 == _questions.length) {
        endofQuiz = true;
      }
    });
  }

  void naxtQuestion() {
    setState(() {
      _quetionIndex++;
      aanswerWasSelected = false;
      curentSelected = false;
    });
    if (_quetionIndex >= _questions.length) {
      _restQuiz();
    }
  }

  void _restQuiz() {
    setState(() {
      _quetionIndex = 0;
      _scoreTrackar = [];
      _totalScore = 0;
      endofQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffa088af),
      appBar: AppBar(
        title: Text(
          "Quiz App",
          style: TextStyle(
              fontSize: 30,
              color: Color(0xfffaf406),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    if (_scoreTrackar.length == 0)
                      SizedBox(
                        height: 25.0,
                      ),
                    if (_scoreTrackar.length > 0) ..._scoreTrackar
                  ],
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff07d2ba),
                  ),
                  child: Center(
                    child: Text(
                      _questions[_quetionIndex]["question"],
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                ...(_questions[_quetionIndex]['answers']
                        as List<Map<String, dynamic>>)
                    .map((answer) => Answer(
                          answercolor: aanswerWasSelected
                              ? answer['score']
                                  ? Colors.green
                                  : Colors.red
                              : Colors.black12,
                          answerText: answer['answerText'],
                          answerontab: () {
                            if (aanswerWasSelected) {
                              return;
                            }
                            questionAnswerd(answer['score']);
                          },
                        )),
                Container(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!aanswerWasSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Please select an answer before going to the next question')));
                        return;
                      }

                      naxtQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(double.infinity, 60.0),
                    ),
                    child: Text(
                      endofQuiz ? 'Resterd Quiz' : 'Next Quiz',
                      style: TextStyle(fontSize: 30, color: Color(0xffc208f6)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '${_totalScore}/${_questions.length}',
                    style: TextStyle(
                        color: Color(0xff051db4),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (aanswerWasSelected && !endofQuiz)
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: curentSelected ? Colors.green : Colors.red,
                    child: Center(
                      child: Text(
                        curentSelected
                            ? 'Well done, you got it right!'
                            : ' Answer Wrong ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (endofQuiz)
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Color(0xff9bf382),
                    child: Center(
                      child: Text(
                        _totalScore > 4
                            ? 'Congratulations! Your final score is: $_totalScore'
                            : 'Your final score is: $_totalScore. Better luck next time!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: _totalScore > 4 ? Colors.green : Colors.red),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _questions = [
  {
    'question': 'How long is New Zealand’s Ninety Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
  },
  {
    'question': 'Who composed the music for Sonic the Hedgehog 3?',
    'answers': [
      {'answerText': 'Britney Spears', 'score': false},
      {'answerText': 'Timbaland', 'score': false},
      {'answerText': 'Michael Jackson', 'score': true},
    ],
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'Fried chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
  {
    'question':
        'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
    'answers': [
      {'answerText': 'His tongue', 'score': true},
      {'answerText': 'His leg', 'score': false},
      {'answerText': 'His butt', 'score': false},
    ],
  },
  {
    'question': 'In which country are Panama hats made?',
    'answers': [
      {'answerText': 'Ecuador', 'score': true},
      {'answerText': 'Panama (duh)', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
  },
];
