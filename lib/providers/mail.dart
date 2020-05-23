import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


import 'mails_provider.dart';

class Mail extends ChangeNotifier{
  final String to;
  final String from;
  final String subject;
  final String description;
  final DateTime date;
  bool isFavourite;



  Mail({@required this.to,@required this.from,@required this.subject,@required this.description,@required this.date,this.isFavourite = false});

  Future<bool> changeFavourite() async {

    Mails().updateMail(date, !isFavourite).then((_){isFavourite = !isFavourite;

    notifyListeners();
    return true;
    });
    return true;




  }
  factory Mail.fromMap(Map<String, dynamic> json) => new Mail(
    to: json["toto"],
    from: json["fromfrom"],
    subject: json["subject"],
    description: json["description"],
    isFavourite:  json["isFavourite"] == "true" ? true : false,
    date: DateTime.parse( json["datedate"] as String),
  );


  Map<String, dynamic> toMap() => {
    "toto": to,
    "fromfrom": from,
    "subject": subject,
    "description": description,
    "datedate": date.toIso8601String(),
    "isFavourite": isFavourite.toString(),
  };


}