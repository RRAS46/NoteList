import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/drop_down_menu_model.dart';
import 'package:notelist_v3/models/premium_button_model.dart';
import 'package:notelist_v3/models/toggle_switch_model.dart';
import 'package:notelist_v3/pages/home_page.dart';
import 'package:notelist_v3/pages/lock_screen.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:notelist_v3/pages/otp_verification.dart';
import 'package:notelist_v3/pages/premium_page.dart';
import 'package:notelist_v3/pages/settings_page.dart';
import 'package:provider/provider.dart';

class DrawerModel extends StatefulWidget {
  const DrawerModel({super.key});

  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: noteDatabase.allColors[noteDatabase.themeColor][2][0]['background'],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Container(
                child: Center(
                    child: IconButton(
                      icon: Image.asset('assets/RRAS.png'),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumButton(),));
                      },
                    )
                ),
              )
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: noteDatabase.allColors[noteDatabase.themeColor][2][2]['secondary'],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home,
                    color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                  ),
                  title:  Text(
                    'Home',
                    style: TextStyle(
                        color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface']
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  },
                ),

                ExpansionTile(
                  leading: Icon(Icons.list,
                    color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                  ),
                  collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                  collapsedIconColor: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                  iconColor:noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],


                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),)
                  ),
                  title: Text("All Notes",
                    style: TextStyle(
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                    ),
                  ),
                  children: [
                    MenuItems()
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                ListTile(
                    leading: Icon(noteDatabase.allColors[noteDatabase.themeColor][1],
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(noteDatabase.allColors[noteDatabase.themeColor][0],
                          style: TextStyle(
                              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface']
                          ),
                        ),
                        CustomToggleSwitch(boxHeight: 40,boxWidth: 70,buttonHeight: 30,buttonWidth: 30,),
                      ],
                    )
                ),
              ],
            ),
          ),
          ListTile(
            title: PremiumButton(),
            onTap: () async{
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: noteDatabase.allColors[noteDatabase.themeColor][2][2]['secondary'],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [

                ListTile(
                  leading: Icon(Icons.settings,
                    color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                  ),
                  title: Text("Settings",
                    style: TextStyle(
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                    ),
                  ),
                  onTap: () async{
                    // Handle item 1 tap
                    await Navigator.push (
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  SettingsPage(),
                      ),
                    );// Add your action when Item 1 is tapped
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.security,
                    color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                  ),
                  title:  Text('OTP Form',
                    style: TextStyle(
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                    ),
                  ),
                  onTap: () async{
                    // Handle item 1 tap
                    await Navigator.push (
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  OTPForm(),
                      ),
                    );// Add your action when Item 1 is tapped
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock,
                    color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                  ),
                  title: Text("Lock",
                    style: TextStyle(
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                    ),
                  ),
                  onTap: () async{
                    // Handle item 1 tap
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LockScreen()),
                          (route) => false, // This predicate makes sure to remove all previous routes
                    );
                  },
                ),
                ListTile(
                    leading: Icon(Icons.logout,
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                    ),
                    title:  Text(
                      'Logout',
                      style: TextStyle(
                          color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface']
                      ),
                    ),
                    onTap: () {}
                ),
              ],
            ),
          ),
          // Add more ListTiles for additional drawer items
        ],
      ),
    );
  }
}

