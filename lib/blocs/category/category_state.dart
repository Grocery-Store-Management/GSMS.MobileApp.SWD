part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class Initial extends CategoryState {}

class Loading extends CategoryState  {}

class Loaded extends CategoryState  {
  final List<Category> categories;
  const Loaded(this.categories);
}

class Failure extends CategoryState {
  final String error;
  const Failure(this.error);
}