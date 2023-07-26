import 'package:http/http.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({super.key, required this.client});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Note'),
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
                    'https://ogbesomto.pythonanywhere.com/notes/create/');
                widget.client.post(
                  url,
                  body: {"body": controller.text},
                );
                // print(response.statusCode);
                Navigator.pop(context);
              },
              child: const Text('Create Note'),
            ),
          ],
        ),
      ),
    );
  }
}
