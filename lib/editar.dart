import 'package:flutter/material.dart';
import 'models/item.dart';

class TelaEditar extends StatefulWidget {
  final Item item;

  const TelaEditar({
    super.key,
    required this.item,
  });

  @override
  State<TelaEditar> createState() => _TelaEditarState();
}

class _TelaEditarState extends State<TelaEditar> {
  late TextEditingController nome;
  late TextEditingController quantidade;
  late TextEditingController valor;

  @override
  void initState() {
    super.initState();

    nome = TextEditingController(
      text: widget.item.nome,
    );

    quantidade = TextEditingController(
      text: widget.item.quantidade.toString(),
    );

    valor = TextEditingController(
      text: widget.item.valor.toString(),
    );
  }

  @override
  void dispose() {
    nome.dispose();
    quantidade.dispose();
    valor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 164, 223),

      appBar: AppBar(
        title: const Text('Editar'),
      ),

      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),

            child: Padding(
              padding: const EdgeInsets.all(10),

              child: Column(
                children: [
                  TextField(
                    controller: nome,
                    decoration: const InputDecoration(
                      labelText: 'Produto',
                    ),
                  ),

                  TextField(
                    controller: quantidade,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade',
                    ),
                  ),

                  TextField(
                    controller: valor,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Valor Unitário (R\$)',
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            child: const Text('Salvar'),

            onPressed: () {
              Navigator.pop(
                context,

                Item(
                  id: widget.item.id,
                  nome: nome.text,
                  quantidade: int.tryParse(quantidade.text) ?? 0,
                  valor: double.tryParse(valor.text) ?? 0,
                  comprado: widget.item.comprado,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}