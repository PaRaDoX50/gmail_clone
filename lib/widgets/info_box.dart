import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoBox extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;
  InfoBox({this.from,this.to,this.date});



  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMEd().format(date).toString();
    return Card(shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[300]),borderRadius: BorderRadius.circular(5)),

      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[SizedBox(width:56,child: Text("From",style: TextStyle(fontSize: 16),)),SizedBox(width:5),Text(from)],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[SizedBox(width:56,child: Text("To")),SizedBox(width:5),Text(to)],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[SizedBox(width:56,child: Text("Date")),SizedBox(width:5),Text(formattedDate)],
            )
          ],
        ),
      ),
    );
  }
}
