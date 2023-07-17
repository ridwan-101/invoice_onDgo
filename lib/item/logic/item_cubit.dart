// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:invoice_ondgo/item/logic/item_state.dart';
import 'package:invoice_ondgo/item/model/item_model.dart';
import 'package:invoice_ondgo/widget/status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(
    this.context,
  ) : super(const ItemState(itemList: []));

  TextEditingController nameController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();
  BuildContext context;
  String? token;
  List<ItemListModel> itemList = [];

  createItem(itemName, description, unitPrice, taxRate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(state.copyWith(status: Status.loading));
    final body = {
      'itemName': itemName,
      'description': description,
      'unitPrice': unitPrice,
      'taxRate': taxRate,
    };
    final token = prefs.getString('tokenn');
    final headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Authorization': "Bearer $token",
    };

    try {
      Response response = await post(
        Uri.parse(
          'https://invoice-generator-walure-tap.azurewebsites.net/api/Items/Create-Items',
        ),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item Created'),
            duration: Duration(seconds: 2),
          ),
        );
        print(data);

        print('Item Created');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item Creation Failed'),
            duration: Duration(seconds: 2),
          ),
        );
        print('Item Creation Failed');
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
    }
  }

  Future<List<ItemListModel>> fetchItemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final token = prefs.getString('tokenn');

      final headers = {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': "Bearer $token",
      };

      final response = await get(
        Uri.parse(
          'https://invoice-generator-walure-tap.azurewebsites.net/api/Items/Get-Items',
        ),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = List.of(data['payload'])
            .map((e) => ItemListResponse.fromJson(e))
            .toList();
      
        final itemList =
            list.map((e) => ItemListModel.fromResponse(e)).toList();
        return itemList;
      } else {
        print(response.statusCode);
        throw Exception("Failed");
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception("Failed");
    }
  }

  Future<void> deleteItem(String itemId) async {
    emit(state.copyWith(status: Status.loading));

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('tokenn');
      final headers = {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': "Bearer $token",
      };

      final response = await delete(
        Uri.parse(
          'https://invoice-generator-walure-tap.azurewebsites.net/api/Items/Delete-Item/$itemId',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item deleted'),
            duration: Duration(seconds: 2),
          ),
        );
        // Refresh the item list after deleting an item
        await fetchItemList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete item'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while deleting the item'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
