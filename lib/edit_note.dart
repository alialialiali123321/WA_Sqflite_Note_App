import 'package:flutter/material.dart';

import 'home_page.dart';
import 'sqldb.dart';

class EditNote extends StatefulWidget {
  final int id;
  final String note;
  final String title;
  final String color;

  const EditNote({
    super.key,
    required this.id,
    required this.note,
    required this.title,
    required this.color,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

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
        centerTitle: true,
        title: const Text('Edit Note'),
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
                    child: const Text('Edit Note'),
                    onPressed: () async {
                      int response = await sqlDb.updateData(
                        table: 'Notes',
                        values: {
                          'title': title.text,
                          'note': note.text,
                          'color': color.text,
                        },
                        where: 'id = ${widget.id}',
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
