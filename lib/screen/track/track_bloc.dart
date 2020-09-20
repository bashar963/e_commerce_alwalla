import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackBloc() : super(TrackInitial());

  @override
  Stream<TrackState> mapEventToState(
    TrackEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
