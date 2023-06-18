import 'dart:developer';

import 'package:flutter/material.dart';

import 'sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Insert Data'),
              onPressed: () async {
                int response = await sqlDb.insertData(
                    sql: 'INSERT INTO "Notes" ("note") VALUES ("note one")');
                log(response.toString());
              },
            ),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Read Data'),
              onPressed: () async {
                List<Map<String, Object?>> response =
                    await sqlDb.readData(sql: 'SELECT * FROM "Notes"');
                log(response.toString());
              },
            ),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Delete Data'),
              onPressed: () async {
                int response = await sqlDb.deleteData(
                    sql: 'DELETE FROM "Notes" WHERE id = 2');
                log(response.toString());
              },
            ),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Update Data'),
              onPressed: () async {
                int response = await sqlDb.updateData(
                    sql: 'UPDATE "Notes" SET "note" = "note six" WHERE id = 1');
                log(response.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
