import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      home: const ListaCompras(),
    );
  }
}

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {

  // Lista onde os itens serão guardados
  List<String> itens = [];

  // Controlador do campo de texto
  TextEditingController controller = TextEditingController();

  // Função para adicionar item
  void adicionarItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        itens.add(controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        backgroundColor: const Color.fromARGB(255, 64, 114, 200),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // Campo para escrever
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Digite um item',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // Botão adicionar
            ElevatedButton(
              onPressed: adicionarItem,
              child: const Text('Adicionar'),
            ),

            const SizedBox(height: 20),

            // Lista dos itens
            Expanded(
              child: ListView.builder(
                itemCount: itens.length,

                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itens[index]),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          itens.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




