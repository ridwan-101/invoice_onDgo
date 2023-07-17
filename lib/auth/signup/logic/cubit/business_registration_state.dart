part of 'business_registration_cubit.dart';

@immutable



class BusinessRegistrationState extends Equatable {
  const BusinessRegistrationState({
    this.status = Status.initial,
    this.message = '',
    this.loadingg = false,
    this.imageLoading = false,
  });

//

  final Status status;
  final String message;
  final bool loadingg;
  final bool imageLoading;

  bool get error => status == Status.error;

  bool get loading => status == Status.loading;

  bool get success => status == Status.success;

  BusinessRegistrationState copyWith({
    Status? status,
    String? message,
    bool? isFileLoaded,
    bool? imageLoading,
  }) {
    return BusinessRegistrationState(
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
    return 'ProductState('
        'status: $status, '
        'isFileLoaded: $loadingg, '
        'imageLoading: $imageLoading, '
        'message: $message, '
        ')';
  }
}
