import 'package:flutter/material.dart';
import 'package:gmailclone/screens/search_screen.dart';

class AppBarModified extends PreferredSize {
  final BuildContext contextMain;

  AppBarModified(this.contextMain);

  void search(String string, BuildContext ctx) {

    Navigator.of(ctx).pushNamed(SearchScreen.route, arguments: string);

  }

  @override
  Size get preferredSize => Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    double topMargin = MediaQuery.of(context).padding.top + 8;

    return Card(
      margin: EdgeInsets.only(top: topMargin, right: 16, left: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: LayoutBuilder(builder: (_, constraints) {
        return Row(
          children: <Widget>[
            SizedBox(
                width: constraints.maxWidth * .15,
                child: IconButton(icon: Icon(Icons.menu), onPressed: () {})),
            Container(
              width: constraints.maxWidth * .70,
              child: TextField(
                onSubmitted: (string) => search(string, contextMain),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search in emails",
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * .15,
              child: CircleAvatar(
                radius: 16,
                child: Text(
                  "S",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.deepOrange,
              ),
            )
          ],
        );
      }),
    );
  }
}
