import 'dart:async';
import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/item.dart';
import 'package:password_storage/setting.dart';
import 'package:provider/provider.dart';
import 'package:password_storage/Itemkun_repository.dart';

class Root extends StatefulWidget {

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  
  List<String> consealpassList=[];
  bool consealjudge=true;
  final fontsize = 16;
  final iconsize = 16;
  Color fontcolor = Colors.brown[800];
  var searchtext = TextEditingController();
  String get searchText => searchtext.text;
  final _ItemsChange = StreamController();

  _RootState() {
    streamIn();
  }


  @override
  void dispose() {
    // StreamControllerは必ず開放する
    _ItemsChange.close();
    super.dispose();
  }

  StreamController<List<Itemkun>> _streamController;
  set(String name){
    _value = name;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  streamIn() async{
    _streamController = StreamController<List<Itemkun>>();
    List<Itemkun> karioki = await ItemkunRepository(DBProvider()).search(null);
    print('streamIN karioki↓');
    print(karioki);
    _streamController.add(karioki);
    print(_streamController);
  }
  onchanging(String heke) async {
    //_streamController.close();
    List<Itemkun> karioki012 = await ItemkunRepository(DBProvider()).search(heke);
    print('onchanging　karioki↓');
    print(karioki012);
    _streamController.add(karioki012);
    print(_streamController);
  }


  String _value;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
   // final ooo = Items(ItemkunRepository(DBProvider()));

    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        elevation: 8,
        leading:IconButton(
          icon:Icon(Icons.home_sharp)
          ,onPressed:() {
        },),
        centerTitle: true,
        title:Text("PASSWORDLIST",style: TextStyle(color: Colors.yellow[200]),),
        backgroundColor: Colors.brown[800],
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.shuffle),
              onPressed: () => {
                print(searchtext.text),
                print(searchtext.text.length)

            //  Navigator.push(
             // context,
             // MaterialPageRoute(builder: (context) =>Item()),
              //)
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Setting()),
                )
                },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add) ,onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Item(
              1,
              //null
          )),
        ).then((_) => setState(() {
        }));
      },),
      body: Center(
            child:Container(
              decoration: BoxDecoration(
                color: Colors.amber[200]
              ),
             child:Column(children:<Widget>[
               Container(
                 padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                   height: height*0.07,
                   child:TextField(
                     controller: searchtext,
                 style: TextStyle(color: Colors.brown[700]),
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search, color: Colors.brown[700]),
                   hintText: 'タイトルを検索',
                   hintStyle: TextStyle(color: Colors.brown[700]),
                 ),
                 onChanged:
                     (value){
                       onchanging(value);
                       },
                  )),
                Expanded(
                   //height: height*0.7,
                   child:
                   StreamBuilder(
                    stream: _streamController.stream,
          // ignore: missing_return
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Container(child:Text('hehehe'));
            }
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  final itemlist00 = snapshot.data;
                  final itemkun = itemlist00[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Item(
                          1,
                          //itemlist.items[index].id,
                          //widget._itemkunRepository
                        )),
                      );
                    },
                    child: Card(
                      child: Container(
                        height: height*0.15,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                          width:width*0.85,
                                          decoration: BoxDecoration(border: Border(
                                              bottom: BorderSide(
                                                color: Colors.brown[400],
                                                width:1,
                                              )
                                          )),
                                          height: height*0.03,
                                          child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(itemkun.title
                                            // itemlist.title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),
                                          )])),
                                      Container(
                                          height: height*0.025,
                                          child: Row(children:<Widget>[Text(
                                            'Email:'
                                                +itemkun.email,
                                            style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
                                            IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,), onPressed:(){})])),
                                      Container(
                                        height: height*0.025,
                                        width: width*0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text("PASSWORD:",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: fontsize*adjustsizeh,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black54)),
                                            ),
                                            Container(
                                              child:Text(itemkun.pass,
                                                style: TextStyle(
                                                    fontSize: 16*adjustsizeh,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,),onPressed: (){},),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: height*0.02,
                                          width: width*0.65,
                                          child:Row(children: <Widget>[Flexible(
                                            child:Text(itemkun.url,
                                              style: TextStyle(
                                                fontSize: 16*adjustsizeh,
                                                color: Colors.brown[800],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                            IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh,),)
                                          ])),
                                      Container(
                                        height: height*0.02,
                                        width: width*0.7,
                                        child:Column(children: <Widget>[
                                          Container(
                                              child: Flexible(
                                                child:Text(itemkun.memo,
                                                  style: TextStyle(
                                                    fontSize: 16*adjustsizeh,
                                                    color: Colors.brown[800],
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              )
                                          ),
                                          SizedBox(height: height*0.0000012,),
                                        ]),
                                      ),
                                    ],)
                              ),
                              Container(
                                child: Row(children: <Widget>[
                                  SizedBox(width: width*0.02),
                                  GestureDetector(
                                      onTap: () {
                                      },
                                      child:Icon(Icons.star,color: Colors.yellowAccent[700], size: 30,)
                                  ),
                                  SizedBox(width: width*0.025),
                                ]),
                              ),
                            ]),
                      ),
                    ),
                    //)
                  );
                  //       });
                },
              );
            }
          }
      )
                ),
           ]))
    )
    );
  }
}

