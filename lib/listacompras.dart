import 'package:flutter/material.dart';
import 'editar.dart';

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

  void adicionar() {

    if (nome.text.isEmpty ||
        quantidade.text.isEmpty) {
      return;
    }

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
  }

  void excluir(int index) {

    setState(() {

      itens.removeAt(index);
    });
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

        title:
            const Text('Lista de Compras'),

        centerTitle: true,
      ),

      body: Column(
        children: [

          Card(

            margin:
                const EdgeInsets.all(10),

            child: Padding(

              padding:
                  const EdgeInsets.all(10),

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
                ],
              ),
            ),
          ),

          ElevatedButton(

            onPressed: adicionar,

            child:
                const Text('Adicionar'),
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

                        color:
                            itens[index].comprado
                                ? Colors.grey
                                : Colors.black,
                      ),
                    ),

                    onTap: () async {

                      final editado =
                          await Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              TelaEditar(
                            item: itens[index],
                          ),
                        ),
                      );

                      if (editado != null) {

                        setState(() {

                          itens[index] =
                              editado;
                        });
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