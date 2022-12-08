import 'package:flutter/material.dart';
import 'package:lux_global/ui/daily_task.dart';
import 'package:lux_global/ui/home.dart';
import 'package:lux_global/ui/kyc_upload.dart';
import 'package:lux_global/ui/login.dart';
import 'package:lux_global/ui/profile.dart';
import 'package:lux_global/ui/update_profile.dart';
import 'package:lux_global/ui/wallet.dart';
import 'package:lux_global/ui/web.dart';

import '../component/Icon_view.dart';
import '../component/label_text_field.dart';
import '../utility/app_color.dart';
import '../utility/globals.dart' as globals;

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  String _title = 'Statistics';
  int _menuIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _menuList = <Widget>[
    const Home(),
    const DailyTask(),
    const Profile(),
    const Wallet(),
    const KycUpload(),
    const UpdateProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _menuList.elementAt(_menuIndex),
      appBar: AppBar(
        title: LabelTextField(
          label: _title,
          textSize: 26.0,
          textColor: AppColor.primaryTextColor,
        ),
        backgroundColor: AppColor.primaryColor,
        leading: IconButton(
          icon: const IconView(
            icon: 'hamburger.png',
            height: 30,
            width: 30,
          ), //icon
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                ).then((value) => {
                      if (value == 1)
                        {
                          setState(() {
                            _menuIndex = 3;
                            _title = 'Wallet';
                          })
                        }
                      else if (value == 2)
                        {
                          setState(() {
                            _menuIndex = 4;
                            _title = 'KYC Upload';
                          })
                        }
                      else if (value == 3)
                        {
                          setState(() {
                            _menuIndex = 5;
                            _title = 'Update Profile';
                          })
                        },
                      Navigator.pop(context),
                    });
              },
              child: UserAccountsDrawerHeader(
                accountName: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(globals.profileModel?.userData?.username ?? '',
                        style: const TextStyle(fontFamily: 'Regular')),
                    const IconView(
                      height: 20,
                      width: 20,
                      icon: 'right_arrow.png',
                    ),
                  ],
                ),
                accountEmail: const Text(''),
                currentAccountPicture: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: AppColor.primaryTextColor, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(0),
                  child: Image.network(
                    'https://www.w3schools.com/howto/img_avatar.png',
                    fit: BoxFit.fill,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
            ListTile(
              title: LabelTextField(
                label: 'Home',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              onTap: () => {callBack('Statistics', 1)},
            ),
            ListTile(
              title: LabelTextField(
                label: 'Daily Activity/Task',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              onTap: () => {callBack('Daily Activity/Task', 2)},
            ),
            ListTile(
              title: LabelTextField(
                label: 'My Profile',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              onTap: () => {callBack('My Profile', 3)},
            ),
            ListTile(
              title: LabelTextField(
                label: 'Wallet',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              onTap: () => {callBack('Wallet', 4)},
            ),
            ListTile(
              title: LabelTextField(
                label: 'Contact Us',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              onTap: () => {callBack('Contact Us', 5)},
            ),
            ListTile(
              title: LabelTextField(
                label: 'General Query',
                textColor: AppColor.primaryDisable,
              ),
              onTap: () => {callBack('General Query', 6)},
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding: const EdgeInsets.only(left: 50.0),
            ),
            ListTile(
              title: LabelTextField(
                label: 'Generate New T-pin',
                textColor: AppColor.primaryDisable,
              ),
              onTap: () => {callBack('Generate New T-pin', 7)},
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding: const EdgeInsets.only(left: 50.0),
            ),
            ListTile(
              title: LabelTextField(
                label: 'Terms & Condition',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              onTap: () => {callBack('Terms & Condition', 8)},
            ),
            ListTile(
              title: LabelTextField(
                label: 'Log Out',
                textSize: 16.0,
                textColor: AppColor.secondaryTextColor,
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              onTap: () => {callBack('Log Out', 9)},
            ),
          ],
        ),
      ),
    );
  }

  void callBack(String title, int index) {
    setState(() {
      if (index != 3 && index != 5 && index != 8) {
        _title = title;
      }
      Navigator.pop(context);
      switch (index) {
        case 1:
          _menuIndex = 0;
          break;
        case 2:
          _menuIndex = 1;
          break;
        case 3:
          // _menuIndex = 2;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Profile()),
          ).then((value) => {
                if (value == 1)
                  {
                    setState(() {
                      _menuIndex = 3;
                      _title = 'Wallet';
                    })
                  }
                else if (value == 2)
                  {
                    setState(() {
                      _menuIndex = 4;
                      _title = 'KYC Upload';
                    })
                  }  else if (value == 3)
                    {
                      setState(() {
                        _menuIndex = 5;
                        _title = 'Update Profile';
                      })
                    },
              });
          break;
        case 4:
          _menuIndex = 3;
          break;


        /* case 5:
          _menuIndex = 4;
          break;
        case 6:
          _menuIndex = 5;
          break;
        case 7:
          _menuIndex = 6;
          break;

       */
        case 8:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Web(
                      endPoint: 'termsandconditions',
                    )),
          );
          break;
        case 9:
          // _menuIndex = 8;

          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const Login(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
          break;
      }
    });
  }
}
