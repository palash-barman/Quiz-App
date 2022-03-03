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
                    padding: EdgeInsets.all(5),
                    child: Text("Total Questions : ${_quetionIndex+1} /${_questions.length}",
                    style: TextStyle(fontSize: 25,color: Colors.pink,fontWeight: FontWeight.bold),
                    )),
                
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

                                  ? Color(0xff78a064)
                               : Color(0xff354f90)
                               : Colors.black26,
                          answerText: answer['answerText'],
                          answerontab: () {

                            if (aanswerWasSelected) {
                              return;
                              // return;
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
                SizedBox(height: 15,),
                
                
                // Container(
                //   padding: EdgeInsets.all(20.0),
                //   child: Text(
                //     '${_totalScore}/${_questions.length}',
                //     style: TextStyle(
                //         color: Color(0xff051db4),
                //         fontSize: 40.0,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                
                
                if (aanswerWasSelected && !endofQuiz)
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: curentSelected ? Colors.black26 : Colors.black12,
                    child: Center(
                      child: Text(
                        curentSelected
                            ? 'Well done, you got it right!'
                            : ' Answer Wrong ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color:curentSelected? Color(0xff35a107):Color(
                              0xffc70b0b),
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
    'question': 'কম্পিউটার মানুষের ভাষা কীভাবে বুঝতে পারে?',
    'answers': [
      {'answerText': 'সরাসরি বুঝতে পারে', 'score': false},
      {'answerText': 'আংশিক বুঝতে পারে', 'score': false},
      {'answerText': 'যান্ত্রিক ভাষায় রুপান্তরিত হলে বুঝতে পারে', 'score': true},
    ],
  },
  {
    'question':
        'প্রোগ্রামের ভিত্তি কোনটি ?',
    'answers': [
      {'answerText': 'সুডোকোড', 'score': false},
      {'answerText': 'ডিবাগিং', 'score': false},
      {'answerText': 'কোডিং', 'score': true},
    ],
  },
  {
    'question': 'কম্পিউটার প্রোগ্রামিং ভাষাকে কয়টি ভাগে ভাগ করা হয়?',
    'answers': [
      {'answerText': ' ২ ভাগে', 'score': false},
      {'answerText': '৪ ভাগে', 'score': false},
      {'answerText': ' ৫ ভাগে ', 'score': true},
    ],
  },
  {
    'question': 'দ্বিতীয় প্রজন্মের ভাষা কোনটি?',
    'answers': [
      {'answerText': 'যান্ত্রিক ভাষা', 'score': false},
      {'answerText': 'অ্যাসেম্বলি ভাষা', 'score': true},
      {'answerText': 'নিম্নস্তরের ভাষা ', 'score': false},
    ],
  },
  {
    'question':
        'কিউবেসিক উদ্ভাবন করেছেন কে?',
    'answers': [
      {'answerText': 'মাইক্রোসপট ', 'score': true},
      {'answerText': 'অ্যাপেল ', 'score': false},
      {'answerText': 'আই বি এম', 'score': false},
    ],
  },
  {
    'question': 'কোনটি মধ্যস্তরের ভাষা??',
    'answers': [
      {'answerText': 'ওরাকল ', 'score': true},
      {'answerText': 'তৃতীয় প্রজন্মের', 'score': false},
      {'answerText': 'প্রথম প্রজন্ম', 'score': false},
    ],
  },
  {
    'question': 'C প্রোগ্রাম তৈরির সাথে কে জড়িত?',
    'answers': [
      {'answerText': ' ডেনিস রিচ', 'score': true},
      {'answerText': 'টিম বার্নসলি ', 'score': false},
      {'answerText': 'ডগলাস রিচ', 'score': false},
    ],
  },
  {
    'question': 'Python প্রোগ্রাম তৈরি করেণ কে?',
    'answers': [
      {'answerText': 'Martin Cooper', 'score': false},
      {'answerText': 'Dennis Ritchie ', 'score': false},
      {'answerText': 'Guido Van Rossum ', 'score': true},
    ],
  },
  {
    'question': 'প্রোগ্রামের ভুলকে কী বলে?',
    'answers': [
      {'answerText': 'Dagg', 'score': false},
      {'answerText': 'Debugging', 'score': false},
      {'answerText': 'Bug', 'score': true},
    ],
  },
  {
    'question': 'পঅবজেক্ট ওরিয়েন্টেড প্রোগ্রামিং এর বৈশিষ্ট কয়টি?',
    'answers': [
      {'answerText': '৪টি', 'score': false},
      {'answerText': '২টি', 'score': false},
      {'answerText': '৩টি ', 'score': true},
    ],
  },
];
