import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mail.dart';
import 'package:gmailclone/providers/mails_provider.dart';
import 'package:gmailclone/utils/colors_avatar.dart';
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
  int buildTrack = 0;
  bool isFavourite;

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

    final mail = data["mail"] as Mail;
    final toName = mail.to.split("@")[0];
    final fromName = mail.from.split("@")[0];
    final subject = mail.subject;
    final description = mail.description;
    final firstLetter = mail.to.substring(0,1);
    if(buildTrack==0) {
      isFavourite = mail.isFavourite;
      buildTrack++;
    }




    final from = mail.from;
    final to = mail.to;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[700]),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon:const Icon(Icons.delete),
            onPressed: () {
              deleteMail(providerData, mail, context);
            },
          ),
          IconButton(
            icon:const Icon(Icons.mail_outline),
            onPressed: () {

            },
          ),
          IconButton(
            icon:const Icon(Icons.more_vert),
            onPressed: () {

            },
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
                      style:  TextStyle(
                          fontSize: 20, fontWeight: FontWeight.values[4]),
                    ),
                  ),
                  IconButton(
                    icon: isFavourite
                        ? const Icon(
                            Icons.star,
                            color: Colors.orange,
                          )
                        : const Icon(Icons.star_border),
                    onPressed: () async {
                      await mail.changeFavourite();
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                    },
                  )
                ],
              ),
              ListTile(
                contentPadding:const EdgeInsets.only(left: 0),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:AvatarColors().getColorForChar(firstLetter.toLowerCase()) ,
                  child: Text(
                    firstLetter.toUpperCase(),
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                title: Text(fromName,overflow: TextOverflow.ellipsis,),
                subtitle: GestureDetector(
                  onTap: toggleInfoBox,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text("to "),
                      Flexible(child: Text("$toName",overflow: TextOverflow.ellipsis,)),
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
                margin: const EdgeInsets.only(top: 8),
              )
            ],
          ),
        ),
      ),
    );
  }
}
