import 'package:provider/provider.dart';
import 'package:thboooks/States/helper_user.dart';
import 'package:thboooks/States/user_service.dart';
import 'package:thboooks/widget/app_progress_indicater.dart';
import 'package:thboooks/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'TH Books',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    Focus(
                      onFocusChange: (value) async {
                        if (!value) {
                          context.read<UserService>().checkIfUserExists(
                              usernameController.text.trim());
                        }
                      },
                      child: AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: usernameController,
                        labelText: 'Please enter your email address',
                      ),
                    ),
                    Selector<UserService, bool>(
                        selector: (context, value) => value.userExists,
                        builder: (context, value, child) {
                          return value
                              ? const Text(
                                  'username exists.Please choose another name ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              : Container();
                        }),
                    AppTextField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      labelText: 'Please enter your name',
                    ),
                    AppTextField(
                      hideText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      labelText: 'Please enter your password',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                        onPressed: () {
                          createNewUserInUI(context,
                              email: usernameController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim());
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
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
            },
          )
        ],
      ),
    );
  }
}
