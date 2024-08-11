import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter_crud/JsonModels/cancha_model.dart';
import 'package:sqlite_flutter_crud/JsonModels/note_model.dart';
import 'package:sqlite_flutter_crud/JsonModels/book_model.dart';
import 'package:sqlite_flutter_crud/JsonModels/users.dart';

class DatabaseHelper {
  final databaseName = "canchas17.db";
  String noteTable =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  String canchaTable =
      "CREATE TABLE canchas (canchaId INTEGER PRIMARY KEY AUTOINCREMENT, canchaTitle TEXT NOT NULL, canchaType TEXT NOT NULL, canchaImagen TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  String canchaInsert =
      "INSERT INTO canchas(canchaTitle, canchaType, canchaImagen) values('Epic Box','Cancha Tipo A', 'lib/assets/cancha1.png')";
  String canchaInsert2 =
      "INSERT INTO canchas(canchaTitle, canchaType, canchaImagen) values('Rusty Tenis','Cancha Tipo B', 'lib/assets/cancha2.png')";
  String canchaInsert3 =
      "INSERT INTO canchas(canchaTitle, canchaType, canchaImagen) values('Cancha Multiple','Cancha Tipo C', 'lib/assets/cancha3.png')";

  String bookTable =
      "CREATE TABLE books (bookId INTEGER PRIMARY KEY AUTOINCREMENT, canchaId INTEGER, userId INTEGER, reservedStart TEXT NOT NULL, reservedEnd TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  //Now we must create our user table into our sqlite db

  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  //We are done in this section

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(noteTable);
      await db.execute(canchaTable);
      await db.execute(canchaInsert);
      await db.execute(canchaInsert2);
      await db.execute(canchaInsert3);
      await db.execute(bookTable);
    });
  }

  //Now we create login and sign up method
  //as we create sqlite other functionality in our previous video

  //IF you didn't watch my previous videos, check part 1 and part 2

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }

  //Search Method
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  //CRUD Methods

  //Create Note
  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  //Get notes
  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Delete Notes
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  //Update Notes
  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set noteTitle = ?, noteContent = ? where noteId = ?',
        [title, content, noteId]);
  }

  //Search Method
  Future<List<CanchaModel>> searchCanchas(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db.rawQuery(
        "select * from canchas where canchaTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => CanchaModel.fromMap(e)).toList();
  }

  //CRUD Methods

  //Create Cancha
  Future<int> createCancha(CanchaModel cancha) async {
    final Database db = await initDB();
    return db.insert('canchas', cancha.toMap());
  }

  //Get canchas
  Future<List<CanchaModel>> getCanchas() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('canchas');
    return result.map((e) => CanchaModel.fromMap(e)).toList();
  }

  //Get cancha
  Future<List<CanchaModel>> getCancha(int canchaId) async {
    final Database db = await initDB();
    List<Map<String, Object?>> result =
        await db.query('canchas where canchaId = ? ', whereArgs: [canchaId]);
    return result.map((e) => CanchaModel.fromMap(e)).toList();
  }

  //Delete Canchas
  Future<int> deleteCancha(int id) async {
    final Database db = await initDB();
    return db.delete('canchas', where: 'canchaId = ?', whereArgs: [id]);
  }

  //Update Canchas
  Future<int> updateCancha(title, tipo, imagen, canchaId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update canchas set canchaTitle = ?, canchaType = ?, canchaImagen = ? where canchaId = ?',
        [title, tipo, imagen, canchaId]);
  }

//Search Method
  Future<List<BookModel>> searchBooks(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult2 = await db
        .rawQuery("select * from books where bookTitle LIKE ?", ["%$keyword%"]);
    return searchResult2.map((e) => BookModel.fromMap(e)).toList();
  }

  //CRUD Methods

  //Create Books
  Future<int> createBook(BookModel book) async {
    final Database db = await initDB();
    return db.insert('books', book.toMap());
  }

  //Get Books
  Future<List<BookModel>> getBooks() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('books');
    return result.map((e) => BookModel.fromMap(e)).toList();
  }

  //Delete Books
  Future<int> deleteBook(int id) async {
    final Database db = await initDB();
    return db.delete('books', where: 'bookId = ?', whereArgs: [id]);
  }

  //Update Books
  Future<int> updateBook(int canchaId, int userId, String reservedStart,
      String reservedEnd, int bookId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update books set canchaId = ?, userId = ?, reservedStart = ?, reservedEnd = ? where bookId = ?',
        [canchaId, userId, reservedStart, reservedEnd, bookId]);
  }
}
