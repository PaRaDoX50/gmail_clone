import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoBox extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;

  InfoBox({this.from, this.to, this.date});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMEd().format(date).toString();
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                    width: 56,
                    child: Text(
                      "From",
                      style: Theme.of(context).textTheme.subtitle,
                    )),
                SizedBox(width: 5),
                Expanded(child: Text(from))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                    width: 56,
                    child: Text(
                      "To",
                      style: Theme.of(context).textTheme.subtitle,
                    )),
                SizedBox(width: 5),
                Expanded(
                  child: Text(to),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                    width: 56,
                    child: Text(
                      "Date",
                      style: Theme.of(context).textTheme.subtitle,
                    )),
                SizedBox(width: 5),
                Expanded(child: Text(formattedDate))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                    width: 56,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.grey[500],
                        ))),
                SizedBox(width: 5),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Security Encryption (TLS)."),
                    Text(
                      "See security details",
                      style: TextStyle(color: Colors.blue[700]),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
