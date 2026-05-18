import 'package:flutter/material.dart';
import 'editar.dart';

//widget diverso(classe)
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
//widget diverso(state)
  class ListaCompras extends StatefulWidget {

  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() =>
      _ListaComprasState();
}

class _ListaComprasState
    extends State<ListaCompras> {

//lista de itens
  List<Item> itens = [];

//inputs
  TextEditingController nome =
      TextEditingController();

  TextEditingController quantidade =
      TextEditingController();

//input(verifica se algo foi digitado)
  void adicionar() {

    if (nome.text.isEmpty ||
        quantidade.text.isEmpty) {
      return;
    }
//widget diverso(atualiza tela)
    setState(() {

      itens.add(
        Item(
          nome.text,
          quantidade.text,
        ),
      );
//input(limpa os campos)
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
//layout(estrutura da tela (build))
    return Scaffold(

      backgroundColor:
          const Color.fromARGB(
            255,
            211,
            164,
            223,
          ),

//layout(barra superior)
      appBar: AppBar(

        title:
            const Text('Lista de Compras'),

        centerTitle: true,
      ),
//layout(organiza na vertical)
      body: Column(
        children: [
//card com input(organiza vizualmente)
          Card(

            margin:
                const EdgeInsets.all(10),

            child: Padding(

              padding:
                  const EdgeInsets.all(10),

              child: Column(
                children: [
//input(digitar nome do produto e quantidade)
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
//input
          ElevatedButton(

            onPressed: adicionar,

            child:
                const Text('Adicionar'),
          ),
//layout para lista
          Expanded(

            child: ListView.builder(

              itemCount: itens.length,

              itemBuilder:
                  (context, index) {

                return
//layout(estrutura do item)
                 Card(

                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  child: ListTile(
//input(marcar/desmarcar)
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
//navegação para a tela editar
                    onTap: () async {
                      final editado =
                          await Navigator.push(

                        context,
//navegação quando abre a tela editar
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
//input para excluir
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