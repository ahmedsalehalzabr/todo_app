import 'package:appnews/sqflitedb.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb aqlDb = SqlDb();

  Future<List<Map>> readData() async{
    List<Map> response = await aqlDb.readData("SELECT * FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
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
            // MaterialButton(onPressed: () async{
            //   await aqlDb.myDeleteDatabase();
            // },
            // child: Text("delete database"),
            // ),
            FutureBuilder(
                future: readData(),
                builder: (BuildContext context ,AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          title: Text("${snapshot.data![i]['title']}"),
                          subtitle: Text("${snapshot.data![i]['note']}"),
                          trailing: IconButton(onPressed: () async {
                                 int response = await aqlDb.deleteData("DELETE FROM notes WHERE id = ${snapshot.data![i]['id']}");
                                 if ( response > 0) {
                                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                                 }
                          },
                            icon: Icon(Icons.delete,color: Colors.red,),
                          ),
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator(),);
            })
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
