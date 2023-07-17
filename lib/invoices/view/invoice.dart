// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:invoice_ondgo/invoices/view/create_invoice.dart';

class InvoiceCreation extends StatefulWidget {
  const InvoiceCreation({Key? key}) : super(key: key);

  @override
  State<InvoiceCreation> createState() => _InvoiceCreationState();
}

class _InvoiceCreationState extends State<InvoiceCreation> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  void searchFunction() {
    setState(() {
      searchText = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF01497C)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "All Invoices",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Color(0xFF01497C),
          ),
        ),
      ),
      // drawer: DrawerPage(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),

            // Add your available stuffs widgets here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerInvoiceForm()
                //  onItemsCreated: () {
                //   // Handle items created callback
                //   print('Items Created!');
                // },
                ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xFF01497C),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
