class Item {
  int? id;
  String nome;
  String quantidade;
  double valor;
  bool comprado;

  Item({
    this.id,
    required this.nome,
    required this.quantidade,
    required this.valor,
    this.comprado = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'valor': valor,
      'comprado': comprado ? 1 : 0,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
      valor: map['valor'],
      comprado: map['comprado'] == 1,
    );
  }
}