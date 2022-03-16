import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/models/product.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends  Bloc<ProductEvent, ProductState>{

  ProductBloc() : super(const ProductState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    //final Product product;
    if (event is GetAllEvent) {
      try {
        yield LoadingProduct();
        final data = await ApiProvider().fetchProducts();
        yield ProductState(products: data);
      } catch (ex){
        yield Failure(ex.toString());
      }
    } else if (event is CreateEvent) {
      try {
        yield LoadingProduct();
        dynamic formData;
        formData = {
          'atomicPrice': event.atomicPrice,
          'masterProductId': event.masterProductId,
          'name': event.name,
          'imageUrl': event.imageUrl,
          'categoryId': event.categoryId,
          'isDeleted': event.isDeleted,
        };
        await ApiProvider().createProduct(formData);
        yield SuccessCreate();
      } catch(ex) {
        yield Failure(ex.toString());
      }
    }
    // else if (event is  DeleteEvent) {
    //   try {
    //     yield LoadingDelete();
    //     await APIWeb().delete(UserRepository.delete(event.id));
    //     yield SuccessDelete();
    //   } catch(ex) {
    //     yield Failure(ex.toString());
    //   }
    // }
  }
}