//class Items extends ChangeNotifier{
 // final ItemkunRepository _itemkunRepositoryitems;
 // List<Itemkun> _items = [];
 // List<Itemkun> get items => _items;
 // bool _isLoading = false;
 // bool get isLoading => _isLoading;
 // final databaseflg = false;



  //void load() async {
   // loadA();
     // print('loadItems');
   // _items = await _itemkunRepositoryitems.loadItems();
   // print(items.length);
   // print('↓注目');
    //print(ooo);
   // loadB();

  //}

 // search(element) async{
   // loadA();
    //_items = await _itemkunRepositoryitems.search(element);
    //print('検索');
    //print(_items);
    //loadB();
  //}

  //search1(element) async{
    //return _itemkunRepositoryitems.search(element);
 // }

  //void loadA() {
   // _isLoading = true;
    //notifyListeners();
  //}

 // void loadB() {
    //_isLoading = false;
   // notifyListeners();
  //}

 // Items(this._itemkunRepositoryitems){
   //   load();
     // print('やってねんぇ');
  //}
//}

class ItemBuild extends StatefulWidget {
 // final ItemkunRepository _itemkunRepository;

  //ItemBuild(this._itemkunRepository);

  @override
  _ItemBuildState createState() => _ItemBuildState();
}
class _ItemBuildState extends State<ItemBuild> {
  final fontsize = 16;
  final iconsize = 16;
  Color fontcolor = Colors.brown[800];
  final updatejudge = Set<String>();

 // void update(){
   // updatejudge.add('1');
    //print('きｔら');
    //setState(() {
      // updatejudge.remove('1');
   // });
  //}


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    //final Items itemlist = Provider.of<Items>(context);
    final updateon = updatejudge.contains('1');


