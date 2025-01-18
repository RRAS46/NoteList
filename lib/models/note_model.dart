import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:provider/provider.dart';





class NoteTile extends StatelessWidget {


  Note note;
  Function(bool?)? onChanged;
  Function(BuildContext)? editFunction;


  NoteTile({
    super.key,
    required this.note,
    required this.onChanged,
    required this.editFunction,
  });





  @override
  Widget build(BuildContext context) {
    late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);


    return Row(

      children: [
        /*
        Checkbox(value: note.isChecked, onChanged: onChanged,
            checkColor: Colors.green,
            fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.orange.withOpacity(.1);
              }
              return !note.isChecked? Colors.transparent: noteDatabase.allColors[noteDatabase.themeColor][2][2]['secondary'];
            })
        ),
         */

        SizedBox(
          width: 170,
          child: Text(
            note.text,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              color: !note.isChecked? noteDatabase.allColors[noteDatabase.themeColor][2][3]['surface']: Colors.grey.withOpacity(0.9),
              fontSize: 17,
              decoration: note.isChecked?TextDecoration.lineThrough:null,
            ),
          ),
        ),
      ],
    );
  }

}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0; // Unique identifier for the Note class

  @override
  Note read(BinaryReader reader) {
    return Note(
      id: reader.readInt(),
      text: reader.readString(),
      isChecked: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.text);
    writer.writeBool(obj.isChecked);
  }


}


class Note {
  int id;
  String text;
  bool isChecked;
  DateTime time;
  Category category;

  DateTime getTime() {
    DateTime now = DateTime.now();
    print('Current time: $now');
    return now;
  }
  Note({required this.id,required this.text,required this.isChecked, DateTime? time,
    Category? category,
  }) : time = time ?? DateTime.now() ,category= category ?? Category(index: 0);
}

class Category{
  int index;
  String ctgr;

  Category({required this.index,String? ctgr}) : ctgr = ctgr ?? tempCategoryList[index].toString();

}