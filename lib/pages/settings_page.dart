import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/drawer_model.dart';
import 'package:notelist_v3/models/drop_down_menu_model.dart';
import 'package:notelist_v3/models/toggle_switch_model.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:notelist_v3/pages/otp_verification.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

  void openDrawer() {

    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDatabase>(
        builder:(context, value, child) => Scaffold(
          key: _scaffoldKey,
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5,top: 25,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: IconButton(
                                onPressed: openDrawer,
                                icon:  Icon(Icons.menu,
                                  color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Text("Settings",
                              style: TextStyle(
                                  color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                                  fontSize: 45,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right:10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 35,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon:  Icon(Icons.more_vert,
                                      color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                                    ),
                                    onPressed: () => {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [

                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          drawer: DrawerModel()
        ),
    );
  }
}
