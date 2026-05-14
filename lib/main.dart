import 'package:flutter/material.dart';
import 'editar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaCompras(),
    );
  }
}

class Item {

  String nome;
  String quantidade;
  bool comprado;

  Item(
    this.nome,
    this.quantidade, {
    this.comprado = false,
  });
}

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() =>
      _ListaComprasState();
}

class _ListaComprasState
    extends State<ListaCompras> {

  List<Item> itens = [];

  TextEditingController nome =
      TextEditingController();

  TextEditingController quantidade =
      TextEditingController();

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
        title: const Text('Lista de Compras'),
        centerTitle: true,
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

                  const SizedBox(height: 10),

                  ElevatedButton(

                    child:
                        const Text('Adicionar'),

                    onPressed: () {

                      setState(() {

                        itens.add(

                          Item(
                            nome.text,
                            quantidade.text,
                          ),
                        );

                        nome.clear();
                        quantidade.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(

            child: ListView.builder(

              itemCount: itens.length,

              itemBuilder:
                  (context, index) {

                return Card(

                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  child: ListTile(

                    leading: Checkbox(

                      value:
                          itens[index].comprado,

                      onChanged: (value) {

                        setState(() {

                          itens[index].comprado =
                              value!;
                        });
                      },
                    ),

                    title: Text(

                      '${itens[index].nome} - ${itens[index].quantidade}',

                      style: TextStyle(

                        decoration:
                            itens[index].comprado
                                ? TextDecoration
                                    .lineThrough
                                : TextDecoration.none,
                      ),
                    ),

                    onTap: () async {

                      final itemEditado =
                          await Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              TelaEditar(
                            item: itens[index],
                          ),
                        ),
                      );

                      if (itemEditado != null) {

                        setState(() {

                          itens[index] =
                              itemEditado;
                        });
                      }
                    },

                    trailing: IconButton(

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () {

                        setState(() {

                          itens.removeAt(index);
                        });
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