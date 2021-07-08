import 'package:flutter/material.dart';
import 'package:password_storage/item.dart';
import 'package:password_storage/setting.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  List<String> titleList=['google','yahoo'];
  List<String> mailList=['sample@example.com','sample@example.com'];
  List<String> passwordList=['lolooollol','eoeoeoeoeoe'];
  List<int> passlengthList=[8,11];
  List<String> textList=['ここに必要事項を記入','サブアカウント'];
  List<String> consealpassList=[];
  bool consealjudge=true;

  void changeConseal(){
    if(consealjudge==false){
    consealjudge = true;}else{
      consealjudge =false;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
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



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    bool on = true;

    Widget ListElement(String title, String mail, String password,
         String text){
      return InkWell(
        onTap: () {
        },
        child: Card(
          child: Container(
            height: height*0.12,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(title)])),
                          Container(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: width*0.25,
                                  child:Text("PASSWORD:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14*adjustsizeh,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54)),
                                ),
                                (consealjudge == true) ?Container(
                                  child:Text(
                                    password,
                                    style: TextStyle(
                                        fontSize: 16*adjustsizeh,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ): Container(child: Text(''),)
                                    ,
                              ],
                            ),
                          ),
                          Container(child: Text('Email:'+mail),),
                          Container(
                            width: width*0.65,
                            child:Column(children: <Widget>[
                              Container(
                                child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: width*0.05,
                                      ),
                                      Flexible(
                                        child:Text(text,
                                          style: TextStyle(
                                            fontSize: 16*adjustsizeh,
                                            color: Colors.indigo[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ]),
                              ),
                              SizedBox(height: height*0.012,),
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
      List<Widget>Elements=[];
    if(passwordList.length!=0){
      for(var i=0; i<passwordList.length;i++){
        Elements.add(ListElement(titleList[i], mailList[i], passwordList[i], textList[i]));
      }
    }else{}
    //final itemList;

    return
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
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Item()),
              )
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
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add) ,onPressed: (){},),
      body: Center(
            child:Container(
              decoration: BoxDecoration(
                color: Colors.amber[200]
              ),
             child:Column(children:<Widget>[
               Container(
                   height: height*0.8,
                   child:TextField(
                 style: TextStyle(color: Colors.yellow[100]),
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search, color: Colors.white),
                   hintText: 'タイトルを検索',
                   hintStyle: const TextStyle(color: Colors.white),
                 ),
                // onChanged: (value) => itemList.search(value),
                  )),
               (Elements.length!=0) ?Container(
                   height: height*0.7,
                   child:ListView(
              children: Elements,
            )) :Container(),
           ])),
          ),
    //)
    );
  }
}