import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_assign/models/user.dart';

class UserNotifer with ChangeNotifier {
  List<User> users = [];

  void initializeUsers() {
    List temp = const [
      User(id: 1, name: 'Dhruv Rathi', phone: '7059016847'),
      User(id: 2, name: 'Anupam Mittal', phone: '7059124751'),
      User(id: 3, name: 'Sachin Bansal', phone: '7059239975'),
      User(id: 4, name: 'Kunal Bansal', phone: '7059375850'),
      User(id: 5, name: 'Amitabh Bacchan', phone: '7059421078'),
      User(id: 6, name: 'Shah Rukh Khan', phone: '7059574062'),
      User(id: 7, name: 'Anil Kapoor', phone: '7059670206'),
      User(id: 8, name: 'Kapil Sharma', phone: '7059761648'),
      User(id: 9, name: 'Swami Ram Dev', phone: '7059823286'),
      User(id: 10, name: 'Khushal Rao', phone: '9602151363'),
    ];
    temp.forEach(((user) => users.add(user)));
    notifyListeners();
  }

  void sortUsers({bool sortByName = true, bool sortAcending = true}) {
    users.sort(
      (a, b) => sortByName
          ? (sortAcending ? a.name.compareTo(b.name) : b.name.compareTo(a.name))
          : (sortAcending
              ? a.phone.compareTo(b.phone)
              : b.phone.compareTo(a.phone)),
    );
    notifyListeners();
  }

  void addUser({required User user}) {
    users.add(user);
    notifyListeners();
  }

  void updateUser({required User user}) {
    final index = users.indexWhere((e) => e.id == user.id);
    if (index > -1) {
      users[index] = user;
      notifyListeners();
    }
  }
}

final userNotifer = ChangeNotifierProvider((ref) => UserNotifer());
