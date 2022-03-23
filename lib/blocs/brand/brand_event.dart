part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends BrandEvent {}

class GetIdEvent extends BrandEvent{
  final String getId;
  GetIdEvent({required this.getId});
}

class CreateEvent extends BrandEvent{
  final String? brandName;
  CreateEvent({required this.brandName});
}