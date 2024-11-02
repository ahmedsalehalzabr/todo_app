import 'package:appnews/home.dart';
import 'package:appnews/sqflitedb.dart';
import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  EditNotes({super.key, this.note, this.title, this.id, this.color});

  @override
  State<EditNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<EditNotes> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
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
                     //  int response = await sqlDb.updateData(
                     //      '''
                     //  UPDATE notes SET
                     //  note  = "${note.text}",
                     //  title = "${title.text}",
                     //  color = "${color.text}"
                     //  WHERE id = ${widget.id}
                     // ''');
                      int response = await sqlDb.update(
                          "notes",
                          {
                            "note": "${note.text}",
                            "title" : "${title.text}",
                            "color" : "${color.text}"
                            },
                          "id = ${widget.id}");
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Home()),
                                (route) => false);
                      }
                    },
                    child: Text("Edit Note"),)

                ],),)
          ],),
      ),
    );
  }
}
