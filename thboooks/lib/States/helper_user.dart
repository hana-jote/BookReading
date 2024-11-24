import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thboooks/Routes/routes.dart';
import 'package:thboooks/States/user_service.dart';
import 'package:thboooks/widget/dialogs.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || name.isEmpty || password.isEmpty) {
    showSnackBar(context, 'please enter the reqired informations');
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({
        'name': name.trim(),
      });
    String result = await context.read<UserService>().createUser(user);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'New user successfully created');
      Navigator.pop(context);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'please enter the reqired informations');
  } else {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      Navigator.of(context).popAndPushNamed(RouteManager.todoPage);
    }
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context, 'please enter the email');
  } else {
    String result =
        await context.read<UserService>().resetPassword(email.trim());
    if (result == 'OK') {
      showSnackBar(context, 'succcessfully sent, check your email ');
    } else {
      showSnackBar(context, result);
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();
  if (result == 'OK') {
    context.read<UserService>().setcurrentusernull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}
