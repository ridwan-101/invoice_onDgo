import 'package:equatable/equatable.dart';
import 'package:invoice_ondgo/item/model/item_model.dart';
import 'package:invoice_ondgo/widget/status.dart';

class ItemState extends Equatable {
  const ItemState({
    this.status = Status.initial,
    this.message = '',
    this.itemList = const [],
    this.loadingg = false,
    this.imageLoading = false,
  });

//

  final Status status;
  final String message;
  final List<ItemListModel> itemList;
  final bool loadingg;
  final bool imageLoading;

  bool get error => status == Status.error;

  bool get loading => status == Status.loading;

  bool get success => status == Status.success;

  ItemState copyWith({
    Status? status,
    String? message,
    bool? isFileLoaded,
    bool? imageLoading,
  }) {
    return ItemState(
      status: status ?? this.status,
      message: message ?? '',
      loadingg: isFileLoaded ?? this.loadingg,
      imageLoading: imageLoading ?? this.imageLoading,
    );
  }

  @override
  List<Object> get props => [status, message, loadingg, imageLoading];

  @override
  String toString() {
    return 'ItemState('
        'status: $status, '
        'isFileLoaded: $loadingg, '
        'imageLoading: $imageLoading, '
        'message: $message, '
        ')';
  }
}
