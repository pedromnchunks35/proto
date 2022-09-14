//CLASS FOR MANAGING THE DATABASE
import 'package:sqflite/sqflite.dart';
//PATH PROVIDER
import 'package:path/path.dart';




//CLASS TO ACESS MULTIPLE DATABASES
class Databaseapp{
//THE NAME OF THE DATABASE
String name;
//LIST OF GIVEN COMMANDS
List<String> commands;
//THE VERSION
final int version;
//THE DATABASE
late Database _db;

// A function that is called when the [version] changes.
final OnDatabaseVersionChangeFn? onUpgrade;


//THE CONSTRUCTOR
Databaseapp({required this.name,required this.commands,required this.onUpgrade,required this.version});


//RETURN INSTANCE OF THE DATABASE
Future<Database> getDb() async{
//GET THE INITIALIZATION
_db = await initialize();
//RETURN THE VALUE
return _db;
}

//THE INIT
Future<Database> initialize() async{
  //GET THE RELATIVE DIR
  final String dir = await getDatabasesPath();
  //MAKE THE FULL PATH
  final String path = join(dir,name);
  
  //OPEN OR CREATE AN DATABASE
  final db = await openDatabase(
    path,
    version: version,
    onCreate: createTables,
    onUpgrade: onUpgrade
  );
  //RETURN THE DB
  return db;
}

//ON CREATE THE DB , CREATE SOME TABLES
void createTables(Database db,int version)async{
  //THE COMMAND LIST FOR CREATING TABLES
  for(String command in commands){
    //EXECUTE THE QUERYS
    db.execute(command);
  }
  
}




/// Removes the database called [name].
  void removeDatabase(String name) async {
    //GET THE RELATIVE DIR
  final String dir = await getDatabasesPath();
  //MAKE THE FULL PATH
  final String path = join(dir,name);
    
    //DELETE THE DATABASE
    await deleteDatabase(path);
  }





}





