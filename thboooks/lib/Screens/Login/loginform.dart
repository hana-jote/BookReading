import 'package:provider/provider.dart';
import 'package:thboooks/Routes/routes.dart';
import 'package:thboooks/States/helper_user.dart';
import 'package:thboooks/States/user_service.dart';
import 'package:thboooks/widget/app_progress_indicater.dart';
import 'package:thboooks/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 10, 10, 10)),
                      ),
                    ),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: usernameController,
                      labelText: 'Please enter email address',
                    ),
                    AppTextField(
                      hideText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      labelText: 'Please enter your password',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          loginUserInUI(context,
                              email: usernameController.text,
                              password: passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Color.fromARGB(255, 253, 252, 252),
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteManager.registerPage);
                      },
                      child: const Text(
                        'Register a new User',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15.0),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        resetPasswordInUI(context,
                            email: usernameController.text);
                      },
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Selector<UserService, Tuple2>(
                selector: (context, value) =>
                    Tuple2(value.showuserprogress, value.userprogresstext),
                builder: (context, value, child) {
                  return value.item1
                      ? AppProgressIndicator(text: '${value.item2}')
                      : Container();
                })
          ],
        ),
      ),
    );
  }
}
