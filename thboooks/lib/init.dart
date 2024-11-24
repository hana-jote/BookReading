import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:thboooks/Routes/routes.dart';
import 'package:thboooks/States/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitApp {
  static const String apiKeyAndroid = '988048F9-05BB-4C78-9877-D8C2FC812AB4';
  static const String apiKeyiOS = '6D4D44B3-97A0-430F-91DB-85DD39B419ED';
  static const String appID = 'CCCEC61A-966E-4801-A389-B280C89A0430';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      Navigator.popAndPushNamed(context, RouteManager.todoPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
