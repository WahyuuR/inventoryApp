import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Create extends StatefulWidget {
  const Create({super.key});
  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  createData() async {
    var url =
        Uri.parse('https://6687c6d60bc7155dc0190f77.mockapi.io/api/v1/Item');
    var posBody = {
      "NamaItem": nameController.text,
      "deskripsi": descriptionController.text,
      "foto": photoController.text,
      "stok": stockController.text
    };
    var response = await post(
      url,
      body: jsonEncode(posBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).pop('true');
    } else {
      if (kDebugMode) {
        print('Request failed with status:${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: nameController,
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Nama Item"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: descriptionController,
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: photoController,
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "foto"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: stockController,
              style: const TextStyle(fontSize: 12.0),
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "stok"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child: const Text(
                'Simpan',
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                createData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
