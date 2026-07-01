import 'package:flutter/material.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() =>
      _TelaConfiguracoesState();
}

class _TelaConfiguracoesState
    extends State<TelaConfiguracoes> {

  bool confirmarExclusao = true;
  bool cadeado = true;
  bool salvo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        211,
        164,
        223,
      ),

      appBar: AppBar(
        title: const Text("Configurações"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [

          // AnimatedContainer

          AnimatedContainer(
            duration: const Duration(
              seconds: 1,
            ),

            height: confirmarExclusao
                ? 90
                : 60,

            decoration: BoxDecoration(
              color: confirmarExclusao
                  ? Colors.green.shade200
                  : Colors.red.shade200,

              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: Center(
              child: Text(
                confirmarExclusao
                    ? "Confirmação ativada"
                    : "Confirmação desativada",

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // AnimatedDefaultTextStyle

          Center(
            child: AnimatedDefaultTextStyle(
              duration:
                  const Duration(seconds: 1),

              style: TextStyle(
                fontSize:
                    confirmarExclusao
                        ? 26
                        : 18,

                color:
                    confirmarExclusao
                        ? Colors.green
                        : Colors.red,
              ),

              child: Text(
                confirmarExclusao
                    ? "Ativado"
                    : "Desativado",
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Switch

          SwitchListTile(
            title: const Text(
              "Confirmar exclusão",
            ),

            value: confirmarExclusao,

            onChanged: (value) {

              setState(() {

                confirmarExclusao =
                    value;

                cadeado = value;

              });

            },
          ),

          const Divider(),

          // AnimatedCrossFade

          Center(
            child: GestureDetector(

              onTap: () {

                setState(() {

                  cadeado = !cadeado;

                });

              },

              child:
                  AnimatedCrossFade(

                duration:
                    const Duration(
                        seconds: 1),

                firstChild:
                    const Icon(
                  Icons.lock,
                  size: 70,
                ),

                secondChild:
                    const Icon(
                  Icons.lock_open,
                  size: 70,
                ),

                crossFadeState:
                    cadeado
                        ? CrossFadeState
                            .showFirst
                        : CrossFadeState
                            .showSecond,
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Center(
            child: Text(
              "Arraste a engrenagem",
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),
                    // Draggable

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

          // DragTarget

          Center(
            child: DragTarget<String>(

              onAcceptWithDetails: (details) {
                setState(() {
                  salvo = true;
                });
              },

              builder: (
                context,
                candidateData,
                rejectedData,
              ) {
                return AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 500,
                  ),

                  width: 180,
                  height: 90,

                  decoration: BoxDecoration(
                    color: salvo
                        ? Colors.green
                        : Colors.blue,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),

                  child: Center(
                    child: Text(
                      salvo
                          ? "✔ Configuração salva!"
                          : "Solte aqui",

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
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