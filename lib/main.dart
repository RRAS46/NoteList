import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/models/toggle_switch_model.dart';
import 'package:notelist_v3/models/note_model.dart';
import 'package:notelist_v3/pages/home_page.dart';
import 'package:notelist_v3/pages/lock_screen.dart';
import 'package:notelist_v3/pages/otp_verification.dart';
import 'package:notelist_v3/themes/light_dark_theme.dart';
import 'package:provider/provider.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  print(appDocumentDir.path);

  Hive.init(appDocumentDir.path);

  // Register the adapter for the Note class
  Hive.registerAdapter(NoteAdapter());

  await Hive.openBox('notelistbox');
  await Hive.openBox('colorbox');


  // Initialize Hive boxes or types here if needed


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {




  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

    return ChangeNotifierProvider(
      create: (context) => NoteDatabase(), // Provide an instance of Counter
      builder: (context,child) =>  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),

      ),
    );
  }
}



