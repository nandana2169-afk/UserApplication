import 'package:flutter/material.dart';
import 'package:user_application/model/model.dart';

class UserController extends ChangeNotifier {
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  bool isLoading = false;

  List<User> get users => _filteredUsers;

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _allUsers = [
      User(
        name: 'Martin Dokidis',
        phone: '9847012345',
        age: 34,
        image: 'assets/userone.png',
      ),
      User(
        name: 'Mariyn Rosser',
        phone: '9947811223',
        age: 34,
        image: 'assets/usertwo.png',
      ),
      User(
        name: 'Cristofer Lipshutz',
        phone: '9945784455',
        age: 34,
        image: 'assets/userthree.png',
      ),
      User(
        name: 'Wison Botosh',
        phone: '8877665544',
        age: 34,
        image: 'assets/userfour.png',
      ),
      User(
        name: 'Ankita Saris',
        phone: '9847012345',
        age: 34,
        image: 'assets/userfive.png',
      ),
      User(
        name: 'Philip Gouse',
        phone: '9847012345',
        age: 34,
        image: 'assets/usersix.png',
      ),
      User(
        name: 'Wilson Bergson',
        phone: '9847012345',
        age: 34,
        image: 'assets/userseven.png',
      ),
    ];

    _filteredUsers = List.from(_allUsers);
    isLoading = false;
    notifyListeners();
  }

  void searchUser(String query) {
    if (query.isEmpty) {
      _filteredUsers = List.from(_allUsers);
    } else {
      _filteredUsers = _allUsers.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.phone.contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void filterByAge(String category) {
    if (category == "Older") {
      _filteredUsers = _allUsers.where((u) => u.age >= 60).toList();
    } else if (category == "Younger") {
      _filteredUsers = _allUsers.where((u) => u.age < 60).toList();
    } else {
      _filteredUsers = List.from(_allUsers);
    }
    notifyListeners();
  }
  

  void addUser(User user) {
    _allUsers.insert(0, user);
    _filteredUsers = List.from(_allUsers);
    notifyListeners();
  }
}
