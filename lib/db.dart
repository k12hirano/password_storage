import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:io/io.dart';
import 'package:path_provider/path_provider.dart';



class DBProvider {
  final databaseName = 'PassStorage.db';
  final databaseVersion = 1;
  //DBProvider._();
  //static final DBProvider instance = DBProvider._();

  final String itemtable = 'item';
  final String _id = 'id';
  final String _title = 'title';
  final String _email = 'email';
  final String _pass = 'pass';
  final String _url = 'url';
  final String _memo = 'memo';
  final String _date = 'date';

  Database database1;

  Future<Database> get database async{
    if (database1 != null) return database1;
    database1 = await initdb();
    return database1;
  }
  Future<Database> initdb() async {
    String path = join(await getDatabasesPath(), 'item.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: createTable,
    );
  }
  Future<void> createTable(Database db, int version) async {
   // String sql = '''
   //   CREATE TABLE
     // $_tablename(
       // $_id TEXT PRIMARY KEY,
        //$_title TEXT,
       // $_email TEXT,
        //$_pass TEXT,
        //$_url TEXT,
        //$_memo TEXT,
        //$_date TEXT,
      //)
      //''';

    return await db.execute('CREATE TABLE item(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, email TEXT, pass TEXT, url TEXT, memo TEXT, date TEXT)');
    print('create table');
    // await db.execute('CREATE TABLE Item(_id TEXT PRIMARY KEY, _title TEXT, _email TEXT, _pass TEXT, _url TEXT, _memo TEXT, _date TEXT)');
  }


   Future<List<Itemkun>> getItems() async {
    final db = await database;
    if (database1 == null){
    database1 = await initdb();
    print('hey');}
    var maps = await db.query(
      itemtable,
      orderBy: '$_id DESC',
    );

    if (maps.isEmpty) return [];

    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<Itemkun>> select(int id) async{
    final db = await database;
    var maps = await db.query(itemtable,
    where: '$_id = ?',
    whereArgs: [id]);
    if(maps.isEmpty) return [];
    return maps.map((map)=> fromMap(map)).toList();
  }

  Future<List<Itemkun>> search(String keyword) async {
    final db = await database;
    print('までは来とる');

    var maps = (keyword != null) ?await db.query(
      itemtable,
      orderBy: '$_id DESC',
      where: '$_title LIKE ?'
      +'OR $_email LIKE ?'
      +'OR $_pass LIKE ?'
      +'OR $_url LIKE ?'
      +'OR $_memo LIKE ?',
      whereArgs: ['%$keyword%','%$keyword%','%$keyword%','%$keyword%','%$keyword%'],
    )
    :await db.query(
      itemtable,
      orderBy: '$_id DESC',
    );

    if (maps.isEmpty) {print(maps);
    return [];
    }else {print(maps);print('db.search');
      return maps.map((map) => fromMap(map)).toList();
    }
  }


  Future tukkomu(Itemkun item) async {
    print('db.dart');
    final db = await database;
    await db.insert(itemtable, item.toMap());
  }


  Future update(Itemkun item, int id) async {
    final db = await database;
    return await db.update(
      itemtable,
      toMap(item),
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  Future delete(int id) async {
    print('delete吉良');
    print(id);
    final db = await database;
    return await db.delete(
      itemtable,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> toMap(Itemkun item) {
    return {
      //_id: item.id,
      _title: item.title,
      _email: item.email,
      _pass: item.pass,
      _url: item.url,
      _memo: item.memo,
      _date: item.date
    };
  }

  Itemkun fromMap(Map<String, dynamic> json) {
    return Itemkun(
      id: json[_id],
      title: json[_title],
      email: json[_email],
      pass: json[_pass],
      url: json[_url],
      memo: json[_memo],
      date: json[_date]
    );
  }

}