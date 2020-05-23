import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mail.dart';

import 'package:gmailclone/providers/mails_provider.dart';
import 'package:gmailclone/widgets/appBar_modified.dart';
import 'package:gmailclone/widgets/mail_tile.dart';
import 'package:provider/provider.dart';

class MailList extends StatefulWidget {
  @override
  _MailListState createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Mails>(context);

    return FutureBuilder<List<Mail>>(
        future: data.getAllMails(),
        builder: (context, AsyncSnapshot<List<Mail>> snapshot) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: AppBarModified(context),
                bottom: PreferredSize(
                  // Add this code
                  preferredSize: Size.fromHeight(05.0), // Add this code
                  child: Text(''), // Add this code
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    margin: EdgeInsets.only(left: 16, bottom: 8, top: 16),
                    child: Text(
                      "Sent",
                      style: TextStyle(color: Colors.grey[600]),
                    )),
              ),
              snapshot.hasData
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          return ChangeNotifierProvider.value(
                              value: snapshot.data[index],
                              child: Dismissible(
                                background: Container(
                                  color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.red,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 0, 10.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.red,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 10, 10.0, 10),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                key: UniqueKey(),
                                child: MailTile(),
                                onDismissed: (_) {
                                  String date = snapshot.data[index].date
                                      .toIso8601String();
                                  snapshot.data.removeAt(index);
                                  data.deleteMailWithDate(date);
                                },
                              ));
                        },
                        childCount: snapshot.data.length,
                      ),
                    )
                  : SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator())),
            ],
          );
        });
  }
}
