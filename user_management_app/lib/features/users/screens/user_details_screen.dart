// src/screens/user_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:user_management_app/features/posts/data/post.dart';
import 'package:user_management_app/features/posts/data/todo.dart';
import 'package:user_management_app/features/users/data/user_model.dart';
import 'package:user_management_app/features/users/data/user_repository.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _userRepo = UserRepository();
  List<Post> _posts = [];
  List<Todo> _todos = [];
  bool _loading = true;
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final posts = await _userRepo.fetchUserPosts(widget.user.id);
      final todos = await _userRepo.fetchUserTodos(widget.user.id);
      setState(() {
        _posts = posts;
        _todos = todos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  void _addPost() {
    final title = _titleController.text;
    final body = _bodyController.text;
    if (title.isNotEmpty && body.isNotEmpty) {
      setState(() {
        _posts.insert(0, Post(id: 9999, title: title, body: body));
        _titleController.clear();
        _bodyController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.user.firstName} ${widget.user.lastName}')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${widget.user.email}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  const Text('Create Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
                  TextField(controller: _bodyController, decoration: const InputDecoration(labelText: 'Body')),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: _addPost, child: const Text('Add Post')),
                  const SizedBox(height: 16),
                  const Text('Posts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ..._posts.map((post) => ListTile(title: Text(post.title), subtitle: Text(post.body))),
                  const SizedBox(height: 16),
                  const Text('Todos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ..._todos.map((todo) => CheckboxListTile(
                        title: Text(todo.todo),
                        value: todo.completed,
                        onChanged: null,
                      )),
                ],
              ),
            ),
    );
  }
}
