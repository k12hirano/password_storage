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

  List<String> titleList=['google','yahoo'];
  List<String> mailList=['sample@example.com','sample@example.com'];
  List<String> passwordList=['lolooollol','eoeoeoeoeoe'];
  List<int> passlengthList=[8,11];
  List<String> urlList=['https://api.flutter.dev/flutter/material/Icons-class.html','https://api.flutter.dev/flutter/material/Icons-class.html'];
  List<String> textList=['ここに必要事項を記入','サブアカウント'];
  List<String> consealpassList=[];
  bool consealjudge=true;
  final fontsize = 16;
  final iconsize = 16;
  Color fontcolor = Colors.brown[800];
  bool screenOn = false;
  final screenManager = Set<String>();
  bool searchflg = false;
  var searchtext = TextEditingController();
  String get searchText => searchtext.text;

  void changeConseal(){
    if(consealjudge==false){
    consealjudge = true;}else{
      consealjudge =false;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      loadscreen();
      print('lets');
    });
    super.initState();
   // for(var i=0;i<passlengthList.length;i++){
     //  String conseal='*';
       //if(passlengthList.length >=2){
      //for(var i=0;i<passlengthList[i]-1;i++){
        //conseal += '*';
      //}}else{}
      //consealpassList.add(conseal);
    //}
  }

  void loadscreen(){
    setState(() {
      screenOn = true;
      screenManager.add("1");
      print(screenManager);
    });
    print('go');
  }

  void reload() async {
    loadscreen();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    final screenGo = screenManager.contains("1");

    final ooo = Items(ItemkunRepository(DBProvider.instance));

    return ChangeNotifierProvider(create:(context)=>ooo ,child:
      //ChangeNotifierProvider(
        //create: (_)=>itemList,
        //child:
        Scaffold(
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
        screenOn = false;
        if(screenManager.contains("1")){screenManager.remove("1");}
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Item(
              1,  null
          )),
        ).then((_) => setState(() {
          print('come back');
          reload();
        }));

        //print(load);
      },),
      body: Center(
            child:(screenGo == true) ?Container(
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
                 onChanged:(value) {print(value);_ItemBuilderState().set(value);}
                     //(value){ _ItemBuilderState().searching(value);}
                     //(value){ ooo.search(value);},
                  )),
                Expanded(
                   //height: height*0.7,
                   child:(searchtext.text.length == 0) ?ItemBuild(ItemkunRepository(DBProvider.instance))
                       :ItemBuilder(ItemkunRepository(DBProvider.instance))
                ),
           ]))
                :Container(child:CircularProgressIndicator())
    //)
    )
    ));
  }
}

class Items extends ChangeNotifier{
  final ItemkunRepository _itemkunRepositoryitems;
  List<Itemkun> _items = [];
  List<Itemkun> get items => _items;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final databaseflg = false;

  void load() async {
   // loadA();
     // print('loadItems');
    //_items = await _itemkunRepositoryitems.loadItems();
   // print(_items.length);
   // print(_items);
    //loadB();

  }

  void search(element) async{
    loadA();
    _items = await _itemkunRepositoryitems.search(element);
    print('検索');
    loadB();
  }
  void loadA() {
    _isLoading = true;
    notifyListeners();
  }

  void loadB() {
    _isLoading = false;
    notifyListeners();
  }

  Items(this._itemkunRepositoryitems){
      load();
      print('やってねんぇ');
  }
}

class ItemBuild extends StatefulWidget {
  final ItemkunRepository _itemkunRepository;

  ItemBuild(this._itemkunRepository);

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
    final Items itemlist = Provider.of<Items>(context);
    final updateon = updatejudge.contains('1');


