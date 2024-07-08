import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projek_akhir/page/create_screen.dart';
import 'package:projek_akhir/page/delete_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dataList = [];
  var loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var url =
        Uri.parse('https://6687c6d60bc7155dc0190f77.mockapi.io/api/v1/Item');
    var response = await get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        loading = false;
        print(jsonResponse);
        dataList = jsonResponse;
        if (kDebugMode) {
          print('Number of items: $jsonResponse.');
        }
      });
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
        title: Text(widget.title),
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EEditDelete(
                            data: dataList[i],
                          ),
                        ),
                      );
                      if (result == 'true') {
                        setState(() {
                          loading = true;
                          getData();
                        });
                      }
                    },
                    child: Card(
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(':'),
                                    Image.asset('assets/wajahkodok.jpg')
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(dataList[i]['NamaItem'] ?? '')
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(dataList[i]['deskripsi'] ?? '')
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Stok',
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                    const Text(' : '),
                                    Text(dataList[i]['stok'].toString() ??
                                        ''), // convert int to String
                                  ],
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const Create(),
            ),
          );
          if (result == 'true') {
            setState(() {
              loading = true;
              getData();
            });
          }
        },
      ),
    );
  }
}
