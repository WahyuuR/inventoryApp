import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EEditDelete extends StatefulWidget {
  const EEditDelete({super.key, this.data});
  final data;
  @override
  State<EEditDelete> createState() => _EEditDeleteState();
}

class _EEditDeleteState extends State<EEditDelete> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.data['NamaItem'];
    descriptionController.text = widget.data['deskripsi'];
    stockController.text = widget.data['stok'];
    photoController.text = widget.data['foto'];
  }

  editData() async {
    var url = Uri.parse(
        'https://6687c6d60bc7155dc0190f77.mockapi.io/api/v1/Item/${widget.data['id']}');
    var posBody = {
      "NamaItem": nameController.text,
      "deskripsi": descriptionController.text,
      "foto": photoController.text,
      "stok": stockController.text,
    };
    var response = await put(
      url,
      body: jsonEncode(posBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).pop('true');
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  deleteData() async {
    var url = Uri.parse(
        'https://6687c6d60bc7155dc0190f77.mockapi.io/api/v1/Item/${widget.data['id']}');
    var response = await delete(url);
    if (response.statusCode == 200 || response.statusCode == 204) {
      Navigator.of(context).pop('true');
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Delete'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12.0),
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Nama Item"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12.0),
              controller: descriptionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12.0),
              controller: photoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Foto"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12.0),
              controller: stockController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Stok"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  onPressed: () {
                    editData();
                  },
                ),
                const SizedBox(
                  width: 10.0,
                ),
                TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
