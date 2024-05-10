import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> dataList = [];
  String searchKeyword = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Order',
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        centerTitle: true,  // Thêm dòng này
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _itemController,
                    decoration: InputDecoration(labelText: 'Item'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an item';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _itemNameController,
                    decoration: InputDecoration(labelText: 'Item Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an item name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _currencyController,
                    decoration: InputDecoration(labelText: 'Currency'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          dataList.add({
                            'id': dataList.length + 1,
                            'item': _itemController.text,
                            'item_name': _itemNameController.text,
                            'quantity': _quantityController.text,
                            'price': _priceController.text,
                            'currency': _currencyController.text,
                          });
                          _itemController.clear();
                          _itemNameController.clear();
                          _quantityController.clear();
                          _priceController.clear();
                          _currencyController.clear();
                        });
                      }
                    },
                    child: Text('Add Item'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Item Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Currency')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: dataList.where((data) {
                    return data['item'].toLowerCase().contains(searchKeyword) ||
                        data['item_name'].toLowerCase().contains(searchKeyword) ||
                        data['quantity'].toString().contains(searchKeyword) ||
                        data['price'].toString().contains(searchKeyword) ||
                        data['currency'].toLowerCase().contains(searchKeyword);
                  }).map((data) {
                    return DataRow(cells: [
                      DataCell(Text(data['id'].toString())),
                      DataCell(Text(data['item'])),
                      DataCell(Text(data['item_name'])),
                      DataCell(Text(data['quantity'].toString())),
                      DataCell(Text(data['price'].toString())),
                      DataCell(Text(data['currency'])),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Add edit functionality here
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  dataList.remove(data);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}