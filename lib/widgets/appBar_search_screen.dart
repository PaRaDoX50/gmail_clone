import 'package:flutter/material.dart';
import 'package:gmailclone/screens/search_screen.dart';

class AppBarSearchScreen extends PreferredSize {
  final BuildContext contextMain;
  AppBarSearchScreen(this.contextMain);


  void search(String string){
    Navigator.of(contextMain).pushReplacementNamed(SearchScreen.route,arguments: string);

  }
  void onBackPressed(){
    Navigator.pop(contextMain);
  }

  @override
  Size get preferredSize => Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    double topMargin = MediaQuery.of(context).padding.top + 8;


    return Card(
      margin: EdgeInsets.only(top: topMargin,  right: 16, left: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: LayoutBuilder(builder: (_, constraints) {
        return Row(
          children: <Widget>[
            SizedBox(width: constraints.maxWidth * .15,child: IconButton(icon:Icon(Icons.arrow_back),onPressed: onBackPressed)),
            Container(
              width: constraints.maxWidth * .70,
              child: TextField(
                keyboardType: TextInputType.text,
                onSubmitted: (string)=>search(string) ,
                decoration: InputDecoration(border: InputBorder.none,
                  hintText: "Search in emails",


                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * .15,
              child: CircleAvatar(
                radius: 16,
                child: Text("S",style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.deepOrange,
              ),
            )
          ],
        );
      }),
    );
  }
}
