import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/Itemkun_repository.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/root.dart';



class Item extends StatefulWidget {
  final argumentmode;
  final id;
  //final _itemkunReository;
  Item(this.argumentmode,
      this.id,
  //this._itemkunReository
      );

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List<bool> isSelected;
  //Itemkun _editItem = [];
   //List<Itemkun> forEdit = [];

  var titletext = TextEditingController();
  var emailtext = TextEditingController();
  var passtext = TextEditingController();
  var urltext = TextEditingController();
  var memotext = TextEditingController();
  TextEditingController titletext0;
  TextEditingController emailtext0;
  TextEditingController passtext0;
  TextEditingController urltext0;
  TextEditingController memotext0;
  //_ItemState(this.titletext0, this.emailtext0, this.passtext0, this.urltext0, this.memotext0);

  @override
  void initState() {
    isSelected = [true, false];
    if(widget.argumentmode == 1){getdata(widget.id);}else{}
    super.initState();
  }

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    titletext0?.dispose();
    emailtext0?.dispose();
    passtext0?.dispose();
    urltext0?.dispose();
    memotext0?.dispose();
    super.dispose();
  }

  void getdata(int id) async{
   var forEdit = await DBProvider().select(id);
    titletext0 = TextEditingController(text:forEdit[0].title);
    emailtext0 = TextEditingController(text:forEdit[0].email);
    passtext0 = TextEditingController(text:forEdit[0].pass);
    urltext0 = TextEditingController(text:forEdit[0].url);
    memotext0 = TextEditingController(text:forEdit[0].memo);
    print('getdataした');
    print(id);
    print(titletext0);
    print(forEdit[0].title);
  }

  void insertdesu() async {
    print('start');
    print(titletext.text);
    print(emailtext.text);
    print(passtext.text);
    print(urltext.text);
    print(memotext.text);
    print('goal');
    return await  ItemkunRepository(DBProvider()).tukkomu(Itemkun(title: titletext.text,email:emailtext.text ,pass:passtext.text ,url:urltext.text ,memo:memotext.text,date: DateTime.now().toString() ));

    //titletext0.clear();
    //emailtext0.clear();
    //passtext0.clear();
    //urltext0.clear();
    //memotext0.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;

    return Scaffold(
        appBar: AppBar(
          elevation: 8,
          leading:IconButton(
            icon:Icon(Icons.home)
            ,onPressed:() {
          },),
          centerTitle: true,
          title:Text("Detail / Edit ",style: TextStyle(color: Colors.yellow[200]),),
          backgroundColor: Colors.brown[800],
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () => {
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () => {
                      },
                ),
                ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {
                },
              ),
            ),
          ],
        ),
        body: Center(child:Column(children: <Widget>[
          //Container(),
             //Expanded(
            SingleChildScrollView(
              //child:Expanded(
                 child:Container(
                decoration: (BoxDecoration(color: Colors.amber[200])),
                //height: height,
            //decoration: BoxDecoration(
              //image: DecorationImage(
                //image: AssetImage("lib/wooden3.jpg"),
                //fit: BoxFit.cover,
              //),
            //),
            child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
      Container(
        height:height*0.5,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Container(
          height: height*0.075,
          width: width*0.85,
          child: (widget.argumentmode == 1)?TextFormField( decoration: InputDecoration(
            labelText: 'title'),
              controller: titletext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
             // onChanged: (value) => vm.setTitle(value),
            style: TextStyle(
                fontSize: 17,
                height: 2.0,
                color: Colors.brown
            ))
          :TextFormField( decoration: InputDecoration(
              labelText: 'title'),
              controller: titletext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              // onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: 17,
                  height: 2.0,
                  color: Colors.brown
              )),),
        Container(
          height: height*0.075,
          width: width*0.85,
          child: (widget.argumentmode == 1) ?TextFormField( decoration: InputDecoration(
        labelText: 'id/Email/user name/etc...'),
              controller: emailtext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? '' : null,
              //onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                fontSize: 17,
                height: 2.0,
                color: Colors.brown
            ))
              :TextFormField( decoration: InputDecoration(
              labelText: 'id/Email/user name/etc...'),
              controller: emailtext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? '' : null,
              //onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: 17,
                  height: 2.0,
                  color: Colors.brown
              )),),
        Container(
          height: height*0.08,
          width: width*0.85,
          child: (widget.argumentmode == 1) ?TextFormField( decoration: InputDecoration(
            labelText: 'PassWord'),
              controller: passtext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              //onChanged: (value) => vm.setTitle(value),
            style: TextStyle(
                fontSize: 20,
                height: 2.0,
                color: Colors.brown
            ))
          :TextFormField( decoration: InputDecoration(
        labelText: 'PassWord'),
                controller: passtext0,
                //initialValue: vm.isNew ? '' : vm.memo.title,
                //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                //onChanged: (value) => vm.setTitle(value),
                style: TextStyle(
                    fontSize: 20,
                    height: 2.0,
                    color: Colors.brown
                )),),
        Container(
          height: height*0.075,
          width: width*0.85,
          child: (widget.argumentmode == 1) ?TextFormField(decoration: InputDecoration(
            labelText: 'URL'),
              controller: urltext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              //onChanged: (value) => vm.setTitle(value),
            style: TextStyle(
                fontSize: 17,
                height: 2.0,
                color: Colors.brown
            ))
          :TextFormField(decoration: InputDecoration(
              labelText: 'URL'),
              controller: urltext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              //onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: 17,
                  height: 2.0,
                  color: Colors.brown
              )),),
      //  Container(
        //    height: height*0.35,
        //  child: Column(children: <Widget>[
          //(isSelected[0]==true) ?
          Container(
            height: height*0.15,
            width: width*0.85,
            child: (widget.argumentmode == 1) ?TextFormField( decoration: InputDecoration(
              labelText: 'memo'),
                controller: memotext,
                //initialValue: vm.isNew ? '' : vm.memo.title,
                //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                //onChanged: (value) => vm.setTitle(value),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              style: TextStyle(
                  fontSize: 15,
                  height: 2.0,
                  color: Colors.brown
              ))
            :TextFormField( decoration: InputDecoration(
                labelText: 'memo'),
                controller: memotext0,
                //initialValue: vm.isNew ? '' : vm.memo.title,
                //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                //onChanged: (value) => vm.setTitle(value),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 15,
                    height: 2.0,
                    color: Colors.brown
                )),)
              //:Container()
       // ],),
        //)
      ],),),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
            height: height*0.03,
            width:width*0.2,
            child:ElevatedButton(onPressed: (){
              Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>Root(
              //)));
            }, child: Text('cancel',style: TextStyle(fontSize: 14*adjustsizeh,color: Colors.yellow[200]),), style:  ElevatedButton.styleFrom(
          primary: Colors.brown,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          )
        ))),
        SizedBox(width: width*0.1,),
        Container(
            height: height*0.03,
            width:width*0.2,
            child:ElevatedButton(onPressed: (){
             insertdesu();
             Navigator.pop(context);
            }, child: Text('OK',style: TextStyle(fontSize: 14*adjustsizeh ,color: Colors.yellow[400]),), style:  ElevatedButton.styleFrom(
            primary: Colors.brown,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            )
        ),))
      ],),)
            ]))
        )
    //)
    ])
        ));
  }
}
