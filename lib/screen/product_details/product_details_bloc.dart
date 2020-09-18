import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial());

  @override
  Stream<ProductDetailsState> mapEventToState(
    ProductDetailsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
