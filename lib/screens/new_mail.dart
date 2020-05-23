import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mail.dart';
import 'package:gmailclone/providers/mails_provider.dart';
import 'package:provider/provider.dart';

class NewMail extends StatelessWidget {
  static String route = "/new_mail";
  TextEditingController toController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void sendMail(Mails data, BuildContext ctx) {
    if (toController.text.isEmpty && fromController.text.isEmpty) {
      showDialog(
          context: ctx,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                "Add recipent and sender",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(ctx),
                )
              ],
            );
          });
    } else if (fromController.text.isEmpty) {
      showDialog(
          context: ctx,
          builder: (_) {
            return AlertDialog(
              title: Text(
                "Add the sender",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(ctx),
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          });
    } else if (toController.text.isEmpty) {
      showDialog(
          context: ctx,
          builder: (_) {
            return AlertDialog(
              title: Text(
                "Add the recipent",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(ctx),
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          });
    } else {
      if (EmailValidator.validate(toController.text) &&
          EmailValidator.validate(fromController.text)) {
        data.addMailToDatabase(Mail(
            to: toController.text,
            from: fromController.text,
            description: descriptionController.text.isEmpty
                ? "(no body)"
                : descriptionController.text,
            subject: subjectController.text.isEmpty
                ? "(no subject)"
                : subjectController.text,
            date: DateTime.now()));
        Navigator.pop(ctx);
      } else {
        showDialog(
            context: ctx,
            builder: (_) {
              return AlertDialog(
                title: Text(
                  "Please enter valid addresses",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () => Navigator.pop(ctx),
                  )
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Mails>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[600]),
        title: Text("Compose",style: TextStyle(color: Colors.grey[600]),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[

          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                sendMail(data, context);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 56, child: Text("From")),
                Expanded(
                  child: TextField(
                    controller: fromController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
//            SizedBox(
//              height: 40,
//              child: TextField(
//                controller: toController,
//                decoration: InputDecoration(
//                  border: InputBorder.none,
//                  prefixIcon: Padding(
//                    padding: const EdgeInsets.only(
//                      right: 8.0,
//                    ),
//                    child: SizedBox(
//                        height: 20,
//                        width: 48,
//                        child: Align(
//                            alignment: Alignment.centerLeft,
//                            child: Text(
//                              "To",
//                              style: TextStyle(fontSize: 16),
//                            ))),
//                  ),
//                ),
//              ),
//            ),
            Row(
              children: <Widget>[
                SizedBox(width: 56, child: Text("To")),
                Expanded(
                  child: TextField(
                    controller: toController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              child: TextField(
                controller: subjectController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Subject"),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: TextField(
                controller: descriptionController,
                style: TextStyle(fontSize: 18),
                maxLines: 100,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Compose a mail"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
