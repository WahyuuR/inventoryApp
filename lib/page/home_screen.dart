import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projek_akhir/page/create_screen.dart';
import 'package:projek_akhir/page/delete_screen.dart';
import 'package:projek_akhir/page/login_screen.dart';

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0), // Add left padding
          child: Image.asset(
            'assets/logo_warungKomputer.png',
            height: 200,
          ),
        ),
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0, // Set font size for description
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.black, // Change app bar color to black
      ),
      body: Container(
        color: Colors.orange, // Change body color to orange
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Display 2 cards in each row
                ),
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
                        color: Colors.black, // Change card color to black
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (dataList[i]['foto'] != null &&
                                  dataList[i]['foto'].isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Make the image rounded
                                  child: Image.network(
                                    dataList[i]['foto'],
                                    width: 80, // Set width of the image
                                    height: 80, // Set height of the image
                                    fit: BoxFit
                                        .cover, // Adjust how the image is inscribed into the space
                                  ),
                                ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Text(
                                dataList[i]['NamaItem'] ?? '',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Text(
                                dataList[i]['deskripsi'] ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.0,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Stok',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    ' : ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    dataList[i]['stok'].toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black, // Change bottom app bar color to black
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout),
              color: Colors.white, // Change icon color to white
            ),
            IconButton(
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
              icon: const Icon(Icons.add),
              color: Colors.white, // Change icon color to white
            ),
          ],
        ),
      ),
    );
  }
}