      return ListView.builder(
         // itemCount: itemlist.items.length,
          itemBuilder: (BuildContext context, int index){
           // var item = itemlist.items[index];

           // return ListViewElement(context, item);
          });}
             Widget ListViewElement(BuildContext context, Itemkun item){
               final height = MediaQuery.of(context).size.height;
               final width = MediaQuery.of(context).size.width;
               final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
             return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Item(
                      1,
                      //itemlist.items[index].id,
                      //null
                      //widget._itemkunRepository
                  )),
                );
              },
              child: Card(
                child: Container(
                  height: height*0.15,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                    width:width*0.85,
                                    decoration: BoxDecoration(border: Border(
                                        bottom: BorderSide(
                                          color: Colors.brown[400],
                                          width:1,
                                        )
                                    )),
                                    height: height*0.03,
                                    child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(item.title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),)])),
                                Container(
                                    height: height*0.025,
                                    child: Row(children:<Widget>[Text('Email:'+item.email, style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
                                      IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,), onPressed:(){})])),
                                Container(
                                  height: height*0.025,
                                  width: width*0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text("PASSWORD:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: fontsize*adjustsizeh,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54)),
                                      ),
                                      //(consealjudge == true) ?
                                      Container(
                                        child:Text(
                                          item.pass,
                                          style: TextStyle(
                                              fontSize: 16*adjustsizeh,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      )
                                      //: Container(child: Text(''),)
                                      ,
                                      IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,),onPressed: (){},),
                                    ],
                                  ),
                                ),

                                Container(
                                    height: height*0.02,
                                    width: width*0.65,
                                    child:Row(children: <Widget>[Flexible(
                                      child:Text(item.url,
                                        style: TextStyle(
                                          fontSize: 16*adjustsizeh,
                                          color: Colors.brown[800],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                      IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh,),)
                                    ])),
                                Container(
                                  height: height*0.02,
                                  width: width*0.7,
                                  child:Column(children: <Widget>[
                                    Container(
                                        child:
                                        //Row(
                                        //  children: <Widget>[
                                        //  SizedBox(
                                        //  width: width*0.05,
                                        //),
                                        Flexible(
                                          child:Text(item.memo,
                                            style: TextStyle(
                                              fontSize: 16*adjustsizeh,
                                              color: Colors.brown[800],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        )
                                      // ]),
                                    ),
                                    SizedBox(height: height*0.0000012,),
                                  ]),
                                ),
                              ],)
                        ),
                        Container(
                          child: Row(children: <Widget>[
                            SizedBox(width: width*0.02),
                            GestureDetector(
                                onTap: () {
                                },
                                child:Icon(Icons.star,color: Colors.yellowAccent[700], size: 30,)
                            ),
                            SizedBox(width: width*0.025),
                          ]),
                        ),
                      ]),
                ),
              ),
            );}

    //if(itemlist.isLoading){
      //return Container(child: CircularProgressIndicator());
    //}
    //if(itemlist.items.isEmpty){
     // return Container();
    //}
   //  futuremethod(String element) {
     // if(element.length == 0 || element == null){
       // print('sakusenA');
        //widget._itemkunRepository.loadItems();}
      //else{
       // print('sakusenB');
        //widget._itemkunRepository.search(element);
      //}

    }

   // return
      //Container(
      //height: height*0.65,
      //child:
      //(_RootState().searchtext.text.length==0)?
     // FutureBuilder(
      //future:widget._itemkunRepository.loadItems(),
        //widget._itemkunRepository.loadItems(),
      //builder:(BuildContext context, AsyncSnapshot snapshot) {

   // if (snapshot.connectionState != ConnectionState.done) {
     // print('今ロード中やねん');
    //return CircularProgressIndicator();
    //}
//    if (snapshot.hasError) {
  //  return Text(snapshot.error.toString());
    //}
    //if (snapshot.hasData) {
      //print('データゲットall');
      //print(_RootState().searchtext==null);
      //print(_RootState().searchtext.text.length);
      //print(_RootState().searchtext.text);
  //  return createListView(context, snapshot);
    //} else {
    //return Container();}});
    //);
  //}
//}

class ItemBuilder extends StatefulWidget {
  final ItemkunRepository _itemkunRepository;
  final Stream<List<Itemkun>> ssstream;

  ItemBuilder(this._itemkunRepository, this.ssstream);

  @override
  _ItemBuilderState createState() => _ItemBuilderState();
}
class _ItemBuilderState extends State<ItemBuilder> {
  final fontsize = 16;
  final iconsize = 16;
  Color fontcolor = Colors.brown[800];
  final updatejudge = Set<String>();
  String _value;

 // void update(){
   // updatejudge.add('1');
    //print('きｔら');
    //setState(() {
      //updatejudge.remove('1');
    //});
 // }

   searching(String element) {
     print('searching');
    widget._itemkunRepository.search(element);
  }

