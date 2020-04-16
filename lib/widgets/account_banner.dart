import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/utils/ServerAddress.dart';

class AccountBanner extends StatelessWidget {
  final String profilePhoto;
  final Function onPressed;
  const AccountBanner(
      {Key key, @required this.profilePhoto, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kLightColor, width: 0.8),
          color: Colors.black12.withAlpha(20),
          borderRadius: BorderRadius.circular(4.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: profilePhoto != null
                    ? NetworkImage(
                        ServerAddress.getUrl(path: profilePhoto),
                      )
                    : AssetImage('images/person.png'),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text('Có gì mới?'),
            ],
          ),
        ),
      ),
    );
  }
}
