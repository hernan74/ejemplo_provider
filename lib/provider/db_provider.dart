import 'dart:io';
import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  static final String _usuarioTableName = 'Usuario';

  DBProvider._();

  get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //Path de donde se almacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'UsuarioDB.db');
    print(path);

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE '$_usuarioTableName'(
          id INTEGER PRIMARY KEY,
          usuario TEXT,
          email TEXT,
          direccion TEXT,
          edad INTEGER
        )        
        ''');
    });
  }

  Future<int> crearNuevo(UsuarioModel nuevo) async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;
    final id = await db.insert('$_usuarioTableName', nuevo.toJson());
    print(id);
    return id;
  }

  Future<int> modificar(UsuarioModel modificar) async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;
    final id = await db.update('$_usuarioTableName', modificar.toJson(),
        where: 'id=?', whereArgs: [modificar.id]);
    return id;
  }

  Future<UsuarioModel> buscarPorId(int id) async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;
    final res =
        await db.query(_usuarioTableName, where: 'id=?', whereArgs: [id]);

    return res.isEmpty ? UsuarioModel.fromJson(res.first) : null;
  }

  Future<UsuarioModel> buscarPorEmail(String email) async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;
    final res =
        await db.query(_usuarioTableName, where: 'email=?', whereArgs: [email]);

    return res.isNotEmpty ? UsuarioModel.fromJson(res.first) : null;
  }

  Future<List<UsuarioModel>> buscarTodos() async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;
    final res = await db.query(_usuarioTableName);

    return res.isNotEmpty
        ? res.map((e) => UsuarioModel.fromJson(e)).toList()
        : [];
  }

  Future<int> borrarTodos() async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;

    return await db.delete(_usuarioTableName);
  }

  Future<int> borrarPorId(int id) async {
    //Obtiene la instancia de la base de datos
    final Database db = await database;

    return await db.delete(_usuarioTableName, where: 'id=?', whereArgs: [id]);
  }
}
