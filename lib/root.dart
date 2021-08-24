import 'dart:async';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/item.dart';
import 'package:password_storage/setting.dart';
import 'package:password_storage/Itemkun_repository.dart';
import 'package:password_storage/settingkun.dart';

class Root extends StatefulWidget {

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  
  List<String> consealpassList=[];
  bool consealjudge=true;
  final fontsize = 16;
  final iconsize = 13;
  Color fontcolor = Colors.brown[800];
  var searchtext = TextEditingController();
  String get searchText => searchtext.text;
  final _ItemsChange = StreamController();
  String _value;
  bool deleteon = false;
 // List<bool> deleteflgEach = [];
  final favorite = Set<int>();
  final deleteValueList = Set<String>();
  //List<String> deleteValueList = [];
  List<bool> deleteCheckList =[];
  bool lock;
  bool emphasis;
  bool status;
  bool conseal;
  int display1 =1;
  int display2 =1;
  int display3 =1;
  int display4 =1;
  bool display5 = true;
  int displayInt5 =1;
  double displayHeight = 5.0;

//TODO db 初期値としてdisplay群にtrue(1)を挿入時にいれとく
  //TODO favorite 初期値を画面遷移時に代入


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

  List<Itemkun> listkun=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initstate');
  }

  streamIn() async{
   // if(deleteflgEach.length!=0){
   // deleteflgEach.removeRange(0, deleteflgEach.length);
   // }
    List<Settingkun> settingList = await DBProvider().getSetting();
    if(settingList == null || settingList.length==0){
      DBProvider().insertSetting(Settingkun(id: 1,lock: 0, emph: 0, status: 0, conseal: 0, display1: 1, display2: 1, display3: 1, display4: 1, display5: 1));
      lock = false;emphasis = false;status=false;conseal=false;
      display1=1;display2=1;display3=1;display4=1;displayInt5=1;display5=true;
    }else{
      if(settingList.length !=0){
        if(settingList[0].lock==0){lock=false;}else{lock=true;}
        if(settingList[0].status==0){status=false;}else{status=true;}
        if(settingList[0].emph==0){emphasis=false;}else{emphasis=true;}
        if(settingList[0].conseal==0){conseal=false;}else{emphasis=true;}
        display1 = settingList[0].display1;
        display2 = settingList[0].display2;
        display3 = settingList[0].display3;
        display4 = settingList[0].display4;
        if(settingList[0].display5==0){display5=false;}else{display5=true;}
        displayInt5 = settingList[0].display5;}
      if(display1==0){displayHeight--;}
      if(display2==0){displayHeight--;}
      if(display3==0){displayHeight--;}
      if(display4==0){displayHeight--;}
      if(displayInt5==0){displayHeight--;}

    }
    if(listkun.length != 0){
      listkun.removeRange(0, listkun.length);
    }
    _streamController = StreamController<List<Itemkun>>();
    List<Itemkun> karioki = await ItemkunRepository(DBProvider()).search(null);
    print('streamIN karioki↓');
    print(karioki);
    _streamController.add(karioki);
    for(var i=0;i<karioki.length;i++){
      listkun.add(karioki[i]);
    }
    if(deleteCheckList.length != 0){
      deleteCheckList.removeRange(0, deleteCheckList.length);
    }
    for(var i=0;i<karioki.length;i++){
      deleteCheckList.add(false);
    }

    if(favorite.isNotEmpty){
      //TODO set 空にする方法
      final favorite = Set<int>();
    }
    for(var i=0;i<karioki.length;i++){
      if(karioki[i].favorite==1){
      favorite.add(karioki[i].id);
      }
    }



   // for(var i=0;i<karioki.length;i++) {
   //   deleteflgEach.add(false);
  //  }
   // print(_streamController);
  }
  onchanging(String heke) async {
    //_streamController.close();
   // if(deleteflgEach.length!=0){
    //  deleteflgEach.removeRange(0, deleteflgEach.length);
   // }
    if(listkun.length != 0){
      listkun.removeRange(0, listkun.length);
    }
    List<Itemkun> karioki0 = await ItemkunRepository(DBProvider()).search(heke);
    print('onchanging　karioki↓');
    print(karioki0);
    _streamController.add(karioki0);
    for(var i=0;i<karioki0.length;i++){
      listkun.add(karioki0[i]);
    }
   // for(var i=0;i<karioki0.length;i++) {
    //  deleteflgEach.add(false);
   // }

    if(favorite.isNotEmpty){
      final favorite = Set<int>();
    }
    for(var i=0;i<karioki0.length;i++){
      if(karioki0[i].favorite==1){
        favorite.add(karioki0[i].id);
      }
    }
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
    List<String> deleteCheck = [];
    List<bool> deleteflgEach = [];


    deleteValue(String id){
      print('deleteValue');
      print(deleteValueList.contains(id));
      return deleteValueList.contains(id);
    }



   // if(listkun.length != 0){
   //   for(var i=0; i<listkun.length; i++){
       // deleteflgEach.add(false);
     // }
     // print('listkun');
     // print(deleteflgEach);
    //}


    deleteDo() {
      if(deleteValueList.length != 0) {
        final List<String> forDelete = deleteValueList.toList();
        print(forDelete);
        for (var i = 0; i < deleteValueList.length; i++) {
          ItemkunRepository(DBProvider()).delete(int.parse(forDelete[i]));
        }
        print('cest fini!');
      }
    }
    int choice;
    var shuffleList=['Date', 'Name(title)', 'Name(ID)','Name(pass)', 'favorite only'];


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
            child:PopupMenuButton(
              icon: Icon(Icons.shuffle),
              //iconSize: ,
              //color: ,
              //initialValue: choice,
              onSelected: (value){
                setState(() {
                  choice = value;
                  print(choice);
                });
              },
              itemBuilder: (BuildContext context) {
                return[
                   PopupMenuItem(
                    child: Text('Date'),
                    value: 1,
                     enabled: (choice==1)?false:true,
                  ),
                    PopupMenuItem(
                      child: Text('Name(title)'),
                      value: 2,
                      enabled: (choice==2)?false:true,
                    ),
                  PopupMenuItem(
                    child: Text('Name(ID)'),
                  value: 3,
                    enabled: (choice==3)?false:true,
                  ),
                  PopupMenuItem(
                      child: Text('Name(pass'),
                  value: 4,
                    enabled: (choice==4)?false:true,
                  ),
                  PopupMenuItem(
                    child: Text('favorite only'),
                  value: 5,
                    enabled: (choice==5)?false:true,
                  ),
                  ];
              },
            ) ,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: (deleteon == false)?IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => {
                  deleteflg()
                },
            )
            :IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: (deleteon == false)?FloatingActionButton(child:Icon(Icons.add) ,onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Item(
              0,
              null
          )),
        ).then((value) => setState(() {
          streamIn();
        }));
      },)
        :Container(),
      body: (deleteon == false) ?Center(
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
                   hintText: 'search',
                   // 'タイトルを検索',
                   hintStyle: TextStyle(color: Colors.brown[700], fontSize: 18),
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

             if(snapshot.connectionState == ConnectionsState.waiting){
               return CircularProgressIndicator();
             }

            if(!snapshot.hasData){
              return Container();
            }
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  final itemlist00 = snapshot.data;
                  final itemkun = itemlist00[index];
                  final favoriteCheck = favorite.contains(itemkun.id);
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
                    onLongPress: () async {
                      //Dialog with copy,delete,edit
                      var dialog = await showDialog(context: context, builder: (BuildContext context){
                        return SimpleDialog(children: <Widget>[
                          SimpleDialogOption(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>Item(
                                  1,
                                  itemkun.id
                              )),
                            );
                          },child: Container(
                            height:height*0.05,
                            width:width*0.4,
                            alignment:Alignment.center,
                        decoration: BoxDecoration(
                        color: Colors.brown[700],
                        border: Border.all(
                        //color: Colors.brown[400],
                        color: Colors.brown[800],
                        width:1,
                        )),
                            child:Text('edit',style: TextStyle(fontSize: 22, color: Colors.yellow[200]),),)),
                          SimpleDialogOption(onPressed: (){
                            ItemkunRepository(DBProvider()).tukkomu(Itemkun(title: itemkun.title,email: itemkun.email,pass: itemkun.pass,url: itemkun.url,memo: itemkun.memo, date: DateTime.now().toString()));
                            Navigator.pop(context);
                          },child: Container(
                        height:height*0.05,
                        width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.brown[700],
                                border: Border.all(
                                  //color: Colors.brown[400],
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                        child:Text('copy', style: TextStyle(fontSize: 22, color: Colors.yellow[200]),),)),
                          SimpleDialogOption(onPressed: (){
                            ItemkunRepository(DBProvider()).delete(itemkun.id);
                            Navigator.pop(context);
                            setState(() {
                               streamIn();
                            });
                          },child: Container(
                        height:height*0.05,
                        width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.brown[700],
                                border: Border.all(
                                  //color: Colors.brown[400],
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                        child:Text('delete', style: TextStyle(fontSize: 22, color: Colors.yellow[200]),),))
                        ],);
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        //height: height*0.15,
                        //height: height*0.17,
                        height: height*0.02+height*0.03*displayHeight,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      (display1 == 1)?Container(
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
                                          )])):Container(),
                                      (display2 == 1)?Container(
                                          height: height*0.025,
                                          child: Row(children:<Widget>[Text(
                                            'ID/Email: '
                                                +itemkun.email,
                                            style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54, fontWeight: FontWeight.w600),),
                                            (itemkun.email.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,), onPressed:(){
                                              if(itemkun.email.length != 0){
                                              ClipboardManager.copyToClipBoard(
                                                  itemkun.email);}
                                            })
                                                                    :Container(),
                                          ])):Container(),
                                      (display3 == 1)?Container(
                                        height: height*0.025,
                                        width: width*0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text("PASSWORD: ",
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
                                                    color:(emphasis == true)? Colors.blue :Colors.black54),
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
                                      ):Container(),
                                      (display4 == 1)?Container(
                                          height: height*0.02,
                                          width: width*0.65,
                                          child:
                                          Row(children: <Widget>[
                                            Flexible(
                                            child:Text(itemkun.url,
                                              style: TextStyle(
                                                fontSize: 16*adjustsizeh,
                                                color: Colors.brown[800],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                            (itemkun.url.length != 0)?IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh,), onPressed: (){
                                              if(itemkun.pass.legth != 0){
                                                ClipboardManager.copyToClipBoard(
                                                    itemkun.url);}
                                            },)
                                                                  :Container()
                                          ])):Container(),
                                      (display5 == true)?Container(
                                        height: height*0.025,
                                        width: width*0.7,
                                        //alignment: Alignment.topLeft,
                                       // child:
                                        //Column(children: <Widget>[
                                         // Container(
                                              child:Row(children:<Widget>[
                                                SizedBox(width: width*0.03,),
                                              Flexible(
                                                child:Text(itemkun.memo,
                                                  style: TextStyle(
                                                    fontSize: 12*adjustsizeh,
                                                    color: Colors.brown[800],
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Container(),
                                              ])
                                         // ),
                                          //SizedBox(height: height*0.0000012,),
                                       // ]),
                                      ):Container(),
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
                                        if(favoriteCheck){
                                          ItemkunRepository(DBProvider()).update(Itemkun(id: itemkun.id, title:itemkun.title, email:itemkun.email, pass: itemkun.pass, url: itemkun.url, memo: itemkun.memo, favorite: 0, date: DateTime.now().toString()) ,itemkun.id);
                                          setState(() {
                                            favorite.remove(itemkun.id);
                                          });
                                        }else{
                                          ItemkunRepository(DBProvider()).update(Itemkun(id: itemkun.id, title:itemkun.title, email:itemkun.email, pass: itemkun.pass, url: itemkun.url, memo: itemkun.memo, favorite: 1, date: DateTime.now().toString()) ,itemkun.id);
                                          setState(() {
                                            favorite.add(itemkun.id);
                                          });
                                        }
                                      },
                                      child:(favoriteCheck)?Icon(Icons.favorite,color: Colors.brown[700], size: 30*adjustsizeh,)
                                          :Icon(Icons.favorite_border, color: Colors.brown[700], size: 30*adjustsizeh,)
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
          :Center(
          child:Container(
              decoration: BoxDecoration(
                  color: Colors.amber[200]
              ),
              child:Column(children:<Widget>[
                Container(
                  height: height*0.07,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      print(deleteCheckList.length);
                      for(var i=0;i<deleteCheckList.length;i++){
                        deleteCheckList[i]=true;
                        print(deleteCheckList);
                        print(i);
                      }
                      print(deleteCheckList);
                    });
                  }, child: Text('all check', style: TextStyle(color: Colors.yellow[200]),), style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                  )),
                  SizedBox(width: width*0.2,),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      for(var i=0;i<deleteCheckList.length;i++){
                        deleteCheckList[i]=false;
                      }
                      print(deleteCheckList);
                    });
                  }, child: Text('all clear',style: TextStyle(color: Colors.yellow[200]),), style: ElevatedButton.styleFrom(
            primary: Colors.brown,
          ),)
                ],),),
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
                                return Container(child:Row(children:<Widget>[
                                  Container(
                                    height:height*0.15*0.7,
                                    width:width*0.1,
                                    child: Checkbox(
                                      activeColor: Colors.brown,
                                      value: deleteCheckList[index],
                                      // deleteValue(itemkun.id.toString()),
                                      // deleteflgEach[index],
                                      onChanged: (value){
                                        setState(() {
                                          // ??? = value;
                                           // deleteflgEach[index] = value;
                                            //print(listkun);
                                          if(value) {
                                            //deleteflgEach[index] = false;
                                            print('valueon');
                                            print(deleteValueList);
                                            print(itemkun.id.toString());
                                            print(deleteValueList.contains(itemkun.id.toString()));
                                            deleteCheckList[index] = value;
                                            if(deleteValueList.contains(itemkun.id.toString())==false){
                                            deleteValueList.add(itemkun.id.toString());
                                            print(deleteValueList);}
                                          }
                                         else{
                                            print(deleteValueList);
                                            //print(value);
                                            //deleteflgEach[index] = true;
                                            deleteCheckList[index] = value;
                                            print('valueoff');
                                            if(deleteValueList.contains(itemkun.id.toString())){
                                            deleteValueList.remove(itemkun.id.toString());
                                            print(deleteValueList);}
                                          }
                                        });

                                      },
                                    ),),
                                  InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                        
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      height: height*0.7*0.02+height*0.7*0.03*displayHeight,
                                      width: width*0.8,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    (display1 ==1)?Container(
                                                        width:width*0.85*0.7,
                                                        decoration: BoxDecoration(
                                                          //color: Colors.lightGreen[800],
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                  //color: Colors.brown[400],
                                                                  color: Colors.white,
                                                                  width:1,
                                                                )
                                                            )),
                                                        height: height*0.03*0.7,
                                                        child:Row(children:<Widget>[SizedBox(width: width*0.05*0.7,),Text(itemkun.title,
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 16*adjustsizeh*0.7),
                                                          // itemlist.title,style: TextStyle(fontSize: fontsize*adjustsizeh*1.1, color: fontcolor),
                                                        )])):Container(),
                                                    (display2 == 1)?Container(
                                                        height: height*0.025*0.8,
                                                        child: Row(children:<Widget>[Text(
                                                          'Email:'
                                                              +itemkun.email,
                                                          style: TextStyle(fontSize:fontsize*adjustsizeh*0.7, color: Colors.black54),),
                                                          (itemkun.email.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh*0.7,), onPressed:(){
                                                            if(itemkun.email.length != 0){
                                                              ClipboardManager.copyToClipBoard(
                                                                  itemkun.email);}
                                                          })
                                                              :Container(),
                                                        ])):Container(),
                                                    (display3 == 1)?Container(
                                                      height: height*0.025*0.7,
                                                      width: width*0.6*0.8,
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
                                                                  fontSize: 16*adjustsizeh*0.7,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.blue),
                                                            ),
                                                          ),
                                                          (itemkun.pass.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh*0.7,),onPressed: (){
                                                            if(itemkun.pass.legth != 0){
                                                              ClipboardManager.copyToClipBoard(
                                                                  itemkun.pass);}
                                                          },)
                                                              :Container(),
                                                        ],
                                                      ),
                                                    ):Container(),
                                                    (display4 == 1)?Container(
                                                        height: height*0.02*0.7,
                                                        width: width*0.65*0.7,
                                                        child:Row(children: <Widget>[
                                                          Flexible(
                                                          child:Text(itemkun.url,
                                                            style: TextStyle(
                                                              fontSize: 16*adjustsizeh,
                                                              color: Colors.brown[800],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                          (itemkun.url.length != 0)?IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh*0.7,), onPressed: (){
                                                            if(itemkun.pass.legth != 0){
                                                              ClipboardManager.copyToClipBoard(
                                                                  itemkun.url);}
                                                          },)
                                                              :Container()
                                                        ])):Container(),
                                                    (display5 == true)?Container(
                                                        height: height*0.02,
                                                        width: width*0.7,
                                                        alignment: Alignment.topLeft,
                                                        // child:
                                                        //Column(children: <Widget>[
                                                        // Container(
                                                        child: Row(children: <Widget>
                                                        [Flexible(
                                                          child:Text(itemkun.memo,
                                                            style: TextStyle(
                                                              fontSize: 16*adjustsizeh*0.7,
                                                              color: Colors.brown[800],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        )])
                                                      // ),
                                                      //SizedBox(height: height*0.0000012,),
                                                      // ]),
                                                    ):Container(),
                                                  ],)
                                            ),
                                            Container(
                                              height: height*0.15*0.7,
                                              decoration: BoxDecoration(
                                                //  color: Colors.lightGreen[800],
                                              ),
                                              child: Row(children: <Widget>[
                                                SizedBox(width: width*0.02*0.7),
                                                GestureDetector(
                                                    onTap: () {
                                                    },
                                                    child:Icon(Icons.star,color: Colors.yellowAccent[700], size: 30*0.7,)
                                                ),
                                                SizedBox(width: width*0.025*0.7),
                                              ]),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),

                                ]));
                                //       });
                              },
                            );
                          }
                        }
                    )
                ),
                Container(
                  height: height*0.1,
                  width: width*0.7,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                  onPressed: () {
                    print('hey');
                    //for(var i=0; i<deleteCheck.length; i++) {
                     // ItemkunRepository(DBProvider()).delete(int.parse(deleteCheck[0]));
                    //}
                    print(deleteDo);
                    deleteDo();
                    setState(() {
                      deleteon = false;
                      print(deleteon);
                      streamIn();
                    });
                  },
                    style:ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                  child: Text('DELETE', style: TextStyle(color: Colors.yellow[200]),),),),
              ]))
      )
    );

  }
}
