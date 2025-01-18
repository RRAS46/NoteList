import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/carousel_model.dart';
import 'package:notelist_v3/models/drawer_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late NoteDatabase noteDatabase = Provider.of<NoteDatabase>(context, listen: false);

  @override
  void initState() {
    super.initState();
    noteDatabase.createInitialData();

    if (noteDatabase.noteBox.get(noteDatabase.noteBoxAllNoteValue) == null) {
      noteDatabase.createInitialData();
    } else {
      noteDatabase.loadData();
    }
    noteDatabase.updateDatabase();

    if (noteDatabase.colorBox.get(noteDatabase.colorBoxValue) == null) {
      noteDatabase.createInitialData();
    } else {
      noteDatabase.loadData();
    }
    noteDatabase.updateDatabase();
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDatabase>(
      builder: (context, value, child) => Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 25.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: openDrawer,
                          icon: Icon(
                            Icons.menu,
                            color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                          ),
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CutsomCarouselWidget(
                      height: 160.0,
                      itemList: List.generate(tempCategoryList.length, (index) => "${tempCategoryList[index][1]}"),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      textStyle: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: DrawerModel(),
      ),
    );
  }
}
