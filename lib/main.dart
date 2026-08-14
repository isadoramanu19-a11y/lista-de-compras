import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_screen.dart';

// Controla o tema do aplicativo inteiro
final ValueNotifier<bool> temaEscuroNotifier = ValueNotifier<bool>(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega o tema salvo
  final prefs = await SharedPreferences.getInstance();

  temaEscuroNotifier.value =
      prefs.getBool('temaEscuro') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: temaEscuroNotifier,

      builder: (context, temaEscuro, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Lista de Compras',

          // =========================
          // TEMA CLARO
          // =========================
          theme: ThemeData(
            brightness: Brightness.light,

            scaffoldBackgroundColor:
                const Color.fromARGB(255, 211, 164, 223),

            colorScheme: ColorScheme.fromSeed(
              seedColor:
                  const Color.fromARGB(255, 211, 164, 223),
              brightness: Brightness.light,
            ),

            appBarTheme: const AppBarTheme(
              backgroundColor:
                  Color.fromARGB(255, 211, 164, 223),
              foregroundColor: Colors.black,
            ),

            cardTheme: const CardThemeData(
              color: Colors.white,
            ),

            iconTheme: const IconThemeData(
              color: Colors.black,
            ),

            useMaterial3: true,
          ),

          // =========================
          // TEMA ESCURO
          // =========================
          darkTheme: ThemeData(
            brightness: Brightness.dark,

            scaffoldBackgroundColor:
                const Color.fromARGB(255, 34, 33, 33),

            colorScheme: ColorScheme.fromSeed(
              seedColor:
                  const Color.fromARGB(255, 211, 164, 223),
              brightness: Brightness.dark,
            ),

            appBarTheme: const AppBarTheme(
              backgroundColor:
                  Color.fromARGB(255, 34, 33, 33),
              foregroundColor: Colors.white,
            ),

            cardTheme: const CardThemeData(
              color: Color.fromARGB(255, 48, 48, 48),
            ),

            iconTheme: const IconThemeData(
              color: Colors.white,
            ),

            useMaterial3: true,
          ),

          // Escolhe o tema
          themeMode: temaEscuro
              ? ThemeMode.dark
              : ThemeMode.light,

          home: const SplashScreen(),
        );
      },
    );
  }
}