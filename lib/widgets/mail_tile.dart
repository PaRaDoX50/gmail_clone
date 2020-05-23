import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmailclone/providers/mail.dart';

import 'package:gmailclone/screens/mail_description.dart';
import 'package:gmailclone/utils/colors_avatar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class MailTile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final mail = Provider.of<Mail>(context,listen: false);
    final toName = mail.to.split("@")[0];



    final firstLetter = mail.to.substring(0, 1);
    final formattedDate = DateFormat.MMMd().format(mail.date).toString();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(onTap: ()=> Navigator.of(context).pushNamed(MailDescription.route,arguments: {"mail":mail}),
        child: Container(
          child: ListTile(
            leading: Column(
              children: <Widget>[
                CircleAvatar(
                  child: Text(
                    firstLetter.toUpperCase(),
                    style: TextStyle(color: Colors.white,fontSize: 25),
                  ),
                  backgroundColor: AvatarColors().getColorForChar(firstLetter.toLowerCase()),
                  radius: 20,
                ),
              ],
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "To: ",
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 1,
                ),
                Expanded(
                  child: Text(
                    "$toName",
                    style: TextStyle(color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${mail.subject}",
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${mail.description}",
                  style: TextStyle(color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Text(
                    formattedDate,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Consumer<Mail>(
                      builder: (x,y,z){return IconButton(
                        padding: EdgeInsets.zero,
                        icon: mail.isFavourite
                            ? Icon(Icons.star,color: Colors.orange,)
                            : Icon(Icons.star_border),
                        onPressed: () =>mail.changeFavourite(),
                      );},
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
