part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object?> get props => [];
}

class Initial extends BrandState {}

class Loading extends BrandState  {}

class Loaded extends BrandState  {
  final List<Brand> brands;
  const Loaded(this.brands);
}

class Failure extends BrandState {
  final String error;
  const Failure(this.error);
}
