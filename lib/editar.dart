import 'package:flutter/material.dart';
import 'adicionar.dart';

class TelaEditar extends StatefulWidget {

  final Item item;

  const TelaEditar({
    super.key,
    required this.item,
  });

  @override
  State<TelaEditar> createState() =>
      _TelaEditarState();
}

class _TelaEditarState
    extends State<TelaEditar> {

  late TextEditingController nome;
  late TextEditingController quantidade;

  @override
  void initState() {

    super.initState();

    nome = TextEditingController(
      text: widget.item.nome,
    );

    quantidade = TextEditingController(
      text: widget.item.quantidade,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Editar'),
      ),

      body: Column(
        children: [

          TextField(
            controller: nome,
          ),

          TextField(
            controller: quantidade,
          ),

          ElevatedButton(

            child: Text('Salvar'),

            onPressed: () {

              Navigator.pop(

                context,

                Item(
                  nome.text,
                  quantidade.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}