import 'package:flutter/material.dart';
import 'listacompras.dart';

//início e widget principal

void main() {
  runApp(const MyApp());
}
//widgets diversos
  class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

//Layout
        return const MaterialApp(
        debugShowCheckedModeBanner: false,
//navegação
       home: ListaCompras(),
    );
  }
}