// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_ondgo/invoices/view/widgets/pdf_generator.dart';
import 'package:invoice_ondgo/item/model/item_model.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Goodform {
  final String itemName;
  final num unitPrice;
  final String desc;
  final num tax;

  Goodform(this.itemName, this.unitPrice, this.tax, this.desc);
}

class CustomerInvoiceForm extends StatefulWidget {
  @override
  _CustomerInvoiceFormState createState() => _CustomerInvoiceFormState();
}

class _CustomerInvoiceFormState extends State<CustomerInvoiceForm> {
  String? file;

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerNumberController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerNoteController = TextEditingController();
  DateTime? dueDate;

  List<ItemListModel> itemList = [];
  List<ItemListModel> selectedItems = [];
  List<int?> quantities = [];

  String? buisnessName;
  String? phoneNumber;
  String? businessLocation;
  String? statee;
  String? accountName;
  String? bank;
  String? accountNumber;
  String? currency;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateCustomerName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a customer name';
    }
    return null;
  }

  String? _validateCustomerNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a customer number';
    } else if (value.length != 11) {
      return 'Customer number should be 11 digits long';
    } else if (int.tryParse(value) == null) {
      return 'Customer number should only contain numbers';
    }
    return null;
  }

  String? _validateCustomerAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a customer address';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    loadData();
    fetchBusinessDetails();
  }

  void _deleteItem(int index) {
    setState(() {
      selectedItems.removeAt(index);
      quantities.removeAt(index);
    });
  }

  Future<void> fetchBusinessDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final busiId = prefs.getString('businessId');
      final token = prefs.getString('tokenn');
      final headers = {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': "Bearer $token",
      };

      final response = await http.get(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/Business/Get-Business/$busiId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          buisnessName = data['payload']['businessName'];
          phoneNumber = data['payload']['phoneNumber'];
          businessLocation = data['payload']['businessLocation'];
          statee = data['payload']['state'];
          accountName = data['payload']['accountName'];
          bank = data['payload']['bank'];
          accountNumber = data['payload']['accountNumber'];
        });
      } else {
        print(
            'Failed to fetch business details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final token = prefs.getString('tokenn');

      final response = await http.get(
        Uri.parse(
            'https://invoice-generator-walure-tap.azurewebsites.net/api/Items/Get-Items'),
        headers: {
          'Content-type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = List.of(data['payload'])
            .map((e) => ItemListResponse.fromJson(e))
            .toList();

        final items = list.map((e) => ItemListModel.fromResponse(e)).toList();

        // final Map<String, dynamic> data = jsonDecode(response.body);
        // final List<dynamic> payload = data['payload'];

        // List<Goodform> items =

        // payload
        //     .map((item) => Goodform(
        //           item['itemName'] as String,
        //           item['unitPrice'] as num,
        //           item['tax'] as num,
        //           item['desc'] as String,
        //         ))
        //     .toList();

        setState(() {
          itemList = items;
          print(itemList);
        });
      } else if (response.statusCode == 401) {
        print('Unauthorized: Please check your authentication credentials.');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01497C),
        title: const Text(
          "New Invoice",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Customer Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: customerNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateCustomerName,
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Customer Number",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: customerNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateCustomerNumber,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Customer Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: customerAddressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateCustomerAddress,
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Due Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                InkWell(
                  onTap: () => _selectDueDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dueDate != null
                              ? "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}"
                              : 'Select a due date',
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: null,
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue != null) {
                        print(itemList);
                        selectedItems = itemList.where((item) {
                          item.itemName == newValue;
                          selectedItems.add(item);
                          return true;
                        }).toList();

                        quantities.add(0); // Add initial quantity of 0
                        print(selectedItems);
                      }
                    });
                  },
                  items: itemList.map((item) {
                    return DropdownMenuItem<String>(
                      value: item.itemName,
                      child: Text(item.itemName),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      if (index < quantities.length) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedItems[index].itemName),
                              const SizedBox(width: 16.0),
                              Row(
                                children: [
                                  const Text('Quantity'),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: 50,
                                    height: 50,
                                    child: TextFormField(
                                      initialValue:
                                          quantities[index].toString(),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign
                                          .center, // Align input text in the center
                                      decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the border around TextFormField
                                        contentPadding: EdgeInsets
                                            .zero, // Remove extra padding
                                      ),
                                      onSaved: (val) {},
                                      onChanged: (value) {
                                        quantities[index] =
                                            int.tryParse(value) ?? 0;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteItem(index),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Note",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: customerNoteController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateCustomerAddress,
                ),
                const SizedBox(height: 46.0),
                InkWell(
                  onTap: () async {
                    file = await GeneratePdf().generatePDF(
                      customerName: customerNameController.text,
                      customerAddress: customerAddressController.text,
                      customerNum: customerNumberController.text,
                      customerNote: customerNoteController.text,
                      dueDate: dueDate!,
                      items: selectedItems,
                      accountName: accountName,
                      accountNumber: accountNumber,
                      bank: bank,
                      buisnessName: buisnessName,
                      businessLocation: businessLocation,
                      phoneNumber: phoneNumber,
                      state: statee,
                      quantities: quantities,
                      currency: currency,
                    );

                    await OpenFile.open(file);

                    // await GeneratePdf().openPDFFile(file!);
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xFF01497C),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked;
      });
    }
  }
}
