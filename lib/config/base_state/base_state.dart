import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final String? errMsg;
  final T? data;

  const BaseState({this.isLoading = false, this.errMsg, this.data});

  BaseState<T> copyWith({bool? isLoading, String? errMsg, T? data}) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      errMsg: errMsg ?? this.errMsg,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errMsg, data];
}
