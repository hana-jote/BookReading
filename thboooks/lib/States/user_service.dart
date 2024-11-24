import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:thboooks/Models/todo_entry.dart';

class UserService with ChangeNotifier {
  BackendlessUser? _currentuser;
  BackendlessUser? get currentuser => _currentuser;

  void setcurrentusernull() {
    _currentuser = null;
  }

  bool _userExists = false;
  bool get userExists => _userExists;
  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  bool _showuserprogress = false;
  bool get showuserprogress => _showuserprogress;

  String _userprogresstext = '';
  String get userprogresstext => _userprogresstext;

  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showuserprogress = true;
    _userprogresstext = 'resetting password';
    notifyListeners();
    await Backendless.userService
        .restorePassword(username)
        .onError((error, StackTrace) {
      result = getHumanReadableError(error.toString());
    });
    _showuserprogress = false;
    notifyListeners();

    return result;
  }

  Future<String> loginUser(String username, String password) async {
    String result = 'OK';
    _showuserprogress = true;
    _userprogresstext = 'loging in ... Please wait...';
    notifyListeners();
    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, StackTrace) {
      result = getHumanReadableError(error.toString());
      return null;
    });
    if (user != null) {
      _currentuser = user;
    }
    _showuserprogress = false;
    notifyListeners();

    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';
    _showuserprogress = true;
    _userprogresstext = 'Signing out';
    notifyListeners();

    await Backendless.userService.logout().onError(
      (error, stackTrace) {
        result = error.toString();
      },
    );
    _showuserprogress = false;
    notifyListeners();

    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validlogin = await Backendless.userService.isValidLogin().onError(
      (error, stackTrace) {
        result = error.toString();
        return null;
      },
    );
    if (validlogin != null && validlogin) {
      String? currentuserobjectid = await Backendless.userService
          .loggedInUser()
          .onError((error, StackTrace) {
        result = error.toString();
        return null;
      });
      if (currentuserobjectid != null) {
        Map<dynamic, dynamic>? mapofcurrentuser = await Backendless.data
            .of('Users')
            .findById(currentuserobjectid)
            .onError((error, StackTrace) {
          result = error.toString();
          return null;
        });
        if (mapofcurrentuser != null) {
          _currentuser = BackendlessUser.fromJson(mapofcurrentuser);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email ='$username' ";
    await Backendless.data
        .withClass<Backendless>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.isEmpty) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, StackTrace) {
      print(error.toString());
    });
  }

  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';
    _showuserprogress = true;
    _userprogresstext = 'creating a new user ... Please wait...';
    notifyListeners();
    try {
      await Backendless.userService.register(user);
      TodoEntry emptyEntry = TodoEntry(readers: {}, username: user.email);
      await Backendless.data
          .of('TodoEntry')
          .save(emptyEntry.toJson())
          .onError((error, StackTrace) {
        result = error.toString();
        return null;
      });
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showuserprogress = false;
    notifyListeners();
    return result;
  }
}

String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('User already exists')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Please check your username or password. The combination do not match any entry in our database.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
}
