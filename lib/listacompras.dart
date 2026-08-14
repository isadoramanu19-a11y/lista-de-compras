import 'package:flutter/material.dart';

import 'models/item.dart';
import 'database/database_helper.dart';
import 'editar.dart';
import 'calculadora.dart';
import 'configuracao.dart';

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  // Lista de itens
  List<Item> itens = [];

  // Inputs
  final TextEditingController nome = TextEditingController();
  final TextEditingController quantidade = TextEditingController();
  final TextEditingController valor = TextEditingController();

  @override
  void initState() {
    super.initState();

    carregarItens();
  }

  // READ - carregar itens
  Future<void> carregarItens() async {
    final itensSalvos =
        await DatabaseHelper.instance.buscarItens();

    if (!mounted) return;

    setState(() {
      itens = itensSalvos;
    });
  }

  // CREATE - adicionar item
  Future<void> adicionar() async {
    if (nome.text.isEmpty ||
        quantidade.text.isEmpty ||
        valor.text.isEmpty) {
      return;
    }

    final novoItem = Item(
      nome: nome.text,
      quantidade: int.tryParse(quantidade.text) ?? 0,
      valor: double.tryParse(valor.text) ?? 0,
    );

    final id =
        await DatabaseHelper.instance.adicionarItem(novoItem);

    novoItem.id = id;

    setState(() {
      itens.insert(0, novoItem);
    });

    nome.clear();
    quantidade.clear();
    valor.clear();
  }

  // DELETE - excluir item
  Future<void> excluir(int index) async {
    final item = itens[index];

    if (item.id != null) {
      await DatabaseHelper.instance.excluirItem(item.id!);
    }

    setState(() {
      itens.removeAt(index);
    });
  }

  // UPDATE - atualizar item
  Future<void> atualizarItem(
    Item item,
    int index,
  ) async {
    await DatabaseHelper.instance.atualizarItem(item);

    setState(() {
      itens[index] = item;
    });
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
      // O tema global controla o fundo

      appBar: AppBar(
        title: const Text('Lista de Compras'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // =========================
          // CARD DOS INPUTS
          // =========================
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

          const SizedBox(height: 10),

          // =========================
          // BOTÕES
          // =========================
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,

            children: [
              ElevatedButton.icon(
                onPressed: adicionar,

                icon: const Icon(Icons.add),

                label: const Text("Adicionar"),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Calculadora(itens: itens),
                    ),
                  );
                },

                icon: const Icon(Icons.calculate),

                label: const Text("Calculadora"),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const TelaConfiguracoes(),
                    ),
                  );
                },

                icon: const Icon(Icons.settings),

                label: const Text("Config."),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // =========================
          // LISTA
          // =========================
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,

              itemBuilder: (context, index) {
                final item = itens[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  child: ListTile(
                    leading: Checkbox(
                      value: item.comprado,

                      onChanged: (value) async {
                        item.comprado =
                            value ?? false;

                        await atualizarItem(
                          item,
                          index,
                        );
                      },
                    ),

                    title: Text(
                      '${item.nome} - ${item.quantidade}',

                      style: TextStyle(
                        decoration: item.comprado
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,

                        color: item.comprado
                            ? Colors.grey
                            : Theme.of(context)
                                .colorScheme
                                .onSurface,
                      ),
                    ),

                    onTap: () async {
                      final editado =
                          await Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              TelaEditar(item: item),
                        ),
                      );

                      if (editado != null &&
                          editado is Item) {
                        await atualizarItem(
                          editado,
                          index,
                        );
                      }
                    },

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () {
                        excluir(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}