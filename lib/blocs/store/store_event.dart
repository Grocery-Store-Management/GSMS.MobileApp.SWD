part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends StoreEvent {}

class GetIdEvent extends StoreEvent{
  final String getId;
  GetIdEvent({required this.getId});
}