import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myfirstapp',
      home: TableDataPage(),
    );
  }
}

class TableDataPage extends StatefulWidget {
  @override
  _TableDataPageState createState() => _TableDataPageState();
}

class _TableDataPageState extends State<TableDataPage> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
    } else {
      // Handle error response
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Data'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('User ID')),
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Body')),
          ],
          rows: data
              .map(
                (item) => DataRow(
                  cells: [
                    DataCell(Text(item['userId'].toString())),
                    DataCell(Text(item['id'].toString())),
                    DataCell(Text(item['title'])),
                    DataCell(Text(item['body'])),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
