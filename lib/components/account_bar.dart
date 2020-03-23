import 'package:flutter/material.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/utils/ServerAddress.dart';

class AccountBar extends StatelessWidget {
  final Account account;
  final Widget subTitle;
  final bool isThreeLine;

  AccountBar(
      {@required this.account,
      @required this.subTitle,
      this.isThreeLine = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      leading: account.profilePhoto != null
          ? Container(
              height: 50.0,
              width: 50.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  ServerAddress.getUrl(path: account.profilePhoto),
                ),
                backgroundColor: Colors.red,
              ),
            )
          : Container(
              height: 50.0,
              width: 50.0,
              child: CircleAvatar(
                backgroundImage: AssetImage('images/person.png'),
                backgroundColor: Colors.red,
              ),
            ),
      title: Text(
        account.username,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: subTitle,
      isThreeLine: isThreeLine,
    );
  }
}
//MyNetworkImage.fromPath(
//                  path: account.profilePhoto, height: double.infinity)
