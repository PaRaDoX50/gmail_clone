import 'package:flutter/material.dart';
import 'package:gmailclone/screens/new_mail.dart';
import 'package:gmailclone/widgets/mail_list.dart';
import 'package:gmailclone/widgets/multi_touch_disabler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
//    AppBar(backgroundColor: Colors.white,title: TextField(decoration: InputDecoration(labelText: "Search"),),
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnlyOnePointerRecognizerWidget(child: MailList()),
      //copied the Onlyonepoi..... from the internet.It disables multi touches. Did it so that the swipe to delete does not misbehaves.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          child: Icon(Icons.add,color: Colors.grey[700],size: 35,),
          onPressed: () => Navigator.of(context).pushNamed(NewMail.route)),
    );
  }
}
