import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final double _initialLat;
  final double _initialLong;

  MapBloc(this._initialLat, this._initialLong)
      : super(
           MapState(
            latitude: _initialLat,
            longitude: _initialLong,
          ),
        ) {
    on<ShowLocation>(_onShowLocation);
  }

  void _onShowLocation(
    ShowLocation event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
      ),
    );
  }
}
