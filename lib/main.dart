import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mails_provider.dart';
import 'package:gmailclone/screens/home.dart';
import 'package:gmailclone/screens/mail_description.dart';
import 'package:gmailclone/screens/new_mail.dart';
import 'package:gmailclone/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Mails(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: {
          NewMail.route: (_) => NewMail(),
          MailDescription.route: (_) => MailDescription(),
          SearchScreen.route: (_) => SearchScreen()
        },
      ),
    );
  }
}
