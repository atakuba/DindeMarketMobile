import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Assuming SubCategory is stored as a String for simplicity in SQLite
class DatabaseHelper {
  static final _databaseName = "app_database.db";
  static final _databaseVersion = 1;

  static final tableProductCart = 'productCart';
  static final tableProductFavorite = 'productFavorite';
  static final tableUser = 'user';

  // Columns for product
  static final columnId = 'id';
  static final columnFavorite = 'favorite';
  static final columnAmount = 'amount';

  // Columns for User
  static final columnUsername = 'username';
  static final columnFirstName = 'firstName';
  static final columnLastName = 'lastName';
  static final columnPhoneNumber = 'phoneNumber';
  static final columnRegion = 'region';
  static final columnAddress = 'address';
  static final columnToken = 'token';

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
        $columnAmount INTEGER
      );
    ''');

    // Create ProductFavorite table
    await db.execute('''
      CREATE TABLE $tableProductFavorite (
        $columnId INTEGER PRIMARY KEY,
        $columnFavorite INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE $tableUser (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUsername TEXT NOT NULL,
        $columnFirstName TEXT NOT NULL,
        $columnLastName TEXT NOT NULL,
        $columnPhoneNumber TEXT NOT NULL,
        $columnRegion TEXT NOT NULL,
        $columnAddress TEXT,
        $columnToken TEXT
      );
    ''');
  }

    // Method to drop tables
  Future<void> dropTables(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $tableProductCart;');
    await db.execute('DROP TABLE IF EXISTS $tableProductFavorite;');
    await db.execute('DROP TABLE IF EXISTS $tableUser;');
  }

  // Call this method to drop tables
  Future<void> resetDatabase() async {
    Database db = await instance.database;
    await dropTables(db);
    // Optionally, you can recreate the tables again if needed
    await _onCreate(db, _databaseVersion);
  }

  // Insert product into cart
  Future<int> insertProductCart(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableProductCart, row);
  }

  Future<int> updateProductCart(int id, int amount) async {
  Database db = await instance.database;

  // Prepare the row with the new values
  Map<String, dynamic> row = {
    columnAmount: amount,
  };

  return await db.update(
    tableProductCart, // The table to update
    row,              // The new values
    where: '$columnId = ?', // The condition to select the row
    whereArgs: [id],  // The arguments for the condition
  );
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

  // Method to delete all products from cart
  Future<int> deleteAllProductCart() async {
  Database db = await instance.database;
  return await db.delete(tableProductCart);
}

  // Delete product from favorites
  Future<int> deleteProductFavorite(int id) async {
    Database db = await instance.database;
    return await db.delete(tableProductFavorite, where: '$columnId = ?', whereArgs: [id]);
  }

  // Insert a new user
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableUser, row);
  }

  // Query all users
  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await instance.database;
    return await db.query(tableUser);
  }

  // Delete a user
  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }
}
