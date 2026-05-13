import 'package:flutter/material.dart';
import 'adicionar.dart';

void main() {
  runApp(const MyApp(
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: ElevatedButton(

          child: Text('Entrar'),

          onPressed: () {

            Navigator.push(

              context,

              MaterialPageRoute(
                builder: (context) =>
                    ListaCompras(),
              ),
            );
          },
        ),
      ),
    );
  }
}