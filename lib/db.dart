import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/settingkun.dart';
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
  final String _favorite = 'favorite';
  final String _date = 'date';
  final String _memostyle = 'memostyle';

  final String setting ='setting';

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


     await db.execute('CREATE TABLE item(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, email TEXT, pass TEXT, url TEXT, memo TEXT,favorite INTEGER, memostyle INTEGER, date TEXT)');

   //  await db.execute('CREATE TABLE setting(id INTEGER PRIMARY KEY, lock INTEGER, emph INTEGER, status INTEGER, conseal INTEGER, display1 INTEGER DEFAULT 1, display2 INTEGER DEFAULT 1, display3 INTEGER DEFAULT 1, display4 INTEGER DEFAULT 1, display5 INTEGER DEFAULT 1, date TEXT)');

     //insertSetting(Settingkun(id: 1,lock: 0, emph: 0, status: 0, conseal: 0, display1: 1, display2: 1, display3: 1, display4: 1, display5: 1));
  }


   Future<List<Itemkun>> getItems() async {
    final db = await database;
    if (database1 == null){
    database1 = await initdb();}
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
      orderBy: '$_date DESC',
    );

    if (maps.isEmpty) {
    return [];
    }else {
      return maps.map((map) => fromMap(map)).toList();

      //return maps.map((map) => fromMap(map));
    }
  }

  Future<List<Itemkun>> searchBytitle(String keyword) async {
    final db = await database;

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
      orderBy: '$_title ASC',
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();

    }
  }
  Future<List<Itemkun>> searchByid(String keyword) async {
    final db = await database;

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
      orderBy: '$_email ASC',
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();
    }
  }
  Future<List<Itemkun>> searchBypass(String keyword) async {
    final db = await database;

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
      orderBy: '$_pass ASC',
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();
    }
  }


  Future<List<Itemkun>> searchFAV(String keyword) async {
    final db = await database;

    var maps = (keyword != null) ?await db.query(
      itemtable,
      orderBy: '$_id DESC',
      where: '$_title LIKE ?'
          +'OR $_email LIKE ?'
          +'OR $_pass LIKE ?'
          +'OR $_url LIKE ?'
          +'OR $_memo LIKE ?'
          +'AND $_favorite = 1',
      whereArgs: ['%$keyword%','%$keyword%','%$keyword%','%$keyword%','%$keyword%'],
    )
        :await db.query(
      itemtable,
      orderBy: '$_date DESC',
      where: '$_favorite=1'
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();
    }
  }

  Future<List<Itemkun>> searchBytitleFAV(String keyword) async {
    final db = await database;

    var maps = (keyword != null) ?await db.query(
      itemtable,
      orderBy: '$_id DESC',
      where: '$_title LIKE ?'
          +'OR $_email LIKE ?'
          +'OR $_pass LIKE ?'
          +'OR $_url LIKE ?'
          +'OR $_memo LIKE ?'
          +'AND $_favorite = 1',
      whereArgs: ['%$keyword%','%$keyword%','%$keyword%','%$keyword%','%$keyword%'],
    )
        :await db.query(
      itemtable,
      orderBy: '$_title ASC',
        where: '$_favorite=1'
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();

    }
  }
  Future<List<Itemkun>> searchByidFAV(String keyword) async {
    final db = await database;


    var maps = (keyword != null) ?await db.query(
      itemtable,
      orderBy: '$_id DESC',
      where: '$_title LIKE ?'
          +'OR $_email LIKE ?'
          +'OR $_pass LIKE ?'
          +'OR $_url LIKE ?'
          +'OR $_memo LIKE ?'
          +'AND $_favorite = 1',
      whereArgs: ['%$keyword%','%$keyword%','%$keyword%','%$keyword%','%$keyword%'],
    )
        :await db.query(
      itemtable,
      orderBy: '$_email ASC',
        where: '$_favorite=1'
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();
    }
  }

  Future<List<Itemkun>> searchBypassFAV(String keyword) async {
    final db = await database;


    var maps = (keyword != null) ?await db.query(
      itemtable,
      orderBy: '$_id DESC',
      where: '$_title LIKE ?'
          +'OR $_email LIKE ?'
          +'OR $_pass LIKE ?'
          +'OR $_url LIKE ?'
          +'OR $_memo LIKE ?'
          +'AND $_favorite = 1',
      whereArgs: ['%$keyword%','%$keyword%','%$keyword%','%$keyword%','%$keyword%'],
    )
        :await db.query(
      itemtable,
      orderBy: '$_pass ASC',
        where: '$_favorite=1'
    );

    if (maps.isEmpty) {
    return [];
    }else {
    return maps.map((map) => fromMap(map)).toList();
    }
  }




  Future tukkomu(Itemkun item) async {
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
    final db = await database;
    return await db.delete(
      itemtable,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> toMap(Itemkun item) {
    return {
      _id: item.id,
      _title: item.title,
      _email: item.email,
      _pass: item.pass,
      _url: item.url,
      _memo: item.memo,
      _favorite: item.favorite,
      _memostyle: item.memostyle,
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
      favorite: json[_favorite],
      memostyle: json[_memostyle],
      date: json[_date]
    );
  }





  Future<List<Settingkun>> getSetting() async {
    final db = await database;
    if (database1 == null){
      database1 = await initdb();}
    var maps = await db.query(
      setting,
    );
    if (maps.isEmpty) return [];
    return maps.map((map) => fromMapSetting(map)).toList();
  }

  Future insertSetting(settings) async {
    final db = await database;
    await db.insert(setting, settings.toMap());
  }


  Future updateSetting(settings) async {
    final db = await database;
    return await db.update(
      setting,
      toMapSetting(settings),
      where: 'id = 1',
    );
  }

  Map<String, dynamic> toMapSetting(Settingkun settingkun) {
    return {
      'id': settingkun.id,
      'lock': settingkun.lock,
      'emph': settingkun.emph,
      'status': settingkun.status,
      'conseal': settingkun.conseal,
      'display1': settingkun.display1,
      'display2': settingkun.display2,
      'display3': settingkun.display3,
      'display4': settingkun.display4,
      'display5': settingkun.display5,
      'date': settingkun.date
    };
  }

  Settingkun fromMapSetting(Map<String, dynamic> json) {
    return Settingkun(
        id: json['id'],
        lock: json['lock'],
        emph: json['emph'],
        status: json['status'],
        conseal: json['conseal'],
        display1: json['display1'],
        display2: json['display2'],
        display3: json['display3'],
        display4: json['display4'],
        display5: json['display5'],
        date: json['date']
    );
  }

}

