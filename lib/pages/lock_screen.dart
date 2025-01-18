import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:notelist_v3/models//loading_overlay.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';


class LockScreen extends StatefulWidget{

  const LockScreen({super.key});

  @override
  _LockScreen createState() => _LockScreen();

}

class _LockScreen extends State<LockScreen>{
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);
  
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  final int numLockPins=4;
  final List nums=[1,2,3,4,5,6,7,8,9,0];
  var inputText="";
  var actives;
  var clears;
  var values;
  var currentIndex=0;
  var code;
  bool _loading=false;
  bool isLocked=true;



  @override
  void initState(){

    setState(() {
      noteDatabase.createInitialData();
      if(noteDatabase.noteBox.get(noteDatabase.noteBoxAllNoteValue)==null){
        noteDatabase.createInitialData();
      }else {
        noteDatabase.loadData();
      }
      noteDatabase.updateDatabase();

      actives=List.generate(numLockPins, (index) => false, growable: false);
      clears=List.generate(numLockPins, (index) => false, growable: false);
      values=setValues(numLockPins);
      code=setPinCode(numLockPins);

    });
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      if (state == AppLifecycleState.resumed) {
        noteDatabase.updateDatabase();
        noteDatabase.updateDatabase();
      }
    });
  }

  String setPinCode(int numLockPins){
    String tempCode="";
    for(int i=0;i<numLockPins;i++){
      tempCode+=(i+1).toString();
    }
    return tempCode;
  }

  List setValues(int numLockPins){
    int temp=1;
    List tempList=[];
    if(numLockPins.isEven){
      for(int i=0;i<numLockPins/2;i++){
        tempList.add(i+1);
      }
      for(int i=(numLockPins/2).round();i<numLockPins;i++){
        tempList.add(numLockPins-i);
      }
    }else if(numLockPins.isOdd){
      for(int i=0;i<(numLockPins/2).ceil();i++){
        tempList.add(i+1);
      }
      for(int i=(numLockPins.ceil());i<numLockPins;i++){
        tempList.add(numLockPins - i);
      }
    }
    return tempList;
  }


  @override
  Widget build(BuildContext context){

    return LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
        backgroundColor:  noteDatabase.allColors[noteDatabase.themeColor][2][0]['background'],
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Enter Your Password",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.normal
              ),
            ),

            Expanded(
                child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(int i=0;i<numLockPins;i++)
                            AnimationBoxItem(
                              clear: clears[i],
                              active: actives[i],
                              value: values[i],
                            ),
                        ],
                      ),
                    )
                )

            ),
            Expanded(
              flex: 2,
                child:Container(
                    child: GridView.builder(
                        padding: EdgeInsets.all(0.0),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                        childAspectRatio: .7/.6),

                        itemBuilder: (context, index) => Container(
                          color: noteDatabase.allColors[noteDatabase.themeColor][2][0]['background'],
                          margin: EdgeInsets.all(8.0),
                          width: 50,
                          height: 50,

                          child: index==9
                          ?SizedBox()
                              :Center(
                            child: MaterialButton(
                              splashColor: noteDatabase.allColors[noteDatabase.themeColor][2][2]['secondary'],
                              minWidth: 50,
                              height: 55,
                              onPressed: ()  {
                                HapticFeedback.vibrate();







                                if(index==11){
                                  currentIndex>0 ? setState(() {
                                     inputText=inputText.substring(0,inputText.length-1);
                                     currentIndex--;
                                     clears[currentIndex]=false;
                                     actives[currentIndex]=false;

                                 }): null;
                                }else{
                                  if(inputText.length<6){
                                    setState(() {
                                      actives[currentIndex]=true;
                                      currentIndex++;
                                    });
                                  }
                                  inputText+=nums[index==10 ? index-1 : index].toString();
                                }
                                if(inputText.length==numLockPins){

                                  if (inputText == code) {

                                    // Show loading indicator for 2 seconds before proceeding
                                    setState(() {
                                      isLocked=false;
                                      // Set a loading state
                                      _loading = true;
                                    });

                                    Future.delayed(Duration(milliseconds: 4800), () {
                                      // After 2 seconds, navigate to the next screen or perform an action
                                      setState(() {
                                        // Remove the loading state
                                        _loading = false;

                                        // Do something after the loading, like navigating to a new screen
                                        // For example:
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,)),
                                        );
                                      });
                                    });
                                  }else{

                                    Vibration.vibrate(duration: 600);
                                  }
                                  setState(() {
                                    clears=clears.map((e) => true).toList();
                                    actives=actives.map((e) => false).toList();
                                  });
                                  inputText="";
                                  currentIndex=0;
                                  return;
                                }
                                clears=clears.map((e) => false).toList();



                                print(inputText);
                              },
                              color: noteDatabase.allColors[noteDatabase.themeColor][2][0]['background'],

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),

                              child: index==11
                                  ?  Icon(Icons.backspace_rounded,
                                    color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],)
                                  :Text("${nums[index == 10 ? index - 1  : index]}",
                                    style:  TextStyle(
                                        color: noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface'],
                                        fontSize: 22
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      itemCount: 12,
                    ),

                ),
            ),

          ],
        ),
      ),
    );
  }
}

class AnimationBoxItem extends StatefulWidget {
  final clear;
  final active;
  final value;

  AnimationBoxItem({super.key,this.clear=false,this.active=false,this.value}) ;

  @override
  State<AnimationBoxItem> createState() => _AnimationBoxItemState();
}

class _AnimationBoxItemState extends State<AnimationBoxItem> with TickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void initState(){
    super.initState();
    animationController =AnimationController(vsync: this,duration: Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    animationController.dispose(); // Dispose the animation controller properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.clear){
      animationController.forward(from: 0);
    }
    return AnimatedBuilder(
        animation: animationController,
        builder: (context,child) => Container(
          margin: widget.active ? EdgeInsets.symmetric(horizontal: 5.0) :EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
          //color: Colors.red,
          child: Stack(
            children: [
              Container(),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                width: widget.active ? 20 : 10,
                height: widget.active ? 20 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.active ? Colors.green : Colors.grey

                ),

              ),
              Align(
                alignment: Alignment(0,animationController.value/widget.value-1),
                child: Opacity(
                  opacity: 1-animationController.value,
                  child: Container(
                    width: widget.active ? 20 : 10,
                    height: widget.active ? 20 : 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.active ? Colors.green : Colors.grey

                    ),

                  ),
                ),

              ),
            ],
          ),
        )
    );
  }
}