  set(String name){
     _value = name;
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    //final itemlist = Provider.of<Items>(context);
    final updateon = updatejudge.contains('1');
    Widget createListViewer(BuildContext context, AsyncSnapshot snapshot){
      //final  itemlist = Provider.of<Items>(context);
      //final itemlist1 = context.watch<Items>();
      //final hehehe = false;
      //final List<Itemkun> whats = snapshot.data;
      //final List<Itemkun> ok = Provider
     // Stream<List<Itemkun>> _stream = ItemkunRepository(DBProvider()).items as Stream<List<Itemkun>>;
     // List<Itemkun> streaming = Items(ItemkunRepository(DBProvider())).items;

      return FutureBuilder(
          future: searching(_value) ,
          //_stream,
          // ignore: missing_return
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Container();
            }
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              final itemlist00 = snapshot.data as List<Itemkun>;
              final itemkun = itemlist00[index];
              //return ListView.builder(
                //  itemCount: itemlist00.length,
                  //itemBuilder:(context,index){
                    //final itemkun = itemlist00[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>Item(
                            1,
                            //itemlist.items[index].id,
                            //widget._itemkunRepository
                          )),
                        );
                      },
                      child: Card(
                        child: Container(
                          height: height*0.15,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                            width:width*0.85,
                                            decoration: BoxDecoration(border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.brown[400],
                                                  width:1,
                                                )
                                            )),
                                            height: height*0.03,
                                            child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(itemkun.title
                                              // itemlist.title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),
                                            )])),
                                        Container(
                                            height: height*0.025,
                                            child: Row(children:<Widget>[Text(
                                              'Email:'
                                              +itemkun.email,
                                              //+whats[index].email,
                                              style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
                                              IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,), onPressed:(){})])),
                                        Container(
                                          height: height*0.025,
                                          width: width*0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text("PASSWORD:",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: fontsize*adjustsizeh,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black54)),
                                              ),
                                              //(consealjudge == true) ?
                                              Container(
                                                child:Text(itemkun.pass,
                                                  //whats[index].pass,
                                                  style: TextStyle(
                                                      fontSize: 16*adjustsizeh,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                              )
                                              //: Container(child: Text(''),)
                                              ,
                                              IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,),onPressed: (){},),
                                            ],
                                          ),
                                        ),

                                        Container(
                                            height: height*0.02,
                                            width: width*0.65,
                                            child:Row(children: <Widget>[Flexible(
                                              child:Text(itemkun.url,
                                                //itemlist.items[index].url,
                                                style: TextStyle(
                                                  fontSize: 16*adjustsizeh,
                                                  color: Colors.brown[800],
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                              IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh,),)
                                            ])),
                                        Container(
                                          height: height*0.02,
                                          width: width*0.7,
                                          child:Column(children: <Widget>[
                                            Container(
                                                child:
                                                //Row(
                                                //  children: <Widget>[
                                                //  SizedBox(
                                                //  width: width*0.05,
                                                //),
                                                Flexible(
                                                  child:Text(itemkun.memo,
                                                    //whats[index].memo,
                                                    style: TextStyle(
                                                      fontSize: 16*adjustsizeh,
                                                      color: Colors.brown[800],
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              // ]),
                                            ),
                                            SizedBox(height: height*0.0000012,),
                                          ]),
                                        ),
                                      ],)
                                ),
                                Container(
                                  child: Row(children: <Widget>[
                                    SizedBox(width: width*0.02),
                                    GestureDetector(
                                        onTap: () {
                                        },
                                        child:Icon(Icons.star,color: Colors.yellowAccent[700], size: 30,)
                                    ),
                                    SizedBox(width: width*0.025),
                                  ]),
                                ),
                              ]),
                        ),
                      ),
                      //)
                    );
           //       });
            },
          );
        }
          }
          );
      //);
        //ListView.builder(
          //itemCount: itemlist.items.length,
          //itemBuilder: (BuildContext context, int index){
            //var item = itemlist.items[index];

            //return
              //ChangeNotifierProvider(
                //create:(_){Items(ItemkunRepository(DBProvider.instance));},
              // ignore: unnecessary_statements
              //create: (_){itemlist1;},
              //child: 
              //ListViewElement(),

           // );
            //return ListViewElement();
         // });
   }

   // return FutureBuilder(
     //   future:searching(_value),
        //widget._itemkunRepository.search(_RootState().searchText),
        //widget._itemkunRepository.loadItems(),
       // builder:(BuildContext context, AsyncSnapshot snapshot) {

          // if (snapshot.connectionState != ConnectionState.done) {
          // print('今ロード中やねん');
          //return CircularProgressIndicator();
          //}
         // if (snapshot.hasError) {
           // return Text(snapshot.error.toString());
          //}
          //if (snapshot.hasData) {
           // print('データゲットsearch');
           // print(_RootState().searchtext.text);
           // print(_RootState().searchtext.text.length);
            //return createListViewer(context, snapshot);
          //} else {
  //          return Container();}});
  }
  }

