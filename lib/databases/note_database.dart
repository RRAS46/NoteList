import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notelist_v3/models/note_model.dart';
import 'package:notelist_v3/themes/light_dark_theme.dart';


List<Map<String,Color>> tempDarkColorList=[
  {"background" : Colors.black},
  {"primary" : Colors.black45},
  {"secondary" : Colors.black26},
  {"surface" : Colors.grey.shade200}
];
List<Map<String,Color>> tempLightColorList=[
  {"background": Colors.white},
  {"primary": Colors.grey.shade400},
  {"secondary": Colors.grey.shade600},
  {"surface": Colors.black}
];
List tempCategoryList=[
  [0,"Default"],
  [1,"Work"],
  [2,"Habit"],
  [3,"Ideas"],
  [4,"Primary"],

];


class NoteDatabase extends ChangeNotifier {
  final noteBox= Hive.box("notelistbox");
  final colorBox=Hive.box("colorbox");


  final String noteBoxAllNoteValue="ALLNOTELIST";
  final String noteBoxPrimaryNotesValue="PRIMARYNOTELIST";
  final String noteBoxDefaultNotesValue="DEFAULTNOTELIST";
  final String noteBoxWorkNotesValue="WORKNOTELIST";
  final String noteBoxHabitNotesValue="HABITNOTELIST";
  final String noteBoxIdeasNotesValue="IDEASNOTELIST";

  final String categoryListValue="CATEGORYLISTVALUE";


  final String colorBoxValue="COLORHOLD";

  final LightDarkMode ldMode=LightDarkMode();


  var currentCategoryList=0;

  List allNotes=[];
  List primaryNotes=[];
  List defaultNotes=[];
  List workNotes=[];
  List habitNotes=[];
  List ideasNotes=[];


  List allColors=[];
  var themeColor=0;

  void createInitialData(){

    currentCategoryList=0;

    defaultNotes=[
      Note(id: 1, text: "text", isChecked: false),
      Note(id: 2, text: "text", isChecked: false),
      Note(id: 3, text: "text", isChecked: false),
      Note(id: 4, text: "check", isChecked: false),
    ];
    workNotes=[];
    habitNotes=[];
    ideasNotes=[];
    primaryNotes=[];
    allNotes=[
      defaultNotes,
      workNotes,
      habitNotes,
      ideasNotes,
      primaryNotes,
    ];

    LightDarkMode tempLight=ldMode.initLightMode();
    LightDarkMode tempDark=ldMode.initDarkMode();



    allColors=[
      [tempLight.themeName,tempLight.themeicon,tempLightColorList,tempLight.isDarkMode],
      [tempDark.themeName,tempDark.themeicon,tempDarkColorList,tempDark.isDarkMode],

    ];
    themeColor=0;
  }



  void addNewNote(Note note,int listIndex) {
    allNotes[listIndex].add(note);
    notifyListeners();
    updateDatabase();

  }

  void loadData(){
    currentCategoryList=noteBox.get(categoryListValue);

    primaryNotes =noteBox.get(noteBoxPrimaryNotesValue);
    defaultNotes =noteBox.get(noteBoxDefaultNotesValue);
    workNotes =noteBox.get(noteBoxWorkNotesValue);
    habitNotes =noteBox.get(noteBoxHabitNotesValue);
    ideasNotes =noteBox.get(noteBoxIdeasNotesValue);

    allNotes = noteBox.get(noteBoxAllNoteValue);

    themeColor=colorBox.get(colorBoxValue);
    notifyListeners();
    updateDatabase();

  }


  void updateDatabase() {
    noteBox.put(categoryListValue, currentCategoryList);

    noteBox.put(noteBoxDefaultNotesValue, defaultNotes);
    noteBox.put(noteBoxWorkNotesValue, workNotes);
    noteBox.put(noteBoxHabitNotesValue, habitNotes);
    noteBox.put(noteBoxIdeasNotesValue, ideasNotes);
    noteBox.put(noteBoxPrimaryNotesValue, primaryNotes);

    noteBox.put(noteBoxAllNoteValue, allNotes);


    colorBox.put(colorBoxValue, themeColor);
    notifyListeners();

  }

  void deleteNote(int listIndex,int noteIndex) {
    allNotes[listIndex].remove(allNotes[listIndex][noteIndex]);
    notifyListeners();
    updateDatabase();
  }

  List? getListNote(int indexList){
    if(indexList==tempCategoryList[0][0]){return defaultNotes; currentCategoryList=0;}
    if(indexList==tempCategoryList[1][0]){return workNotes; currentCategoryList=1;}
    if(indexList==tempCategoryList[2][0]){return habitNotes; currentCategoryList=2;}
    if(indexList==tempCategoryList[3][0]){return ideasNotes; currentCategoryList=3;}
    if(indexList==tempCategoryList[4][0]){return primaryNotes; currentCategoryList=4;}
    //updateDatabase();
    notifyListeners();
  }

}
