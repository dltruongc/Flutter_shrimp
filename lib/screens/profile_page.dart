import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/utils/FetchImage.dart';
import '../models/Role.dart';
import '../models/Account.dart';

class AccountInfo extends StatelessWidget {
  final Account account;

  AccountInfo(this.account);

  _retailerBuilder(Account account) {
    return Column(
      children: <Widget>[
        // website
        buildListTile('Website', FontAwesomeIcons.internetExplorer,
            account.retailer.retailerWebsite),
        // email
        buildListTile(
          'Email',
          Icons.email,
          account.retailer.retailerEmail,
        ),
        // city
      ],
    );
  }

  _researcherBuilder(Account account) {
    return Column(
      children: <Widget>[
        // website
        buildListTile(
          'Chuyên môn',
          FontAwesomeIcons.briefcase,
          account.researcher.researcherSpecialized,
        ),
        // email
        buildListTile(
          'Viện nghiên cứu',
          FontAwesomeIcons.school,
          account.researcher.researcherOrganization,
        ),
        // city
      ],
    );
  }

  ListTile buildListTile(String title, IconData icon, String subtitle) {
    return ListTile(
      title: Text(
        title ?? '',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text((subtitle) ?? ''),
      leading: Icon(
        icon,
        color: Colors.blue[500],
        size: 30.0,
      ),
    );
  }

  Widget _coverImageBuild(String image) {
    return image == null
        ? Image.asset(
            'images/weather_wall.png',
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.topCenter,
          )
        : MyNetworkImage.fromPath(path: image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kLightColor,
        title: Text('Thông tin cá nhân'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 2 / 5,
              width: MediaQuery.of(context).size.width,
              // Cover image
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                ),
                child: _coverImageBuild(account.coverPhoto),
              ),
            ),
            Column(
              children: <Widget>[
                // Overlay cover image
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 7),
                // Account info
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: AccountBar(
                    account: account,
                    height: 60.0,
                    width: 60.0,
                    disableGesture: true,
                    subTitle: Text(toVietnam(account.role.type)),
                    isThreeLine: false,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                // Account detail
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.3,
                        child: Container(
                          color: Color(0x66666666),
                        ),
                      ),
                      buildListTile(
                        'Số điện thoại',
                        Icons.phone,
                        account.phone,
                      ),
                      buildListTile(
                          'Địa chỉ', Icons.location_on, account.address),
                      buildListTile('Ngày đăng ký', Icons.calendar_today,
                          account.createdAt.toString()),
                      account.role.type == RoleTypes.farmer
                          ? buildListTile('Câu chuyện nông dân',
                              Icons.library_books, account.story)
                          : SizedBox(),
                      account.role.type == RoleTypes.retailer
                          ? _retailerBuilder(account)
                          : SizedBox(),
                      account.role.type == RoleTypes.researcher
                          ? _researcherBuilder(account)
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
