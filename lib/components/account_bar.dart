import 'package:flutter/material.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/utils/FetchImage.dart';

class AccountBar extends StatelessWidget {
  final Account account;
  final Widget subTitle;

  AccountBar({@required this.account, @required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: account.profilePhoto != null
          ? MyNetworkImage.fromPath(
              path: account.profilePhoto, height: double.infinity)
          : Image.asset('images/person.png'),
      title: Text(account.username),
      subtitle: subTitle,
      isThreeLine: true,
    );
  }
}
