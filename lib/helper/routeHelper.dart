import 'package:doctorapp/screens/login/index.dart';
import 'package:doctorapp/screens/signUp/index.dart';
import 'package:get/get.dart';

import '../screens/splash/index.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/signUp';

  static String getSplash() => '$splash';
  static String getLogin() => '$login';
  static String getSignUp() => '$signUp';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const Splash()),
    GetPage(name: login, page: () =>   SignInScreen()),
    GetPage(name: signUp, page: () => SignupScreen()),
  ];
}
