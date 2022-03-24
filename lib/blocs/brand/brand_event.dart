part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable  {

  @override
  List<Object> get props => [];
}

class GetAllEvent extends BrandEvent {
  final int page;
  GetAllEvent({required this.page});
}

class GetIdEvent extends BrandEvent{
  final String getId;
  GetIdEvent({required this.getId});
}

class SortByDateEvent extends BrandEvent{
  int? sort;
  SortByDateEvent({this.sort});
}

class CreateEvent extends BrandEvent{
  final String? brandName;
  CreateEvent({required this.brandName});
}

class UpdateEvent extends BrandEvent{
  final Brand brand;
  UpdateEvent({required this.brand});
}

class DeleteEvent extends BrandEvent{
  final String getId;
  DeleteEvent({required this.getId});
}