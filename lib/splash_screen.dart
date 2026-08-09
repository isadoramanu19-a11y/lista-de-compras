import 'dart:async';
import 'package:flutter/material.dart';
import 'listacompras.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ListaCompras(),
        ),
      );
    });
  }

  @override
 Widget build(BuildContext context) {
  return const Scaffold(
    backgroundColor: Color.fromARGB(255, 211, 164, 223),
    body: Center(
      child: Text(
        "Bem-vindo(a) à Lista de Compras",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 50,
        ),
      ),
    ),
  );
}
  }
