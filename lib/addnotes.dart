import 'package:appnews/home.dart';
import 'package:appnews/sqflitedb.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Container(
        child: ListView(
          children: [
          Form(
            key: formstate,
            child:
            Column(
              children: [
                TextFormField(
                  controller: note,
                  decoration: InputDecoration(
                    hintText: "note"
                  ),
                ),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "title"
                  ),
                ),
                TextFormField(
                  controller: color,
                  decoration: InputDecoration(
                      hintText: "color"
                  ),
                ),

                Container(height: 20,),
                MaterialButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () async{
                 // int response = await sqlDb.insertData('''
                 //     INSERT INTO notes (`note`, `title`, `color`)
                 //     VALUES ("${note.text}","${title.text}","${color.text}")
                 //     ''');
                      int response = await sqlDb.insert("notes", {
                        "note":"${note.text}",
                        "title":"${title.text}",
                        "color":"${color.text}"
                      });
                     if (response > 0) {
                       Navigator.of(context).pushAndRemoveUntil(
                           MaterialPageRoute(builder: (context) => Home()),
                           (route) => false);
                     }
                 },
                    child: Text("Add Note"),)

          ],),)
        ],),
      ),
    );
  }
}
