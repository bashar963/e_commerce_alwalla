import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loyalty_event.dart';
part 'loyalty_state.dart';

class LoyaltyBloc extends Bloc<LoyaltyEvent, LoyaltyState> {
  LoyaltyBloc() : super(LoyaltyInitial());

  @override
  Stream<LoyaltyState> mapEventToState(
    LoyaltyEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
