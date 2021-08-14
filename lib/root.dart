import 'dart:async';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/item.dart';
import 'package:password_storage/setting.dart';
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
  String _value;
  bool deleteon = false;


  _RootState() {
    print('start');
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
    print('initstate');
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

  deleteflg() {
    setState(() {
      deleteon = true;
    });
  }

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
          icon:Icon(Icons.settings)
          ,onPressed:() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>Setting()),
          );
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
              icon: Icon(Icons.delete),
              onPressed: () => {
                  deleteflg()
                },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add) ,onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Item(
              0,
              null
          )),
        ).then((value) => setState(() {
          streamIn();
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
              return Container();
            }
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  final itemlist00 = snapshot.data;
                  final itemkun = itemlist00[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Item(
                          1,
                          //itemlist.items[index].id,
                          itemkun.id
                          //widget._itemkunRepository
                        )),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                          decoration: BoxDecoration(
                                            //color: Colors.lightGreen[800],
                                              border: Border(
                                              bottom: BorderSide(
                                                //color: Colors.brown[400],
                                                color: Colors.white,
                                                width:1,
                                              )
                                          )),
                                          height: height*0.03,
                                          child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(itemkun.title,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 16),
                                            // itemlist.title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),
                                          )])),
                                      Container(
                                          height: height*0.025,
                                          child: Row(children:<Widget>[Text(
                                            'Email:'
                                                +itemkun.email,
                                            style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54),),
                                            (itemkun.email.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,), onPressed:(){
                                              if(itemkun.email.length != 0){
                                              ClipboardManager.copyToClipBoard(
                                                  itemkun.email);}
                                            })
                                                                    :Container(),
                                          ])),
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
                                            (itemkun.pass.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,),onPressed: (){
                                              if(itemkun.pass.legth != 0){
                                                ClipboardManager.copyToClipBoard(
                                                    itemkun.pass);}
                                            },)
                                                                    :Container(),
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
                                            (itemkun.url.length != 0)?IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh,), onPressed: (){
                                              if(itemkun.pass.legth != 0){
                                                ClipboardManager.copyToClipBoard(
                                                    itemkun.url);}
                                            },)
                                                                  :Container()
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
                                height: height*0.15,
                                decoration: BoxDecoration(
                                //  color: Colors.lightGreen[800],
                                ),
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
