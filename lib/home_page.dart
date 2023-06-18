import 'package:flutter/material.dart';

import 'sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map<String, Object?>>> readData() async {
    List<Map<String, Object?>> response =
        await sqlDb.readData('SELECT * FROM Notes');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: ListView(
        children: [
          // ElevatedButton(
          //     onPressed: () {
          //       sqlDb.deleteDb();
          //     },
          //     child: const Text('Delete')),
          FutureBuilder(
            future: readData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        title: Text('${snapshot.data![index]['title']}'),
                        subtitle: Text('${snapshot.data![index]['note']}'),
                        trailing: Text('${snapshot.data![index]['color']}'),
                      ));
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
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
