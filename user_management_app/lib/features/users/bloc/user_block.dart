import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/users/data/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  int skip = 0;
  final int limit = 10;
  bool isFetching = false;
  String currentQuery = '';

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (isFetching) return;
    isFetching = true;
    try {
      if (skip == 0) emit(UserLoading());
      final users = await userRepository.fetchUsers(skip: skip, limit: limit, query: currentQuery);
      skip += limit;
      emit(UserLoaded(users: users, hasMore: users.length == limit));
    } catch (e) {
      emit(UserError(error: e.toString()));
    } finally {
      isFetching = false;
    }
  }

  void _onRefreshUsers(RefreshUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      skip = 0;
      final users = await userRepository.fetchUsers(skip: skip, limit: limit, query: currentQuery);
      skip += limit;
      emit(UserLoaded(users: users, hasMore: users.length == limit));
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      currentQuery = event.query;
      skip = 0;
      final users = await userRepository.fetchUsers(query: currentQuery);
      emit(UserLoaded(users: users, hasMore: false));
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }
}
