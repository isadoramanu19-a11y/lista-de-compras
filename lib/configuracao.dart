import 'package:flutter/material.dart';
import 'listacompras.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() =>
      _TelaConfiguracoesState();
}

class _TelaConfiguracoesState
    extends State<TelaConfiguracoes> {

  bool notificacoes = true;
  bool confirmarExclusao = true;

  @override
   Widget build(BuildContext context) {
//layout(estrutura da tela)
    return Scaffold(

      backgroundColor:
          const Color.fromARGB(
            255,
            211,
            164,
            223,
          ),

      appBar: AppBar(
        title: const Text("Configurações"),
      ),

      body: ListView(
        children: [

          SwitchListTile(
            title: const Text("Notificações"),
            subtitle: const Text(
              "Receber lembretes",
            ),
            value: notificacoes,
            onChanged: (value) {

              setState(() {
                notificacoes = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text(
              "Confirmar exclusão",
            ),
            value: confirmarExclusao,
            onChanged: (value) {

              setState(() {
                confirmarExclusao = value;
              });
            },
          ),

          const Divider(),

          const AboutListTile(
            applicationName:
                "Lista de Compras",
            applicationVersion: "1.0",
            applicationLegalese:
                "Desenvolvido em Flutter",
          ),
        ],
      ),
    );
  }
}