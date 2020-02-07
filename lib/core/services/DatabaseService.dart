import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

enum StoreDataType {
  Map,
  List,
  String,
  Bool,
  Null,
  Num,
}

enum DatabaseRespone { Success, Error, DuplicatePaper }

class DatabaseService {
  DatabaseService() {
    // Use the main store for storing key values as String
    store = StoreRef.main();
  }

  String dbName = 'database';
  Database _db;
  StoreRef store;
  bool isReady = false;

  setupDatabase() async {
    await openDatabase();
  }

  Future<Database> openDatabase() async {
    // get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    // var dbPath = join(dir.path, dbName);
    // open the database
    _db = await databaseFactoryIo.openDatabase('${dir.path}/database');
    isReady = true;
    return _db;
  }

  Future<DatabaseRespone> write(dynamic key, dynamic value,
      {StoreDataType type = StoreDataType.List}) async {
    try {
      //select the correct store
      switch (type) {
        case StoreDataType.Map:
          store = StoreRef<String, Map<String, dynamic>>.main();
          break;
        case StoreDataType.List:
          store = StoreRef<String, List<dynamic>>.main();
          break;
        case StoreDataType.String:
          store = StoreRef<String, String>.main();
          break;
        case StoreDataType.Bool:
          store = StoreRef<String, bool>.main();
          break;
        case StoreDataType.Null:
          store = StoreRef<String, Null>.main();
          break;
        case StoreDataType.Num:
          store = StoreRef<String, num>.main();
          break;
      }
      // Writing the data
      await store.record(key).put(_db, value);
      return DatabaseRespone.Success;
    } catch (ex) {
      return DatabaseRespone.Error;
    }
  }

  Future<Object> read(dynamic key) async {
    try {
      store = StoreRef.main();
      return await store.record(key).get(_db);
    } catch (ex) {
      return null;
    }
  }

  Future<DatabaseRespone> deleteStore() async {
    try {
      await store.delete(_db);
      return DatabaseRespone.Success;
    } catch (ex) {
      return DatabaseRespone.Error;
    }
  }

  Future<DatabaseRespone> updateData(dynamic key, dynamic value,
      {StoreDataType type = StoreDataType.List}) async {
    try {
      //select the correct store
      switch (type) {
        case StoreDataType.Map:
          store = StoreRef<String, Map<String, dynamic>>.main();
          break;
        case StoreDataType.List:
          store = StoreRef<String, List<dynamic>>.main();
          break;
        case StoreDataType.String:
          store = StoreRef<String, String>.main();
          break;
        case StoreDataType.Bool:
          store = StoreRef<String, bool>.main();
          break;
        case StoreDataType.Null:
          store = StoreRef<String, Null>.main();
          break;
        case StoreDataType.Num:
          store = StoreRef<String, num>.main();
          break;
      }
      // Writing the data
      await store.record(key).update(_db, value);
      return DatabaseRespone.Success;
    } catch (ex) {
      return DatabaseRespone.Error;
    }
  }
}
