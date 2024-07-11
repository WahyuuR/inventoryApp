import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;
  String? _imageUrl;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageUrl = null;
        photoController.text =
            pickedFile.path.split('/').last; // Show file name
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  createData() async {
    var url =
        Uri.parse('https://6687c6d60bc7155dc0190f77.mockapi.io/api/v1/Item');
    var posBody = {
      "NamaItem": nameController.text,
      "deskripsi": descriptionController.text,
      "foto": _image != null
          ? base64Encode(_image!.readAsBytesSync())
          : _imageUrl ?? "",
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
      body: SingleChildScrollView(
        child: Column(
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
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: photoController,
                      style: const TextStyle(fontSize: 12.0),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: "Foto"),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: stockController,
                style: const TextStyle(fontSize: 12.0),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Stok"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Image URL"),
                onChanged: (value) {
                  setState(() {
                    _imageUrl = value;
                    _image = null;
                    photoController.text = value;
                  });
                },
              ),
            ),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.file(_image!),
              ),
            if (_imageUrl != null && _imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(_imageUrl!),
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
      ),
    );
  }
}
