import 'package:appnews/editnotes.dart';
import 'package:appnews/sqflitedb.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb aqlDb = SqlDb();
  bool isLoading = true ;
  List notes = [];

  Future<List<Map>> readData() async{
    List<Map> response = await aqlDb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {

      });
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: ListView(
          children: [
                Center(
                  child: MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () async {
                      await aqlDb.myDeleteDatabase();
                    },
                    child: Text("Delete Database"),
                  ),
                ),
         ListView.builder(
                  itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          title: Text("${notes[i]['title']}"),
                          subtitle: Text("${notes[i]['note']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                // int response = await aqlDb.deleteData("DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                  int response = await aqlDb.delete("notes","id = ${notes[i]['id']}");
                                if ( response > 0) {
                                  notes.removeWhere((element) => element['id'] == notes[i]['id']);
                                  setState(() {

                                  });
                                }
                              },
                                icon: Icon(Icons.delete,color: Colors.red,),
                              ),
                              IconButton(
                                onPressed: () async {
                               Navigator.of(context).push(
                                 MaterialPageRoute(builder: (context) => EditNotes(
                                   color: notes[i]['color'],
                                   note: notes[i]['note'],
                                   title: notes[i]['title'],
                                   id: notes[i]['id'],
                                 ))
                               );
                                },
                                icon: Icon(Icons.edit,color: Colors.blue,),
                              ),
                            ],
                          )
                        ),
                      );
                    }),
          ],
        )



        // Column(
        //   children: [
        //     Center(
        //       child: MaterialButton(
        //         color: Colors.red,
        //         textColor: Colors.white,
        //         onPressed: () async {
        //           int response = await aqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('note fore')" );
        //            print("$response");
        //         },
        //         child: Text("Insert Data"),
        //       ),
        //     ),
        //     Center(
        //       child: MaterialButton(
        //         color: Colors.red,
        //         textColor: Colors.white,
        //         onPressed: () async{
        //           List<Map> response = await aqlDb.readData("SELECT * FROM 'notes'" );
        //           print("$response");
        //         },
        //         child: Text("Read Data"),
        //       ),
        //     ),
        //     Center(
        //       child: MaterialButton(
        //         color: Colors.red,
        //         textColor: Colors.white,
        //         onPressed: () async{
        //           int response = await aqlDb.deleteData("DELETE FROM 'notes' WHERE id = 5 " );
        //           print("$response");
        //         },
        //         child: Text("Delete Data"),
        //       ),
        //     ),
        //     Center(
        //       child: MaterialButton(
        //         color: Colors.red,
        //         textColor: Colors.white,
        //         onPressed: () async{
        //           int response = await aqlDb.updateData("UPDATE 'notes' SET 'note' = 'note six' WHERE id = 6 " );
        //           print("$response");
        //         },
        //         child: Text("Update Data"),
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
