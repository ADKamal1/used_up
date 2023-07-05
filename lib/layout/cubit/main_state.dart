part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeBottomNavigationIndex extends MainState {}
class SetUpPerrmisions extends MainState {}
class GetSeachScreen extends MainState {}


class GetAllUsersLoading extends MainState {}
class GetAllUsersSuccess extends MainState {}


class GetActiveUsersLoading extends MainState {}
class GetActiveUsersSuccess extends MainState {}

class BanUserSuccess extends MainState {}


class CreateUserError extends MainState{
  String error;
  CreateUserError(this.error);
}
class CreateUserSucess extends MainState{}
class CreateUserLoading extends MainState{}

class SeachListState extends MainState{}

