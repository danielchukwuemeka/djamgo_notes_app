import 'dart:convert';

import 'package:djangoapp/create.dart';
import 'package:djangoapp/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:djangoapp/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Django Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple Django Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retriveNotes();
    super.initState();
  }

  _retriveNotes() async {
    notes = [];
    final uri = Uri.parse("https://ogbesomto.pythonanywhere.com/notes/");
    List response = json.decode((await client.get(uri)).body);
    for (var element in response) {
      notes.add(Note.fromMap(element));
    }
    setState(() {});
  }

  Future<http.Response> _deleteNote(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://ogbesomto.pythonanywhere.com/notes/$id/delete/'),
    );
    _retriveNotes();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retriveNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Checkbox(
                value: notes[index].isSelected,
                onChanged: (value) {
                  setState(() => notes[index].isSelected = value!);
                },
              ),
              title: Text(notes[index].note),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdatePage(
                          client: client,
                          id: notes[index].id,
                          note: notes[index].note,
                        )));
              },
              trailing: IconButton(
                onPressed: () => _deleteNote(notes[index].id),
                icon: const Icon(Icons.delete),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreatePage(client: client)));
        },
        tooltip: 'Add New Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
