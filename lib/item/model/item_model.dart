import 'package:equatable/equatable.dart';

class ItemListModel extends Equatable {
  String id;
  String itemName;
  String description;
  num unitPrice;
  num taxRate;

  ItemListModel(
      {required this.id,
      required this.itemName,
      required this.description,
      required this.taxRate,
      required this.unitPrice});

  ItemListModel.fromResponse(ItemListResponse r)
      : id = r.id ?? '',
        itemName = r.itemName ?? '',
        description = r.description ?? '',
        unitPrice = r.unitPrice ?? 0,
        taxRate = r.taxRate ?? 0;

  @override
  List<Object?> get props => [id, itemName, description, taxRate, unitPrice];

  @override
  String toString() {
    return 'ItemListModel('
        'id: $id, '
        'unitPrice: $unitPrice, '
        'taxRate: $taxRate, '
        'itemName: $itemName)';
  }
}

class ItemListResponse {
  String? id;
  String? itemName;
  String? description;
  num? unitPrice;
  num? taxRate;

  ItemListResponse(
      {this.id, this.itemName, this.description, this.unitPrice, this.taxRate});

  ItemListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    description = json['description'];
    unitPrice = json['unitPrice'];
    taxRate = json['taxRate'];
  }
  @override
  String toString() {
    return 'ItemListResponse('
        'id: $id, '
        'unitPrice: $unitPrice, '
        'taxRate: $taxRate, '
        'itemName: $itemName)';
  }
}