class ListViewElement extends StatefulWidget {
  @override
  _ListViewElementState createState() => _ListViewElementState();
}
class _ListViewElementState extends State<ListViewElement> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
   // final Items itemlist = Provider.of<Items>(context);
    //final updateon = updatejudge.contains('1');
    final fontsize = 24;
    final iconsize = 17;
    return
      //Consumer<Itemkun>(
    //builder: (ctx, item, _) =>
      InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Item(
              1,
              //itemlist.items[index].id,
              //widget._itemkunRepository
          )),
        );
      },
      child: Card(
        child: Container(
          height: height*0.15,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            width:width*0.85,
                            decoration: BoxDecoration(border: Border(
                                bottom: BorderSide(
                                  color: Colors.brown[400],
                                  width:1,
                                )
                            )),
                            height: height*0.03,
                            child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(''
                             // itemlist.title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),
                            )])),
                        Container(
                            height: height*0.025,
                            child: Row(children:<Widget>[Text(
                              'Email:',
                                  //+whats[index].email,
                              style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
                              IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,), onPressed:(){})])),
                        Container(
                          height: height*0.025,
                          width: width*0.6,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text("PASSWORD:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: fontsize*adjustsizeh,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54)),
                              ),
                              //(consealjudge == true) ?
                              Container(
                                child:Text('',
                                  //whats[index].pass,
                                  style: TextStyle(
                                      fontSize: 16*adjustsizeh,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              )
                              //: Container(child: Text(''),)
                              ,
                              IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,),onPressed: (){},),
                            ],
                          ),
                        ),

                        Container(
                            height: height*0.02,
                            width: width*0.65,
                            child:Row(children: <Widget>[Flexible(
                              child:Text('',
                                //itemlist.items[index].url,
                                style: TextStyle(
                                  fontSize: 16*adjustsizeh,
                                  color: Colors.brown[800],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                              IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh,),)
                            ])),
                        Container(
                          height: height*0.02,
                          width: width*0.7,
                          child:Column(children: <Widget>[
                            Container(
                                child:
                                //Row(
                                //  children: <Widget>[
                                //  SizedBox(
                                //  width: width*0.05,
                                //),
                                Flexible(
                                  child:Text('',
                                    //whats[index].memo,
                                    style: TextStyle(
                                      fontSize: 16*adjustsizeh,
                                      color: Colors.brown[800],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              // ]),
                            ),
                            SizedBox(height: height*0.0000012,),
                          ]),
                        ),
                      ],)
                ),
                Container(
                  child: Row(children: <Widget>[
                    SizedBox(width: width*0.02),
                    GestureDetector(
                        onTap: () {
                        },
                        child:Icon(Icons.star,color: Colors.yellowAccent[700], size: 30,)
                    ),
                    SizedBox(width: width*0.025),
                  ]),
                ),
              ]),
        ),
      ),
    //)
      );
  }

}



