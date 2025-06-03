import 'package:user_management_app/features/users/data/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasMore;
  UserLoaded({required this.users, required this.hasMore});
}

class UserError extends UserState {
  final String error;
  UserError({required this.error});
}

