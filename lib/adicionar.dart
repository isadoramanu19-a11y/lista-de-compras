import 'package:flutter/material.dart';
import 'editar.dart';

class Item {

  String nome;
  String quantidade;

  Item(this.nome, this.quantidade);
}

class ListaCompras extends StatefulWidget {

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

    setState(() {

      itens.add(
        Item(nome.text, quantidade.text),
      );

      nome.clear();
      quantidade.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Lista'),
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
            onPressed: adicionar,
            child: Text('Adicionar'),
          ),

          Expanded(

            child: ListView.builder(

              itemCount: itens.length,

              itemBuilder: (context, index) {

                return ListTile(

                  title: Text(itens[index].nome),

                  subtitle: Text(
                    itens[index].quantidade,
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
                        itens[index] = editado;
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}