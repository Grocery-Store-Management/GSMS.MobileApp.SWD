part of 'import_order_bloc.dart';

abstract class ImportOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ImportOrderFetched extends ImportOrderEvent {}