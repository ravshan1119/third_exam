import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:third_exam_n8/data/model/product_model_sql.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("favorite_products.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${ProductModelFields.productsTable} (
    ${ProductModelFields.id} $idType,
    ${ProductModelFields.categoryId} $intType,
    ${ProductModelFields.name} $textType,
    ${ProductModelFields.price} $intType,
    ${ProductModelFields.imageUrl} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE ${ProductModelFields.savedProductTable} (
    ${ProductModelFields.id} $idType,
    ${ProductModelFields.categoryId} $intType,
    ${ProductModelFields.name} $textType,
    ${ProductModelFields.price} $intType,
    ${ProductModelFields.imageUrl} $textType
    )
    ''')
    ;
  }

  static Future insertProduct(Map<String,dynamic> map) async {
    final db = await getInstance.database;
    await db.insert(ProductModelFields.productsTable, map);
  }
  static Future
  insertSaved(Map<String,dynamic> map) async {
    final db = await getInstance.database;
    await db.insert(ProductModelFields.savedProductTable, map);
  }


  static Future<List<Map<String,dynamic>>> getAllProducts() async {
    List<Map<String,dynamic>> allProducts = [];
    final db = await getInstance.database;
    allProducts = (await db.query(ProductModelFields.productsTable)).toList();

    return allProducts;
  }
  static Future<List<Map<String,dynamic>>> getSavedProduct() async {
    List<Map<String,dynamic>> allProducts = [];
    final db = await getInstance.database;
    allProducts = (await db.query(ProductModelFields.savedProductTable)).toList();

    return allProducts;
  }

//
// static updateToDoStatus({required int id, required int statusIndex}) async {
//   final db = await getInstance.database;
//   db.update(
//     ToDoModelFields.toDoTable,
//     {ToDoModelFields.status: statusIndex},
//     where: "${ToDoModelFields.id} = ?",
//     whereArgs: [id],
//   );
// }
//
// static updateToDo({required ToDoModelSql toDoModelSql}) async {
//   final db = await getInstance.database;
//   db.update(
//     ToDoModelFields.toDoTable,
//     toDoModelSql.toJson(),
//     where: "${ToDoModelFields.id} = ?",
//     whereArgs: [toDoModelSql.id],
//   );
// }
//
  static deleteProduct(String imageUrl) async {
    final db = await getInstance.database;
    db.delete(
      ProductModelFields.productsTable,
      where: "${ProductModelFields.imageUrl} = ?",
      whereArgs: [imageUrl],
    );
  }

  static deleteSavedProduct(String imageUrl) async {
    final db = await getInstance.database;
    db.delete(
      ProductModelFields.savedProductTable,
      where: "${ProductModelFields.imageUrl} = ?",
      whereArgs: [imageUrl],
    );
  }
}
