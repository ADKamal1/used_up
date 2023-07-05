part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class GetUserLocationLoading extends MapState {}
class GetUserLocationSuccess extends MapState {}
class MapControllerSuccess extends MapState {}