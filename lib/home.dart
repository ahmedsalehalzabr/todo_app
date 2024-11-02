import 'package:appnews/sqflitedb.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb aqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  int response = await aqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('note fore')" );
                   print("$response");
                },
                child: Text("Insert Data"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async{
                  List<Map> response = await aqlDb.readData("SELECT * FROM 'notes'" );
                  print("$response");
                },
                child: Text("Read Data"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async{
                  int response = await aqlDb.deleteData("DELETE FROM 'notes' WHERE id = 5 " );
                  print("$response");
                },
                child: Text("Delete Data"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async{
                  int response = await aqlDb.updateData("UPDATE 'notes' SET 'note' = 'note six' WHERE id = 6 " );
                  print("$response");
                },
                child: Text("Update Data"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
