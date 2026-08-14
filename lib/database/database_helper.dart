    import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('lista_compras.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE itens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        quantidade INTEGER NOT NULL,
        valor REAL NOT NULL,
        comprado INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // CREATE - adicionar item
  Future<int> adicionarItem(Item item) async {
    final db = await instance.database;

    return await db.insert(
      'itens',
      item.toMap(),
    );
  }

  // READ - buscar todos os itens
  Future<List<Item>> buscarItens() async {
    final db = await instance.database;

    final resultado = await db.query(
      'itens',
      orderBy: 'id DESC',
    );

    return resultado.map((map) => Item.fromMap(map)).toList();
  }

  // UPDATE - atualizar item
  Future<int> atualizarItem(Item item) async {
    final db = await instance.database;

    return await db.update(
      'itens',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // DELETE - excluir item
  Future<int> excluirItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      'itens',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fechar banco
  Future<void> fecharBanco() async {
    final db = await instance.database;

    await db.close();

    _database = null;
  }
}