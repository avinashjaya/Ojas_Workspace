import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> jsonData = [];

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      setState(() {
        jsonData = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Table Example'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('Album ID'),
                ),
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('Title'),
                ),
                DataColumn(
                  label: Text('Thumbnail'),
                ),
              ],
              rows: jsonData
                  .map(
                    (data) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(data['albumId'].toString()),
                        ),
                        DataCell(
                          Text(data['id'].toString()),
                        ),
                        DataCell(
                          Text(data['title']),
                        ),
                        DataCell(
                          Image.network(
                            data['url'],
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
