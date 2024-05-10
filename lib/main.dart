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
            SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  setState(() {
                    searchKeyword = value.toLowerCase();
                  });
                },
              ),
            ),

            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Padding(
                      padding: EdgeInsets.only(
                        left: 100,
                        right: 100
                      ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 500,
                              child: TextField(
                                controller: _itemController,
                                decoration: InputDecoration(
                                  labelText: 'Item',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (value == null || value.isEmpty) {
                                    // Hiển thị thông báo lỗi hoặc xử lý lỗi tại đây
                                    print('Please enter an item');
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 500,
                              child: TextField(
                                controller: _itemNameController,
                                decoration: InputDecoration(
                                  labelText: 'Item Name',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (value == null || value.isEmpty) {
                                    // Hiển thị thông báo lỗi hoặc xử lý lỗi tại đây
                                    print('Please enter an item');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: _quantityController,
                                decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    controller: _priceController,
                                    decoration: InputDecoration(labelText: 'Price',border: OutlineInputBorder(),),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 100,),
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    controller: _currencyController,
                                    decoration: InputDecoration(labelText: 'Currency',border: OutlineInputBorder(),),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                              child: Text('Add Item', style: TextStyle(color: Colors.deepOrange,),
                            )
                            )],
                        ),
                      ],
                    )
                  ),

            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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