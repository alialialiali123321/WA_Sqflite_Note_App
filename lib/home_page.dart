import 'package:flutter/material.dart';
import 'package:flutter_application_1/edit_note.dart';

import 'sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  void readData() async {
    List<Map<String, Object?>> response = await sqlDb.readData(table: 'Notes');
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
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
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       sqlDb.deleteDb();
                //     },
                //     child: const Text('Delete')),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text('${notes[index]['title']}'),
                        subtitle: Text('${notes[index]['note']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNote(
                                    id: notes[index]['id'],
                                    note: notes[index]['note'],
                                    title: notes[index]['title'],
                                    color: notes[index]['color'],
                                  ),
                                ));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                int response = await sqlDb.deleteData(
                                  table: 'Notes',
                                  where: 'id = ${notes[index]['id']}',
                                );
                                if (response != 0) {
                                  setState(() {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[index]['id']);
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('AddNote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
