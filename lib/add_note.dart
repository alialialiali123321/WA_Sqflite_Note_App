import 'package:flutter/material.dart';

import 'home_page.dart';
import 'sqldb.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Note'),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(13),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      label: Text('Note'),
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(13),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      label: Text('Color'),
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(13),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    height: 35,
                    child: const Text('Add Note'),
                    onPressed: () async {
                      int response = await sqlDb.insertData(
                        table: 'Notes',
                        values: {
                          'note': note.text,
                          'title': title.text,
                          'color': color.text,
                        },
                      );
                      if (response != 0) {
                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
