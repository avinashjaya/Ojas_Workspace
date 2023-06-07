import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Table',
      home: DataTablePage(),
    );
  }
}

class DataTablePage extends StatefulWidget {
  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  int rowCount = 0;
  int columnCount = 0;
  List<List<TextEditingController>> textControllers = [];
  List<List<String>> tableData = [];

  void generateTable() {
    setState(() {
      textControllers = List.generate(rowCount, (i) {
        return List.generate(columnCount, (j) {
          return TextEditingController();
        });
      });
      tableData = List.generate(rowCount, (i) {
        return List.generate(columnCount, (j) {
          return '';
        });
      });
    });
  }

  void showData() {
    List<List<String>> data = [];
    for (int i = 0; i < rowCount; i++) {
      List<String> row = [];
      for (int j = 0; j < columnCount; j++) {
        row.add(textControllers[i][j].text);
      }
      data.add(row);
    }
    setState(() {
      tableData = data;
    });
  }

  @override
  void dispose() {
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        textControllers[i][j].dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Table'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Rows:'),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        rowCount = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Columns:'),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        columnCount = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                generateTable();
              },
              child: Text('Generate Table'),
            ),
            SizedBox(height: 16.0),
            if (tableData.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: List.generate(
                    columnCount,
                    (index) => DataColumn(
                      label: Text('Column ${index + 1}'),
                    ),
                  ),
                  rows: List.generate(
                    rowCount,
                    (i) => DataRow(
                      cells: List.generate(
                        columnCount,
                        (j) => DataCell(
                          TextField(
                            controller: textControllers[i][j],
                            onChanged: (value) {
                              tableData[i][j] = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showData();
              },
              child: Text('Show Data'),
            ),
            SizedBox(height: 16.0),
            if (tableData.isNotEmpty)
              DataTable(
                columns: List.generate(
                  columnCount,
                  (index) => DataColumn(
                    label: Text('Column ${index + 1}'),
                  ),
                ),
                rows: List.generate(
                  rowCount,
                  (i) => DataRow(
                    cells: List.generate(
                      columnCount,
                      (j) => DataCell(
                        Text(tableData[i][j]),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
