part of 'import_order_bloc.dart';

abstract class ImportOrderEvent extends Equatable {
  const ImportOrderEvent();

  @override
  List<Object?> get props => [];
}

class ImportOrderFetched extends ImportOrderEvent {}