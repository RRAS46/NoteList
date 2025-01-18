
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/drawer_model.dart';
import 'package:notelist_v3/models/drop_down_menu_model.dart';
import 'package:notelist_v3/models/premium_button_model.dart';
import 'package:notelist_v3/models/toggle_switch_model.dart';
import 'package:notelist_v3/models/note_model.dart';
import 'package:notelist_v3/pages/home_page.dart';
import 'package:notelist_v3/pages/lock_screen.dart';
import 'package:notelist_v3/pages/otp_verification.dart';
import 'package:notelist_v3/pages/settings_page.dart';
import 'package:notelist_v3/utils/dialog_box.dart';
import 'package:provider/provider.dart';
import 'package:notelist_v3/models/carousel_model.dart';

class NotesPage extends StatefulWidget {
  bool isLocked;
   NotesPage({super.key,this.isLocked=true});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>  with TickerProviderStateMixin{
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

  late AnimationController _animationController;


  final _textEditingController=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool dataReady=false;
  late int listCategory;

  @override
  void initState(){
    setState(() {

      if(widget.isLocked){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LockScreen(),));
      }
      noteDatabase.createInitialData();

      if(noteDatabase.noteBox.get(noteDatabase.noteBoxAllNoteValue)==null){
        noteDatabase.createInitialData();
      }else {
        noteDatabase.loadData();
      }
      noteDatabase.updateDatabase();
      if(noteDatabase.colorBox.get(noteDatabase.colorBoxValue)==null){
        noteDatabase.createInitialData();
      }else {
        noteDatabase.loadData();
      }

      listCategory=noteDatabase.currentCategoryList;
      noteDatabase.updateDatabase();

      _animationController=AnimationController(vsync: this);
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    });
    super.initState();

  }

  void checkBoxChanged(List check,int index){
    setState(() {
        check[index].isChecked=!check[index].isChecked;
      });
    noteDatabase.updateDatabase();
  }
  void openDrawer() {

    _scaffoldKey.currentState?.openDrawer();
  }


  void createNewNote(int indexList){
    List _topicNoteList=noteDatabase.allNotes[indexList];
    print(_topicNoteList);
    showDialog(context: context, builder: (context){
      return DialogBox(
        primaryColor: Colors.grey,
        secondaryColor: Colors.yellow,
        controller: _textEditingController,
        onSave: () => saveNote(_topicNoteList, -1, true),
        onCancel: () {
          setState(() {
            _textEditingController.text="";
          });
          Navigator.of(context).pop();
        },
      );
    }
    );
    noteDatabase.updateDatabase();
  }


  void editExistingNote(List _topicNoteList,int index){
    _textEditingController.text=_topicNoteList[index].text;
    showDialog(context: context, builder: (context){
      return DialogBox(
        primaryColor: Colors.grey,
        secondaryColor: Colors.yellow,
        controller: _textEditingController,
        onSave: () => saveNote(_topicNoteList,index,false),
        onCancel: () {
          setState(() {
            _textEditingController.text="";
          });
          Navigator.of(context).pop();
        },

      );
    }
    );
    noteDatabase.updateDatabase();
  }

  void deleteNote(int listIndex,int noteIndex){
    noteDatabase.deleteNote(listIndex,noteIndex);
    noteDatabase.updateDatabase();
  }


  void saveNote(List saveTopicNoteList,int index,bool isNewNote){
    if(isNewNote){
      int id=saveTopicNoteList.length;

      setState(() {
        if(_textEditingController.text.isEmpty){
          return ;
        }
        Note newNote=Note(id: id, text: _textEditingController.text, isChecked: false,category: Category(index: noteDatabase.currentCategoryList));
        noteDatabase.addNewNote(newNote,noteDatabase.currentCategoryList);

        _textEditingController.text="";
        Navigator.of(context).pop();
      });
    }else{

      setState(() {
        if(_textEditingController.text.isEmpty){
          return ;
        }
        saveTopicNoteList[index]=Note(id: saveTopicNoteList[index].id, text: _textEditingController.text, isChecked: saveTopicNoteList[index].isChecked);

        _textEditingController.text="";
        Navigator.of(context).pop();
      });
    }
    noteDatabase.updateDatabase();
  }

  void _navigateTo({required parameter}){
    setState(() async {
      await Navigator.push (
        context,
        MaterialPageRoute(
          builder: (context) =>  parameter,
        ),
      );
    });
    //Navigator.pop(context); // Close the drawer before navigating
  }



  @override
  Widget build(BuildContext context) {
    if (noteDatabase.allNotes.isEmpty && !dataReady) {

      return Scaffold(
        appBar: AppBar(
          backgroundColor: noteDatabase.allColors[noteDatabase.themeColor][2][2]['secondary'],
          title: const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text('Loading...'),
          ),
        ),
        body:  Container(
          color: noteDatabase.allColors[noteDatabase.themeColor][2][0]['background'],
          child: Center(
            child: Lottie.asset(
              'assets/gear_loading.json',
              frameRate: FrameRate(25),
              controller: _animationController,
              onLoaded: (composition) {
                _animationController.duration = composition.duration;
                _animationController.forward();
              },

              height: 170,
              width: 170,

              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    }else{


      return Consumer<NoteDatabase>(

          builder: (context,value,child) => Scaffold(
            key: _scaffoldKey,
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Text(
                                tempCategoryList[noteDatabase.currentCategoryList][1].toString(),
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
                                      icon:  Icon(Icons.add_task,
                                        color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                                      ),
                                      onPressed: () => createNewNote(listCategory),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon:  Icon(Icons.more_vert,
                                        color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],

                                      ),
                                      onPressed: () => createNewNote(listCategory),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                       ),
                     ),
                    
                    cupertinoMaker(context, noteDatabase.currentCategoryList),
                  ],
                ),
              ],

            ),
            drawer: DrawerModel(),
          )
      );
    }

  }
  Widget cupertinoMaker(var context,int indexList){

    late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);
    List topicNoteList=[];
    topicNoteList.addAll(noteDatabase.allNotes[indexList]);
    print("ninaou: $topicNoteList");
    if(topicNoteList.isNotEmpty){
      return  SingleChildScrollView(
        child: CupertinoListSection.insetGrouped(

            margin: EdgeInsets.all(10),

            backgroundColor:noteDatabase.allColors[noteDatabase.themeColor][2][2]['secondary'],
            children: List.generate(
              topicNoteList.length + 1,
                  (index){

                if(index <topicNoteList.length){

                  return MaterialButton(
                      color: noteDatabase.allColors[noteDatabase.themeColor][2][1]['primary'],

                      onPressed: () => createNewNote(indexList),
                      child: CupertinoListTile(
                        leading: CupertinoCheckbox(value: topicNoteList[index].isChecked, onChanged: (p0) => checkBoxChanged(topicNoteList,index),
                          checkColor: Colors.green,
                          activeColor: topicNoteList[index].isChecked?Colors.orange.withOpacity(.2):Colors.white,
                          inactiveColor: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            showMenuTile(context,topicNoteList,index);
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                          ),
                        ),
                        title: NoteTile(note: topicNoteList[index],onChanged:(p0) => checkBoxChanged(topicNoteList,index),editFunction: (p0) => editExistingNote(topicNoteList,index),

                        ),
                      )
                  );
                }else{
                  if(index>20){
                    return const SizedBox(height: 160);// Adjust height as needed
                  }
                  return const SizedBox(height: 0,);

                }
              },
            )
        ),
      );
    }else{
      return Container(
        child: Center(
          heightFactor: 12.6,
          child: Text("List is empty",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
        ),
      );
    }
   

  }

  void showMenuTile (BuildContext context,List menuTopicList,int index) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            Container(
              color: Colors.grey,
              child: CupertinoActionSheetAction(
                onPressed: () {

                  Navigator.pop(context);
                  editExistingNote(menuTopicList,index);
                  // Action 2
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit,
                        color: Colors.black),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text('Edit',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.red,
              child: CupertinoActionSheetAction(
                onPressed: () {
                  deleteNote(noteDatabase.currentCategoryList,index);
                  // Action 2
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete,
                    color: Colors.black),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text('Delete',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                    ),
                  ],
                ),
              ),
            ),
            // Add more actions as needed
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              // Cancel button
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }
}
