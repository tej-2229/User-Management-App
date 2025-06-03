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
   https://github.com/tej-2229/User-Management-App.git
   cd flutter_bloc_user_explorer

3. Install dependencies
   flutter pub get

4. Run the app
   flutter run

5. (Optional): If you're running on a device/emulator for the first time, ensure it's properly configured via:
   flutter doctor

## Dependencies
- flutter_bloc
- hive
- hive_flutter
- http

## Project Structure
lib/
 - main.dart
 - app.dart
 - bloc_observer.dart
 - features/
   - posts/
     - data/
       post.dart
       todo.dart  
   - users/
     - bloc/
       - user_block
       - user_event
       - user_state
     - data/
       - user_model.dart
       - user_repository.dart
     - screens/
       - user_list_screen.dart
       - user_detail_screen.dart

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

