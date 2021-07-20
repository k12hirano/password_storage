import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/db.dart';


class ItemkunRepository{
  final DBProvider itemdatabase;
  ItemkunRepository(this.itemdatabase);


  String table = 'ItemList';
  DBProvider instance = DBProvider.instance;

  Future<Itemkun> create(String title, String email, String pass, String url,
      String memo) async{
    DateTime now = DateTime.now();
    final Map<String, dynamic> row ={
      'title' :title,
      'email' :email,
      'pass' :pass,
      'url' :url,
      'memo' :memo,
      'date' :now.toString()
    };
    final db = await instance.database;
    final id = await db.insert(table, row);

    return Itemkun(
        id: row['id'],
        title: row['title'],
        email: row['email'],
        pass: row['pass'],
        url: row['url'],
        memo: row['memo'],
        date: now.toString(),);
  }

  Future<List<Itemkun>> loadItems() => DBProvider.instance.getItems();
  Future<List<Itemkun>> search(String element) => DBProvider.instance.search(element);
  Future<List<Itemkun>> get(int id) => DBProvider.instance.select(id);
  static Future tukkomu(Itemkun item) =>
      //print('repository');
      DBProvider.instance.tukkomu(item);
  Future update(Itemkun item, int id) => DBProvider.instance.update(item, id);
  Future delete(int id) => DBProvider.instance.delete(id);
}