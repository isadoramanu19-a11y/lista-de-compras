import 'package:flutter/material.dart';
import 'listacompras.dart';

class TelaEditar extends StatefulWidget {
  final Item item;

  const TelaEditar({super.key, required this.item});

  @override
  State<TelaEditar> createState() => _TelaEditarState();
}

class _TelaEditarState extends State<TelaEditar> {
  //inputs(entrada de dados)
  late TextEditingController nome;
  late TextEditingController quantidade;
  late TextEditingController valor;

  @override
  void initState() {
    super.initState();
//inputs(dados atuais)
    nome = TextEditingController(text: widget.item.nome);

    quantidade = TextEditingController(text: widget.item.quantidade);

    valor = TextEditingController(text: widget.item.valor.toString());
  }

  @override
  Widget build(BuildContext context) {
//layout
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 164, 223),
//layout(barra superior)
      appBar: AppBar(title: const Text('Editar')),
//layout
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),

            child: Padding(
              padding: const EdgeInsets.all(10),

              child: Column(
                children: [
//inputs(editar)
                  TextField(
                    controller: nome,

                    decoration: const InputDecoration(labelText: 'Produto'),
                  ),

                  TextField(
                    controller: quantidade,

                    decoration: const InputDecoration(labelText: 'Quantidade'),
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
//input salvar
          ElevatedButton(
            child: const Text('Salvar'),

            onPressed: () {
//navegação(volta editado)
              Navigator.pop(
                context,

                Item(
                  nome.text,
                  quantidade.text,
                  double.parse(valor.text),

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
