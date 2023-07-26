import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String note;
  const UpdatePage({
    super.key,
    required this.client,
    required this.id,
    required this.note,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final url = Uri.parse(
                    'https://ogbesomto.pythonanywhere.com/notes/${widget.id}/update/');
                http.put(
                  url,
                  body: ({'body': controller.text}),
                );
                // print(response.statusCode);
                Navigator.pop(context);
              },
              child: const Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
