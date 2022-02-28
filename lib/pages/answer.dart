import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answercolor;
  final Function()? answerontab;

  Answer({
    required this.answercolor,
    required this.answerText,
    this.answerontab,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:answerontab,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue),
          color: answercolor,
        ),
        child: Text(answerText,
          style: TextStyle(fontSize: 24,color: Color(0xff071dac)),
        ),
      ),
    );
  }
}
