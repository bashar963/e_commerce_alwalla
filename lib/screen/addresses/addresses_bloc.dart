import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial());

  @override
  Stream<AddressesState> mapEventToState(
    AddressesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
