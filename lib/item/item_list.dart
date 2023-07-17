// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_ondgo/item/create_item.dart';
import 'package:invoice_ondgo/item/logic/item_cubit.dart';
import 'package:invoice_ondgo/item/model/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Map<String, String>> items = [];
  String searchText = '';

  List<ItemListModel>? itemList;
  List<ItemListModel>? filteredItemList;

  Future<void> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedGoods = prefs.getString('goodsList');
    if (storedGoods != null) {
      setState(() {
        items = (json.decode(storedGoods) as List<dynamic>)
            .map((item) => Map<String, String>.from(item))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchList();
    loadItems();
  }

  Future<void> fetchList() async {
    final fetchedItemList = await context.read<ItemCubit>().fetchItemList();
    if (mounted) {
      setState(() {
        itemList = fetchedItemList;
        filteredItemList = fetchedItemList;
      });
    }
  }

  void filterItemList() {
    if (searchText.isEmpty) {
      setState(() {
        filteredItemList = itemList;
      });
    } else {
      setState(() {
        filteredItemList = itemList
            ?.where((item) =>
                item.itemName.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      });
    }
  }

  Future<void> _deleteItem(BuildContext context, String itemId) async {
    await context.read<ItemCubit>().deleteItem(itemId);
    // Update the list of items after deletion
    await fetchList();
    filterItemList();
  }

  void _confirmDeleteItem(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteItem(context, itemId);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01497C),
        automaticallyImplyLeading: false,
        title: const Text(
          '     Items',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  hintText: 'Search',
                  prefixIcon: IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      filterItemList();
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                    filterItemList();
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (filteredItemList == null || filteredItemList!.isEmpty)
              Container(
                height: 500,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/no_item.png'),
                      SizedBox(height: 10),
                      Text(
                        'No items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF013A63),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: fetchList,
                  child: ListView.builder(
                    itemCount: filteredItemList!.length,
                    itemBuilder: (context, index) {
                      final item = filteredItemList![index];
                      return Card(
                        child: ListTile(
                          title: Text(item.itemName),
                          subtitle: Text(
                            'Unit Price: ${item.unitPrice.toString()}, Tax Rate: ${item.taxRate.toString()}',
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDeleteItem(context, item.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 150,
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF01497C),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ItemCubit(context),
                  child: GoodsForm(),
                ),
              ),
            );
            if (mounted) {
              await fetchList();
              filterItemList();
            }
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Add Items',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
