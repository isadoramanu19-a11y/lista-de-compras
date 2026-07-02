import 'package:flutter/material.dart';
import 'listacompras.dart';

//Stateful, onde a tela pode mudar conforme os dados 
class Calculadora extends StatefulWidget {
  final List<Item> itens;

  const Calculadora({super.key, required this.itens});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

//Processamento, cálculo do valor total da compra, somando com o subtotal de cada item
class _CalculadoraState extends State<Calculadora> {
  double calcularTotalLista() {
    double total = 0;
    for (var item in widget.itens) {
      int qtd = int.tryParse(item.quantidade) ?? 0;

      total += item.valor * qtd;
    }

    return total;
  }

  final TextEditingController valor = TextEditingController();
  final TextEditingController quantidade = TextEditingController();

  double total = 0;

  void calcular() {
    double v = double.tryParse(valor.text) ?? 0;
    int q = int.tryParse(quantidade.text) ?? 0;

    setState(() {
      total = v * q;
    });
  }

  @override
  Widget build(BuildContext context) {
    //layout, estrutura da tela
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 164, 223),

      //layout, barra superior
      appBar: AppBar(
        title: const Text('Calculadora de compras'),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.itens.length,

                itemBuilder: (context, index) {
                  final item = widget.itens[index];

                  int qtd = int.tryParse(item.quantidade) ?? 0;
                  
//Processamento, cálculo do subtotal de cada item, multiplicando o produto pela quantidade

                  double subtotal = item.valor * qtd;
                  return Card(
                    child: ListTile(
                      title: Text(item.nome),
                      subtitle: Text(
                        "$qtd x R\$ ${item.valor.toStringAsFixed(2)}",
                      ),
                      trailing: Text("R\$ ${subtotal.toStringAsFixed(2)}"),
                    ),
                  );
                },
              ),
            ),

            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "TOTAL DA LISTA",
                      style: TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      "R\$ ${calcularTotalLista().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
