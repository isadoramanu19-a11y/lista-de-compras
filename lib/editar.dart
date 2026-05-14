import 'package:flutter/material.dart';
import 'main.dart';

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

      backgroundColor:
          const Color.fromARGB(
            255,
            211,
            164,
            223,
          ),

      appBar: AppBar(
        title: const Text('Editar'),
      ),

      body: Padding(

        padding: const EdgeInsets.all(10),

        child: Column(
          children: [

            TextField(
              controller: nome,
              decoration:
                  const InputDecoration(
                labelText: 'Produto',
              ),
            ),

            TextField(
              controller: quantidade,
              decoration:
                  const InputDecoration(
                labelText: 'Quantidade',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              child: const Text('Salvar'),

              onPressed: () {

                Navigator.pop(

                  context,

                  Item(

                    nome.text,
                    quantidade.text,

                    comprado:
                        widget.item.comprado,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}