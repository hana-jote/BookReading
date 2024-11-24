import 'package:thboooks/routes/routes.dart';
import 'package:thboooks/States/todo_service.dart';
import 'package:thboooks/States/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoService(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteManager.loadingPage,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
