abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class RefreshUsers extends UserEvent {}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);
}
