part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class Initial extends StoreState {}

class Loading extends StoreState  {}

class Loaded extends StoreState  {
  final List<Store> stores;
  final List<String> brandName;
  const Loaded(this.stores, this.brandName);
}

class Failure extends StoreState {
  final String error;
  const Failure(this.error);
}
