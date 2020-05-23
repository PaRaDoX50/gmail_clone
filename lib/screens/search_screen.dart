import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mail.dart';
import 'package:gmailclone/providers/mails_provider.dart';

import 'package:gmailclone/widgets/appBar_search_screen.dart';
import 'package:gmailclone/widgets/mail_tile.dart';
import 'package:gmailclone/widgets/multi_touch_disabler.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static final route = "/search_screen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Mail>> desiredMails;

  Future<List<Mail>> changeDesiredMails(Mails data, String keyword) async {
    String key = keyword.toLowerCase();

    final allMails = await data.getAllMails();
    return allMails.where((e) {
      return e.to.toLowerCase().contains(key) ||
          e.from.toLowerCase().contains(key) ||
          e.description.toLowerCase().contains(key) ||
          e.subject.toLowerCase().contains(key);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Mails>(context, listen: false);

    String keyword = ModalRoute.of(context).settings.arguments as String;
    desiredMails = changeDesiredMails(data, keyword);

//    final allMails = await data.mails;
//    final int count = allMails.length;
    return OnlyOnePointerRecognizerWidget(
      child: FutureBuilder<List<Mail>>(
          future: desiredMails,
          builder: (context, AsyncSnapshot<List<Mail>> snapshot) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: AppBarSearchScreen(context),
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
                        "Search Results",
                        style: TextStyle(color: Colors.grey[600]),
                      )),
                ),
                snapshot.hasData
                    ? (snapshot.data.isEmpty
                        ? SliverToBoxAdapter(
                            child: Center(
                                child: Image(
                            image: AssetImage("assets/images/no_result.png"),
                          )))
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, index) {
                                return ChangeNotifierProvider.value(
                                    value: snapshot.data[index],
                                    child: Dismissible(
                                      background: Container(
                                        color: Colors.red,
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
                          ))
                    : SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator())),
              ]),
            );
          }),
    );
  }
}
