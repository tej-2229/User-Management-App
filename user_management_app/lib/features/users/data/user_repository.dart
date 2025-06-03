import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:user_management_app/features/posts/data/post.dart';
import 'package:user_management_app/features/posts/data/todo.dart';
import 'package:user_management_app/features/users/data/user_model.dart';

class UserRepository {
  final String baseUrl = 'https://dummyjson.com';
  final Box userBox = Hive.box('userBox');

  Future<List<User>> fetchUsers({int limit = 10, int skip = 0, String query = ''}) async {
    final cacheKey = 'users_$query';
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/search?q=$query&limit=$limit&skip=$skip'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final users = (body['users'] as List).map((e) => User.fromJson(e)).toList();
  
        userBox.put(cacheKey, body['users']);
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      
      final cachedUsers = userBox.get(cacheKey);
      if (cachedUsers != null) {
        return (cachedUsers as List).map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load users and no cache available');
      }
    }
  }

  Future<List<Post>> fetchUserPosts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return (body['posts'] as List).map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Todo>> fetchUserTodos(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return (body['todos'] as List).map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
