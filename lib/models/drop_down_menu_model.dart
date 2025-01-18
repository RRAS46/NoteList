import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/note_model.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';


class StackMenuExample extends StatefulWidget {
  @override
  _StackMenuExampleState createState() => _StackMenuExampleState();
}

class _StackMenuExampleState extends State<StackMenuExample> {
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

  late GlobalKey _buttonKey;
  late Offset _buttonPosition;

  @override
  void initState() {
    super.initState();
    _buttonKey = GlobalKey();
  }

  void _openMenu() {
    final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    _buttonPosition = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _buttonPosition & Size.zero,
        Offset.zero & MediaQuery.of(context).size,
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Action for Item 1
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Action for Item 2
              Navigator.pop(context);
            },
          ),
        ),
        // Add more PopupMenuItems as needed
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          key: _buttonKey,
          onPressed: _openMenu,
          child: Text('Open Menu'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade600, // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Button border radius
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0), // Button padding
          ),
    );
  }
}

class PopUpMenu extends StatelessWidget {

  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

    return GestureDetector(
      onTap: () => showPopover(
          context: context,
          bodyBuilder: (context) => MenuItems(),
        width: 250,
        height: 150,
        backgroundColor: Colors.orangeAccent
      ),
      child: Icon(Icons.add),
    );
  }
}

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {

  @override
  Widget build(BuildContext context) {

    late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

    return Container(

      color: Colors.transparent,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.inbox,
              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
            ),

            title: Text(tempCategoryList[0][1].toString(),
            style: TextStyle(
              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

            ),
            ),
            onTap: () {
              setState(() {
                noteDatabase.currentCategoryList=0;
                noteDatabase.updateDatabase();
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,),));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.work,
              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

            ),

            title: Text(tempCategoryList[1][1].toString(),
              style: TextStyle(
                color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

              ),
            ),
            onTap: () {
              setState(() {
                noteDatabase.currentCategoryList=1;
                noteDatabase.updateDatabase();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,),));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.interests_outlined,
              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

            ),

            title: Text(tempCategoryList[2][1].toString(),
              style: TextStyle(
                color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

              ),
            ),
            onTap: () {
              setState(() {
                noteDatabase.currentCategoryList=2;
                noteDatabase.updateDatabase();
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,),));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb,
              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

            ),

            title: Text(tempCategoryList[3][1].toString(),
              style: TextStyle(
                color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
              ),
            ),
            onTap: () {
              setState(() {
                noteDatabase.currentCategoryList=3;
                noteDatabase.updateDatabase();
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,),));
              });
            },
          ),
          ListTile(
            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                )
            ),
            onTap: () {
              setState(() {
                noteDatabase.currentCategoryList=4;
                noteDatabase.updateDatabase();
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,),));
              });
            },
            leading: Icon(Icons.label_important,
              color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

            ),
            title: Text(tempCategoryList[4][1].toString(),
              style: TextStyle(
                color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

              ),
            ),
          ),
        ],
      ),
    );
  }
}

