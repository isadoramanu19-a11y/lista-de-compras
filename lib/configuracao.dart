import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

//Stateful, os valores da configuração e animação podem mudar com alterações
class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool confirmarExclusao = true;
  bool cadeado = true;
  bool salvo = false;
  bool temaEscuro = false;

  Future<void> carregarTema() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      temaEscuro = prefs.getBool('temaEscuro') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarTema();
  }

  Future<void> alterarTema(bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('temaEscuro', valor);
    setState(() {
      temaEscuro = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: temaEscuro
      ? const Color.fromARGB(255, 34, 33, 33)
      : const Color.fromARGB(255, 211, 164, 223),

  appBar: AppBar(
    title: const Text("Configurações"),
  ),


      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // MODO ESCURO
          SwitchListTile(
            title: const Text(
              "Modo escuro",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(""),
            value: temaEscuro,
            onChanged: alterarTema,
          ),
          const Divider(),

          //Animação, altera cor e altura quando selecionada, quando exluir é ativado ou desativado
          AnimatedContainer(
            duration: const Duration(seconds: 1),

            height: confirmarExclusao ? 90 : 60,

            decoration: BoxDecoration(
              color: confirmarExclusao
                  ? Colors.green.shade200
                  : Colors.red.shade200,

              borderRadius: BorderRadius.circular(15),
            ),




            child: Center(
              child: Text(
                confirmarExclusao
                    ? "Confirmação ativada"
                    : "Confirmação desativada",

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Animação, muda tamanho e cor do texto
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 1),

              style: TextStyle(
                fontSize: confirmarExclusao ? 26 : 18,

                color: confirmarExclusao ? Colors.green : Colors.red,
              ),

              child: Text(confirmarExclusao ? "ativado" : "desativado"),
            ),
          ),

          const SizedBox(height: 20),

          //Processamento, altera estado de aplicação, atualiza variáveis e reconstrói interface com o SetState
          SwitchListTile(

            value: confirmarExclusao,

            onChanged: (value) {
              setState(() {
                confirmarExclusao = value;

                cadeado = value;
              });
            },
          ),

          const Divider(),

          const Center(
            child: Text(
              "Arraste a engrenagem",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 20),

          //Animação, widget draggable arrasta a engrenagem até área destinada
          Center(
            child: Draggable<String>(
              data: "config",

              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),

              childWhenDragging: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          //Animação e processamento, dragTarget recebe o objeto arrastado e altera variável "salvo"

          //Animatedcontainer muda a cor e mensagem quando a configuração é salva
          Center(
            child: DragTarget<String>(
              onAcceptWithDetails: (details) {
                setState(() {
                  salvo = true;
                });
              },

              builder: (context, candidateData, rejectedData) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),

                  width: 180,
                  height: 90,

                  decoration: BoxDecoration(
                    color: salvo ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Center(
                    child: Text(
                      salvo ? "Configuração salva!" : "Solte aqui",

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
