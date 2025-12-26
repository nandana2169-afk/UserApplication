import 'package:flutter/material.dart';
import 'package:user_application/model/model.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool isLoading = false;

  List<User> get users => _users;

  // Fetches initial users with a 2-second delay
  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _users = [
      User(name: 'Alice', phone: '99999', age: 30),
      User(name: 'Bob', phone: '99478', age: 30),
      User(name: 'Charly', phone: '994578', age: 30),
    ];

    isLoading = false;
    notifyListeners();
  }

  
  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  
  List<User> searchUsers(String query) {
    if (query.isEmpty) return _users;
    
    return _users.where((user) {
      final nameMatches = user.name.toLowerCase().contains(query.toLowerCase());
      final phoneMatches = user.phone.contains(query);
      return nameMatches || phoneMatches;
    }).toList();
  }

  
  List<User> filterByAge(int targetAge) {
    return _users.where((user) => user.age == targetAge).toList();
  }
}