import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/button_model.dart';
import 'package:notelist_v3/models/button_model.dart';
import 'package:notelist_v3/models/drop_down_menu_model.dart';
import 'package:provider/provider.dart';


class DialogBox extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.controller,
    required this.onSave,
    required this.onCancel});


  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {

  @override
  Widget build(BuildContext context){
    late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

    List<DropdownMenuItem<dynamic>> dropdownItems = tempCategoryList.map((dynamic value) {
      return DropdownMenuItem<dynamic>(
        value: value,
        child: Text(value[1].toString()),
      );
    }).toList();

    List _selectedItem=tempCategoryList[noteDatabase.currentCategoryList];

    return AlertDialog(
      backgroundColor: widget.primaryColor,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<dynamic>(
              value: _selectedItem,
              items: dropdownItems,
              onChanged: (dynamic val) {
                setState(() {
                  noteDatabase.currentCategoryList=val[0];
                  print(val);


                  noteDatabase.updateDatabase();
                });
              },
            ),
            TextField(
              autofocus: true,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: "Add a new task!",
                  focusColor: Colors.green
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MakeButton(widget: Text("Save"), onPressed: widget.onSave,primaryColor: widget.primaryColor,secondaryColor: widget.secondaryColor,heightLength: 40,widthLength: 90, text: '',),
                const SizedBox(width: 10,),

                MakeButton(widget: Text("Cancel"), onPressed: widget.onCancel,primaryColor: widget.primaryColor,secondaryColor: widget.secondaryColor,heightLength: 40,widthLength: 90, text: '',),



              ],
            )
          ],


        ),

      ),
    );
  }
}



