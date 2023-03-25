import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:psmnn/models/event_model.dart';
import 'package:psmnn/models/post_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final nameDB = 'SOCIALDB';
  static final versionDB = 2;
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query = '''CREATE TABLE tblPost(
      idPost INTEGER PRIMARY KEY,
      dscPost VARCHAR(200),
      datePost DATE
    )''';
    String query1 = '''CREATE TABLE tblEvent(
      idEvent INTEGER PRIMARY KEY,
      dscEvent VARCHAR(200),
      fechaEvent DATE,
      completado BOOLEAN
    )''';
    await db.execute(query);
    await db.execute(query1);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion
        .update(tblName, data, where: 'idPost=?', whereArgs: [data['idPost']]);
  }

  Future<int> DELETE(String tblName, int idPost) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idPost=?', whereArgs: [idPost]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  //Querys para obtener los eventos
  Future<int> UPDATEevent(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion
        .update(tblName, data, where: 'idEvent=?', whereArgs: [data['idEvent']]);
  }

  Future<int> DELETEevent(String tblName, int idEvent) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idEvent=?', whereArgs: [idEvent]);
  }

  Future<List<EventModel>> GETALLEVENT() async {
    var conexion = await database;
    var result = await conexion.query('tblEvent', orderBy: "CASE WHEN fechaEvent = date('now') THEN 1 WHEN fechaEvent > date('now') THEN 2 ELSE 3 END, CASE WHEN fechaEvent = date('now') THEN fechaEvent WHEN fechaEvent > date('now') THEN fechaEvent ELSE -strftime('%s', fechaEvent) END");
    return result.map((event) => EventModel.fromMap(event)).toList();
  }

  Future<List<EventModel>> GETDAYEVENT(String cuando) async {
    var conexion = await database;
    var result = await conexion.rawQuery("SELECT * FROM tblEvent WHERE fechaEvent = date('$cuando')");
    return result.map((event) => EventModel.fromMap(event)).toList();
  }
}


// '''
//   SELECT * FROM tblEvent WHERE fechaEvent > date('now')
//   UNION
//   SELECT * FROM tblEvent WHERE fechaEvent < date('now');
//   UNION
//   SELECT * FROM tblEvent WHERE fechaEvent = date('now')
//   ORDER BY CASE
//     WHEN fechaEvent = date('now') THEN 1
//     WHEN fechaEvent > date('now') THEN 2
//     ELSE 3
//   END,
//   CASE
//     WHEN fechaEvent = date('now') THEN fechaEvent
//     WHEN fechaEvent > date('now') THEN fechaEvent
//     ELSE -strftime('%s', fechaEvent)
//   END;
// '''