    Widget createListView(BuildContext context, AsyncSnapshot snapshot){
      //final Items itemlist = Provider.of<Items>(context);
      final List<Itemkun> whats = snapshot.data;
      return ListView.builder(
          itemCount: whats.length,
          itemBuilder: (BuildContext context, int index){
            //var item = itemlist.items[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Item(
                      1,
                      //itemlist.items[index].id,
                      widget._itemkunRepository
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
                                    child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(whats[index].title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),)])),
                                Container(
                                    height: height*0.025,
                                    child: Row(children:<Widget>[Text('Email:'+whats[index].email, style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
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
                                          whats[index].pass,
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
                                      child:Text(itemlist.items[index].url,
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
                                          child:Text(whats[index].memo,
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
            );
          });}

    Widget createListView1(BuildContext context, AsyncSnapshot snapshot){
      //final Items itemlist = Provider.of<Items>(context);
      final List<Itemkun> whats = snapshot.data;
      return ListView.builder(
          itemCount: whats.length,
          itemBuilder: (BuildContext context, int index){
            //var item = itemlist.items[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Item(
                      1,
                      //itemlist.items[index].id,
                      widget._itemkunRepository
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
                                    child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(whats[index].title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),)])),
                                Container(
                                    height: height*0.025,
                                    child: Row(children:<Widget>[Text('Email:'+whats[index].email, style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
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
                                          whats[index].pass,
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
                                      child:Text(whats[index].url,
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
                                          child:Text(whats[index].memo,
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
            );
          });}
    //if(itemlist.isLoading){
      //return Container(child: CircularProgressIndicator());
    //}
    //if(itemlist.items.isEmpty){
     // return Container();
    //}
     futuremethod(String element) {
      if(element.length == 0 || element == null){
        print('sakusenA');
        widget._itemkunRepository.loadItems();}
      else{
        print('sakusenB');
        widget._itemkunRepository.search(element);
      }

    }

    return
      //Container(
      //height: height*0.65,
      //child:
      //(_RootState().searchtext.text.length==0)?
      FutureBuilder(
      future:widget._itemkunRepository.loadItems(),
      //widget._itemkunRepository.loadItems(),
      builder:(BuildContext context, AsyncSnapshot snapshot) {

   // if (snapshot.connectionState != ConnectionState.done) {
     // print('今ロード中やねん');
    //return CircularProgressIndicator();
    //}
    if (snapshot.hasError) {
    return Text(snapshot.error.toString());
    }
    if (snapshot.hasData) {
      print('データゲットall');
      print(_RootState().searchtext==null);
      print(_RootState().searchtext.text.length);
      print(_RootState().searchtext.text);
    return createListView(context, snapshot);
    } else {
    return Container();}});
    //);
  }
}

class ItemBuilder extends StatefulWidget {
  final ItemkunRepository _itemkunRepository;

  ItemBuilder(this._itemkunRepository);

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
    final Items itemlist = Provider.of<Items>(context);
    final updateon = updatejudge.contains('1');
    Widget createListViewer(BuildContext context, AsyncSnapshot snapshot){
      //final Items itemlist = Provider.of<Items>(context);
      final List<Itemkun> whats = snapshot.data;
      return ListView.builder(
          itemCount: whats.length,
          itemBuilder: (BuildContext context, int index){
            //var item = itemlist.items[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Item(
                      1,
                      //itemlist.items[index].id,
                      widget._itemkunRepository
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
                                    child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(whats[index].title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),)])),
                                Container(
                                    height: height*0.025,
                                    child: Row(children:<Widget>[Text('Email:'+whats[index].email, style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
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
                                          whats[index].pass,
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
                                      child:Text(itemlist.items[index].url,
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
                                          child:Text(whats[index].memo,
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
            );
          });}

    return FutureBuilder(
        future:searching(_value),
        //widget._itemkunRepository.search(_RootState().searchText),
        //widget._itemkunRepository.loadItems(),
        builder:(BuildContext context, AsyncSnapshot snapshot) {

          // if (snapshot.connectionState != ConnectionState.done) {
          // print('今ロード中やねん');
          //return CircularProgressIndicator();
          //}
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            print('データゲットsearch');
            print(_RootState().searchtext.text);
            print(_RootState().searchtext.text.length);
            return createListViewer(context, snapshot);
          } else {
            return Container();}});
  }
  }

