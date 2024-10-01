import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Assuming SubCategory is stored as a String for simplicity in SQLite
class DatabaseHelper {
  static final _databaseName = "app_database.db";
  static final _databaseVersion = 1;

  static final tableProductCart = 'productCart';
  static final tableProductFavorite = 'productFavorite';

  // Columns for product
  static final columnId = 'id';
  static final columnFavorite = 'favorite';
  static final columnAmount = 'amount';

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Create ProductCart table
    await db.execute('''
      CREATE TABLE $tableProductCart (
        $columnId INTEGER PRIMARY KEY,
        $columnFavorite INTEGER,
      )
    ''');

    // Create ProductFavorite table
    await db.execute('''
      CREATE TABLE $tableProductFavorite (
        $columnId INTEGER PRIMARY KEY,
        $columnFavorite INTEGER,
      )
    ''');
  }

  // Insert product into cart
  Future<int> insertProductCart(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableProductCart, row);
  }

  // Insert product into favorites
  Future<int> insertProductFavorite(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableProductFavorite, row);
  }

  // Query all cart items
  Future<List<Map<String, dynamic>>> queryAllCartItems() async {
    Database db = await instance.database;
    return await db.query(tableProductCart);
  }

  // Query all favorite items
  Future<List<Map<String, dynamic>>> queryAllFavoriteItems() async {
    Database db = await instance.database;
    return await db.query(tableProductFavorite);
  }

  // Delete product from cart
  Future<int> deleteProductCart(int id) async {
    Database db = await instance.database;
    return await db.delete(tableProductCart, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete product from favorites
  Future<int> deleteProductFavorite(int id) async {
    Database db = await instance.database;
    return await db.delete(tableProductFavorite, where: '$columnId = ?', whereArgs: [id]);
  }
}
