import 'package:flutter/material.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/screens/profile_page.dart';
import 'package:shrimpapp/utils/ServerAddress.dart';

class AccountBar extends StatelessWidget {
  final Account account;
  final Widget subTitle;
  final bool isThreeLine;
  final double height;
  final double width;
  final bool disableGesture;

  AccountBar(
      {@required this.account,
      @required this.subTitle,
      this.isThreeLine = true,
      this.height = 50,
      this.width = 50,
      this.disableGesture = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      leading: account.profilePhoto != null
          ? GestureDetector(
              onTap: () {
                if (!disableGesture)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountInfo(account),
                    ),
                  );
              },
              child: Container(
                height: height,
                width: width,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    ServerAddress.getUrl(path: account.profilePhoto),
                  ),
                  backgroundColor: Colors.red,
                ),
              ),
            )
          : Container(
              height: height,
              width: width,
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
