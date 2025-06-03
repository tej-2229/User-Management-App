import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/users/bloc/user_block.dart';
import 'package:user_management_app/features/users/bloc/user_event.dart';
import 'package:user_management_app/features/users/data/user_repository.dart';
import 'features/users/screens/user_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            )..add(FetchUsers()),
          ),
        ],
        child: MaterialApp(
          title: 'User App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const UserListScreen(),
        ),
      ),
    );
  }
}


