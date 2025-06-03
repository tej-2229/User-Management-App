# User-Management-App

# Flutter BLoC User Explorer
A Flutter application demonstrating clean architecture using the BLoC pattern, infinite scrolling, search functionality, pull-to-refresh, and offline caching. It fetches and displays user data from the DummyJSON Users API - (https://dummyjson.com/users).

## Features
- BLoC Pattern with clean separation of concerns
- Fetch users with infinite scrolling
- Search users by name
- View user details with associated posts and todos
- Pull-to-refresh to reload user data
- Offline caching using Hive

## Setup Instructions
1. Clone the repository
   git clone https://github.com/tej-2229/flutter_bloc_user_explorer.git
   cd flutter_bloc_user_explorer

2. Install dependencies
   flutter pub get

3. Run the app
   flutter run

4. (Optional): If you're running on a device/emulator for the first time, ensure it's properly configured via:
   flutter doctor

## Dependencies
- flutter_bloc
- hive
- hive_flutter
- http

## Project Structure
lib/
│
├── main.dart
├── src/
│   ├── app.dart
│   ├── bloc/                  # BLoC state management
│   │   ├── user/
│   │   │   ├── user_bloc.dart
│   │   │   ├── user_event.dart
│   │   │   └── user_state.dart
│   ├── data/                  # Repositories and data providers
│   │   ├── repositories/
│   │   │   └── user_repository.dart
│   ├── models/                # Data models
│   │   ├── user_model.dart
│   │   ├── post_model.dart
│   │   └── todo_model.dart
│   └── screens/               # UI screens
│       ├── user_list_screen.dart
│       └── user_detail_screen.dart

## Architecture Explanation
BLoC (Business Logic Component)
The app uses the BLoC pattern for state management to separate business logic from UI.
  - Events (UserEvent) trigger actions like fetching or refreshing users.
  - States (UserState) reflect the current UI condition (e.g., loading, loaded, error).
  - BLoC (UserBloc) processes incoming events, interacts with the repository, and yields new states.

Repository Pattern
UserRepository abstracts API and local cache interactions. It fetches user data from DummyJSON API and caches it using Hive for offline access.

Caching with Hive
Hive is used as a lightweight key-value storage system. Cached user data is retrieved when offline or when API calls fail.

Infinite Scrolling & Search
ScrollController loads more users when the bottom is reached.
A TextField listens for user input and dispatches a SearchUsers event.

