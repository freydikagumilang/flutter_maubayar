import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  DBHelper.internal();
  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDb();
    return _db;
  }

  setDb() async {
    var dir = await getDatabasesPath();
    String dbpath = join(dir, "dbfrx");
    var dB = await openDatabase(dbpath, version: 1, onCreate: _initDB,onUpgrade: _migrate);
    return dB;
  }
  void _initDB(Database db, int ver) async {
    const initScript = ['Create table migrations (version INTEGER)','insert into migrations(0)']; // Initialization script split into seperate statements
    initScript.forEach((script) async => await db.execute(script));
    print("Migration Table Created");
    
  }
  void _migrate(Database db, int oldVersion, int newVersion) async {
    const initScript = ['Create table migrations (version INTEGER)','insert into migrations(0)']; // Initialization script split into seperate statements
    initScript.forEach((script) async => await db.execute(script));
    print("migrate");
    const migrationScripts = [
      //'String query',
    ];
    int ver = 0;
    List<Map> _migration = await db.rawQuery("select * from migrations");
    for (var i = 0; i < _migration.length; i++) {
      ver = _migration[i]['version'];
    }
    
    for (var x=ver; x < migrationScripts.length; x++) {
       db.execute(migrationScripts[x]);
       print(migrationScripts[x]);
       ver++;
    }
    db.execute("update migrations set version = ${ver}");    
  }

  
}