import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mail.dart';
import 'package:gmailclone/providers/mails_provider.dart';
import 'package:gmailclone/widgets/info_box.dart';
import 'package:provider/provider.dart';

class MailDescription extends StatefulWidget {
  static String route = "/mail_description";

//  Mail mail;
//  int index;

  @override
  _MailDescriptionState createState() => _MailDescriptionState();
}

class _MailDescriptionState extends State<MailDescription> {
  bool showInfoBox = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggleInfoBox() {
    setState(() {
      showInfoBox = !showInfoBox;
    });
  }

//  void changeFavourite() {
//
//    setState(() {
//      widget.mail.isFavourite = !widget.mail.isFavourite;
//    });
//  }
  void deleteMail(Mails data, Mail mail, BuildContext ctx) async {
    await data.deleteMailWithDate(mail.date.toIso8601String());
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Mails>(context, listen: false);
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
//    widget.index = data["index"];
//    widget.mail = Provider.of<Mails>(context).mails[widget.index];
    final mail = data["mail"] as Mail;
    final toName = mail.to.split("@")[0];
    final fromName = mail.from.split("@")[0];
    final subject = mail.subject;
    final description = mail.description;

    final from = mail.from;
    final to = mail.to;
    print(mail.isFavourite.toString() + "descrip");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteMail(providerData, mail, context);
            },
          ),
          IconButton(
            icon: Icon(Icons.mail_outline),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      subject,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.values[4]),
                    ),
                  ),
                  IconButton(
                    icon: mail.isFavourite
                        ? Icon(
                            Icons.star,
                            color: Colors.orange,
                          )
                        : Icon(Icons.star_border),
                    onPressed: () {
                      mail.changeFavourite();
                      setState(() {});
                    },
                  )
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.cyan,
                  child: Text(
                    to.substring(0, 1),
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                title: Text(fromName),
                subtitle: GestureDetector(
                  onTap: toggleInfoBox,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("to $toName"),
                      Icon(
                        Icons.expand_more,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  child: showInfoBox
                      ? InfoBox(
                          to: to,
                          from: from,
                          date: mail.date,
                        )
                      : null),
              Container(
                child: Text(description),
                margin: EdgeInsets.only(top: 8),
              )
            ],
          ),
        ),
      ),
    );
  }
}
