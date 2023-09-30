import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/provider/Markerprovider.dart';
import 'package:flutter_application_1/services/provider/NightMode.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NightModeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ChangeNotifierProvider(create: (_) => MarkerProvider())
        ],
        child: Builder(builder: (BuildContext context) {
          final nightProvider = Provider.of<NightModeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: nightProvider.thememode,
            theme: ThemeData(
                primarySwatch: const MaterialColor(0xFF00BB86, {
              50: Color(0xFFE0F2F1),
              100: Color(0xFFB2DFDB),
              200: Color(0xFF80CBC4),
              300: Color(0xFF4DB6AC),
              400: Color(0xFF26A69A),
              500: Color(0xFF009688),
              600: Color(0xFF00897B),
              700: Color(0xFF00796B),
              800: Color(0xFF00695C),
              900: Color(0xFF004D40),
            })),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color.fromARGB(255, 29, 1, 35)),
            onGenerateRoute: Routes.generateRoutes,
            initialRoute: RouteName.loginview,
          );
        }));
  }
}
