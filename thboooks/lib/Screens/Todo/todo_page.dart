import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:thboooks/States/user_service.dart';
import 'package:thboooks/widget/app_progress_indicater.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TextEditingController todoController;

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController();
  }

  @override
  void dispose() {
    todoController.dispose();
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
              Color.fromARGB(255, 129, 191, 241)
            ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  SizedBox(width: 1.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 69, 85, 228),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.person_2_rounded,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pushNamed(context, '/profilepage');
                              },
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'TH Books',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/Settings');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text(
                        'APP Where u read BOOKS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      )),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_chart_outlined,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 70,
                      ),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/uploadbook');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Selector<UserService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showuserprogress, value.userprogresstext),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: value.item2)
                    : Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
