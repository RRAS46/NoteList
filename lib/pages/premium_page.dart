import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/carousel_model.dart';
import 'package:notelist_v3/models/drawer_model.dart';
import 'package:notelist_v3/models/drop_down_menu_model.dart';
import 'package:notelist_v3/models/toggle_switch_model.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:notelist_v3/pages/otp_verification.dart';
import 'package:provider/provider.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  final GlobalKey<ScaffoldState> _premiumscaffoldKey = GlobalKey<ScaffoldState>();
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);
  late PremiumCustomCarousel premiumCarousel;

  void openDrawer() {

    _premiumscaffoldKey.currentState?.openDrawer();
  }

  /*
  List premiumCarouselList(int length){
    List temp;
    for(int i=0;i<length;i++){

    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDatabase>(
      builder:(context, value, child) => Scaffold(
        key: _premiumscaffoldKey,
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
                          child: Text("Premium",
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
                      PremiumCustomCarousel(height: 300, itemList: [1,2,3,4,5,6,7])
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        drawer: DrawerModel(),
      ),
    );
  }
}
