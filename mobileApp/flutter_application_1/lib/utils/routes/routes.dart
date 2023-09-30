import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/bookbus/bookbusoneicon.dart';
import 'package:flutter_application_1/view/bookbus/finallybookbus.dart';
import 'package:flutter_application_1/view/viewroutes/Viewbusview.dart';
import 'package:flutter_application_1/view/bookbus/bookbusfrom.dart';
import 'package:flutter_application_1/view/bookbusview.dart';
import 'package:flutter_application_1/view/viewroutes/busone.dart';
import 'package:flutter_application_1/view/viewroutes/busthree.dart';
import 'package:flutter_application_1/view/viewroutes/bustwo.dart';
import 'package:flutter_application_1/view/demos/nboarding_screen.dart';
import 'package:flutter_application_1/view/homeview.dart';
import 'package:flutter_application_1/view/Auths/loginview.dart';
import 'package:flutter_application_1/view/Auths/signupview.dart';
import 'package:flutter_application_1/view/Auths/userdetails.dart';

class RouteName {
  static const String loginview = "LoginView";
  static const String signupview = "SignupView";
  static const String homeview = "HomeVIew";
  static const String userdetailsview = "UserDetailsView";
  static const String onboardingview = "OnboardingScreen";
  static const String viewbusview = "MapView";
  static const String busoneview = "BusOneView";
  static const String bustwoview = "BusTwoView";
  static const String busthreeview = "BusThreeView";
  static const String bookbusview = "BookBusView";
  static const String bookbusfromhome = "BookSearchFromHome";
  static const String bookbusoneview = "BookBusOneView";
  static const String finallybookbus = "FinallyBookBus";
}

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.loginview:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RouteName.signupview:
        return MaterialPageRoute(builder: (context) => const SIgnupView());
      case RouteName.homeview:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case RouteName.userdetailsview:
        return MaterialPageRoute(builder: (context) => const UserDetailsView());
      case RouteName.onboardingview:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case RouteName.viewbusview:
        return MaterialPageRoute(builder: (context) => const ViewBusView());
      case RouteName.busoneview:
        return MaterialPageRoute(builder: (context) => const BusOne());
      case RouteName.bustwoview:
        return MaterialPageRoute(builder: (context) => const BusTwo());
      case RouteName.busthreeview:
        return MaterialPageRoute(builder: (context) => const BusThree());
      case RouteName.bookbusview:
        return MaterialPageRoute(builder: (context) => BookBusView());
      case RouteName.bookbusfromhome:
        return MaterialPageRoute(builder: (context) => BusSearchPage());
      case RouteName.bookbusoneview:
        return MaterialPageRoute(builder: (context) => const BookBusOne());
      case RouteName.finallybookbus:
        return MaterialPageRoute(builder: (context) => BusBookingPage());
      // case RouteName.mapview:
      //   return MaterialPageRoute(builder: (context) => const MapView());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No Page Routes Defined"),
            ),
          );
        });
    }
  }
}
