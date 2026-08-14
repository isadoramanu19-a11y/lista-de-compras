import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() =>
      _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool confirmarExclusao = true;
  bool cadeado = true;
  bool salvo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O tema global controla automaticamente o fundo
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),

        children: [
          // ==========================================
          // MODO ESCURO
          // ==========================================
          ValueListenableBuilder<bool>(
            valueListenable: temaEscuroNotifier,

            builder: (context, temaEscuro, child) {
              return SwitchListTile(
                title: const Text(
                  "Modo escuro",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  temaEscuro
                      ? "Tema escuro ativado"
                      : "Tema claro ativado",
                ),

                value: temaEscuro,

                onChanged: (valor) async {
                  final prefs =
                      await SharedPreferences.getInstance();

                  await prefs.setBool(
                    'temaEscuro',
                    valor,
                  );

                  // Atualiza o tema do aplicativo inteiro
                  temaEscuroNotifier.value = valor;
                },
              );
            },
          ),

          const Divider(),

          const SizedBox(height: 10),

          // ==========================================
          // ANIMAÇÃO DE CONFIRMAÇÃO
          // ==========================================
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

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                  // Texto muda para branco no tema escuro
                  color: Theme.of(context).brightness ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==========================================
          // ANIMATED DEFAULT TEXT STYLE
          // ==========================================
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 1),

              style: TextStyle(
                fontSize:
                    confirmarExclusao ? 26 : 18,

                color: confirmarExclusao
                    ? Colors.green
                    : Colors.red,
              ),

              child: Text(
                confirmarExclusao
                    ? "ativado"
                    : "desativado",
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==========================================
          // SWITCH DE CONFIRMAÇÃO
          // ==========================================
          SwitchListTile(
            title: const Text(
              "Confirmação ao excluir",
            ),

            value: confirmarExclusao,

            onChanged: (value) {
              setState(() {
                confirmarExclusao = value;
                cadeado = value;
              });
            },
          ),

          const Divider(),

          const SizedBox(height: 10),

          // ==========================================
          // TEXTO
          // ==========================================
          Center(
            child: Text(
              "Arraste a engrenagem",

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,

                color: Theme.of(context)
                    .colorScheme
                    .onSurface,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==========================================
          // DRAGGABLE
          // ==========================================
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
                    borderRadius:
                        BorderRadius.circular(10),
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
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),

              child: Container(
                width: 70,
                height: 70,

                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(10),
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

          // ==========================================
          // DRAG TARGET
          // ==========================================
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
                  duration:
                      const Duration(milliseconds: 500),

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
                          ? "Configuração salva!"
                          : "Solte aqui",

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