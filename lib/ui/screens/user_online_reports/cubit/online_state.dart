part of 'online_cubit.dart';

@immutable
abstract class OnlineState {}

class OnlineInitial extends OnlineState {}
class GetAllOnlineLoading extends OnlineState {}
class GetAllOnlineSuccess extends OnlineState {}
class GetAllOnlineError extends OnlineState {}
