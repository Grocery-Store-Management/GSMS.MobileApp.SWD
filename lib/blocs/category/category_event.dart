part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends CategoryEvent {}

class GetIdEvent extends CategoryEvent{
  final String getId;
  GetIdEvent({required this.getId});
}