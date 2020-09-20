part of 'track_bloc.dart';

abstract class TrackState extends Equatable {
  const TrackState();
}

class TrackInitial extends TrackState {
  @override
  List<Object> get props => [];
}

class Loading extends TrackState {
  @override
  List<Object> get props => [];
}

class Success extends TrackState {
  @override
  List<Object> get props => [];
}

class Failed extends TrackState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
