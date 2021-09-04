import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/db.dart';


class ItemkunRepository{
  final DBProvider itemdatabase;
  ItemkunRepository(this.itemdatabase);


  String table = 'ItemList';

  Future<Itemkun> create(String title, String email, String pass, String url,
      String memo, int memostyle) async{
    DateTime now = DateTime.now();
    final Map<String, dynamic> row ={
      'title' :title,
      'email' :email,
      'pass' :pass,
      'url' :url,
      'memo' :memo,
      'favorite' : 0,
      'memostyle' : memostyle,
      'date' :now.toString()
    };
    final Itemkun _itemkun = Itemkun(id:null, title: title, email: email, pass: pass, url: url, memo: memo, favorite: 0 ,memostyle: memostyle ,date: now.toString());
    //final db = await instance.database;
    final db = await itemdatabase;
    //final id = await db.insert(table, row);
    final id = await db.tukkomu(_itemkun);

    return Itemkun(
        id: row['id'],
        title: row['title'],
        email: row['email'],
        pass: row['pass'],
        url: row['url'],
        memo: row['memo'],
        favorite: row['favorite'],
        memostyle: row['memostyle'],
        date: now.toString(),);
  }

  Future<List<Itemkun>> loadItems() => itemdatabase.getItems();
  Future<List<Itemkun>> search(String element) => itemdatabase.search(element);
  Future<List<Itemkun>> get(int id) => itemdatabase.select(id);
  Future tukkomu(Itemkun item) =>
      //print('repository');
      itemdatabase.tukkomu(item);
  Future update(Itemkun item, int id) => itemdatabase.update(item, id);
  Future delete(int id) => itemdatabase.delete(id);
}