// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:invoice_ondgo/item/model/item_model.dart';

// class InvoiceCubit extends Cubit<List<ItemListModel>> {
//   InvoiceCubit() : super([]);

//   Future<void> fetchItemList() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//           'https://invoice-generator-walure-tap.azurewebsites.net/api/Items/Get-Items',
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         final List<ItemListModel> itemList = List.of(data['payload'])
//             .map((e) => ItemListModel.fromResponse(ItemListResponse.fromJson(e)))
//             .toList();

//         emit(itemList);
//       } else {
//         throw Exception("Failed to fetch item list");
//       }
//     } catch (e) {
//       throw Exception("Failed to fetch item list: $e");
//     }
//   }
// }
