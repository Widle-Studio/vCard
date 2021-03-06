
import 'package:cv_app/home.dart';
import 'package:cv_app/register.dart';
import 'package:cv_app/user_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin{

var _alignment = Alignment.center;
double height = 0;
 AnimationController controller;
  Animation<Offset> offset;
bool signinstatus = true;

checkIfDataSaved() async {
  bool _signinStatus = await UserDatabaseManager.getSigninStatus();
setState(() {
  signinstatus = _signinStatus;
});
  
}

@override
  void initState() {
    // TODO: implement initState
        controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(controller);
    checkIfDataSaved();
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff073b61),
      title: Text("vCard"),
      actions: [
        Padding(padding: EdgeInsets.only(left: 20),
        child: InkWell(
          onTap: (){
             switch (controller.status) {
                  case AnimationStatus.completed:
                    controller.reverse();
                    setState(() {
                      height = 0;
                    });
                    break;
                  case AnimationStatus.dismissed:
                    controller.forward();
                    setState(() {
                      height = 80;
                    });
                    break;
                  default:
                }
          },
          child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Text("Menu"),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.menu),

          SizedBox(
            width: 30,
          ),
        ],),
        )  
        )
       
      ],),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.start,
        children: [
         SlideTransition(
              position: offset,
              child: AnimatedContainer(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  duration: Duration(milliseconds: 150),
                  height: height,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff073b61),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(color: Colors.white),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register(false)),
                          );
                        },
                        child: Text(
                          "Get vCard",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(child: 
            Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: (){
                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Register(false)),
  );
                    },
                    child: Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    height: 50,

                    decoration: BoxDecoration(
    border: Border.all(color: Colors.deepOrange, width: 2) ,
borderRadius: BorderRadius.all( Radius.circular(5)),
    color: Colors.orange
  ),
padding: EdgeInsets.all(10),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Icon(Icons.play_arrow, color: Colors.white, size: 35,),

      Text("Get Your vCard Now!", style: TextStyle(color: Colors.white, fontSize: 20),)
  ],),
                  ),
                  )
                  
                   ],) ,

                  SizedBox(
                    height: 20,

                  ),

                signinstatus ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
  );
                    },

                    child: Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    height: 50,

                    decoration: BoxDecoration(
    border: Border.all(color: Colors.deepOrange, width: 2) ,
borderRadius: BorderRadius.all( Radius.circular(5)),
    color: Colors.orange
  ),
padding: EdgeInsets.all(10),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Icon(Icons.play_arrow, color: Colors.white, size: 35,),

      Text("Show my vCard Now!", style: TextStyle(color: Colors.white, fontSize: 20),)
  ],),
                  ),
                  ) 
                   ],) : Container(),
            ],
            )
            )
            
              
            
        ],
      )
            
    );
}
}
