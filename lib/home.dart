import 'dart:io';

import 'package:cv_app/register.dart';
import 'package:cv_app/user_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_vCard.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var _alignment = Alignment.center;
  double height = 0;
  AnimationController controller;
  Animation<Offset> offset;

  Map<String, String> userData = {};

  getData() async {
    Map value = await UserDatabaseManager.getData();
    setState(() {
      userData = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    offset =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff073b61),
          actions: [
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {
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
                    ],
                  ),
                ))
          ],
        ),
        body: ListView(
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
                            MaterialPageRoute(builder: (context) => Register(true)),
                          );
                        },
                        child: Text(
                          "Edit vCard",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'tag1',
                    onPressed: () {
                      launch("tel://" + userData['mobile'] ?? "");
                    },
                    label: Text("Call Now"),
                    backgroundColor: Color(0xff073b61),
                    icon: Icon(Icons.call),
                  ),
                  FloatingActionButton.extended(
                    heroTag: 'tag2',
                    onPressed: () {
                      final Uri _emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: userData['email'] ?? "",
                      );
                      launch(_emailLaunchUri.toString());
                    },
                    label: Text("Email Me"),
                    backgroundColor: Color(0xff073b61),
                    icon: Icon(Icons.email),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userData['name'] ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userData['designation'] ?? "",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userData['company_name'] ?? "",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    File(userData['photo']),
                    height: 200,
                    width: 200,
                  )
                  // Image.asset('assets/person.png')
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'tag3',
                    onPressed: () async {
                      String body = 'Name: ${userData['c']}\n' +
                          'Designation: ${userData['designation']}\n' +
                          'Company Name: ${userData['company_name']}\n' +
                          'Email: ${userData['email']}\n' +
                          'Mobile: ${userData['mobile']}\n' +
                          'Website: ${userData['website']}';
                      String uri = 'sms:?body=${body}';

                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    },
                    label: Text(
                      "Share by Text",
                      style: TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Color(0xff073b61),
                    icon: Icon(Icons.message),
                  ),
                  FloatingActionButton.extended(
                    heroTag: 'tag4',
                    onPressed: () {
                      String body = 'Name: ${userData['mobile']}\n' +
                          'Designation: ${userData['designation']}\n' +
                          'Company Name: ${userData['company_name']}\n' +
                          'Email: ${userData['email']}\n' +
                          'Mobile: ${userData['mobile']}\n' +
                          'Website: ${userData['website']}';
                      String uri = 'mailto:?body=${body}';
//                     final Uri _emailLaunchUri = Uri(
//   scheme: 'mailto',
//   queryParameters: {
//     'subject': 'vCard',
//     'body' : body
//   }
// );
                      launch(uri.toString());
                    },
                    label: Text(
                      "Share by Email",
                      style: TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Color(0xff073b61),
                    icon: Icon(Icons.email),
                  )
                ],
              ),
            ),


InkWell(
  onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyVCard(name: userData['name'], designation: userData['designation'], company_name: userData['company_name'], email: userData['email'], mobile: userData['mobile'], website: userData['website'], image: userData['photo'],)),
  );
  },
  child:   Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xff073b61),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.download_sharp,
                      color: Colors.white,
                    ),
                    Text(
                      "Download Contact",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
),
          

            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My vCard: ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch(userData['vcardname']);
                    },
                    child: Text(
                      userData['vcardname']+".widlestudio.com" ?? "",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email: ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(
                        new ClipboardData(text: userData['email']));
                    Fluttertoast.showToast(
                        msg: "Email copied",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Text(
                    userData['email'] ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mobile: ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(
                        new ClipboardData(text: userData['mobile']));
                    Fluttertoast.showToast(
                        msg: "Mobile Number copied",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Text(
                    userData['mobile'] ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Website: ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(
                        new ClipboardData(text: userData['website']));
                    Fluttertoast.showToast(
                        msg: "Website copied",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Text(
                    userData['website'] ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
//                 Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width*0.7,
//                     height: 50,

//                     decoration: BoxDecoration(
//     border: Border.all(color: Colors.deepOrange, width: 2) ,
// borderRadius: BorderRadius.all( Radius.circular(5)),
//     color: Colors.orange
//   ),
// padding: EdgeInsets.all(10),
//   child: Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [

//       Icon(Icons.play_arrow, color: Colors.white, size: 35,),

//       Text("Get Your vCard Now!", style: TextStyle(color: Colors.white, fontSize: 20),)
//   ],),
//                   )
//                    ],) ,
          ],
        ));
  }
}
