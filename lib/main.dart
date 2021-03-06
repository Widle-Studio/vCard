import 'package:cv_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  runApp(MyApp());
  Hive.initFlutter();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vCard',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

// var _alignment = Alignment.center;
// double height = 0;
//  AnimationController controller;
//   Animation<Offset> offset;



// @override
//   void initState() {
//     // TODO: implement initState
//         controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));

//     offset = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
//         .animate(controller);
//     super.initState();
//   }

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Color(0xff073b61),
      
//       actions: [
//         Padding(padding: EdgeInsets.only(left: 20),
//         child: InkWell(
//           onTap: (){
//              switch (controller.status) {
//                   case AnimationStatus.completed:
//                     controller.reverse();
//                     setState(() {
//                       height = 0;
//                     });
//                     break;
//                   case AnimationStatus.dismissed:
//                     controller.forward();
//                     setState(() {
//                       height = 50;
//                     });
//                     break;
//                   default:
//                 }
//           },
//           child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//           Text("Menu"),
//           SizedBox(
//             width: 10,
//           ),
//           Icon(Icons.menu),

//           SizedBox(
//             width: 30,
//           ),
//         ],),
//         )  
//         )
       
//       ],),
//       body: ListView(
//         children: [
//            SlideTransition(
//               position: offset,
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
// AnimatedContainer(
//   padding: EdgeInsets.only(left: 20, top: 10,),
//                   duration: Duration(milliseconds: 200),
//                   height: height,
//                   width: MediaQuery.of(context).size.width,
//                   color: Color(0xff073b61),

//                   child: Text("Home", style: TextStyle(color: Colors.white),),
//                 ),
//               ],) 
              
//             ),
            
//             Padding(padding: EdgeInsets.all(10),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton.extended(onPressed: (){

//                   }, label: Text("Call Now"), backgroundColor: Color(0xff073b61), icon: Icon(Icons.call),),

//                     FloatingActionButton.extended(onPressed: (){

//                   }, label: Text("Email Me"), backgroundColor: Color(0xff073b61), icon: Icon(Icons.email),)
//               ],) ,),

//                           Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text("Bhavik Limani", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
//               ],) ,),

//                   Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text("CEO", style: TextStyle(fontSize: 20),)
//               ],) ,),

//               Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text("Widle Studio LLP", style: TextStyle(fontSize: 20),)
//               ],) ,),

//               Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/person.png')
//               ],) ,),

//                Padding(padding: EdgeInsets.all(10),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton.extended(onPressed: (){

//                   }, label: Text("Share by Text", style: TextStyle(fontSize: 12),), backgroundColor: Color(0xff073b61), icon: Icon(Icons.message),),

//                     FloatingActionButton.extended(onPressed: (){

//                   }, label: Text("Share by Email", style: TextStyle(fontSize: 12),), backgroundColor: Color(0xff073b61), icon: Icon(Icons.email),)
//               ],) ,),

//       Center(child: 
      
//       Container(
//         height: 50,
//         width: MediaQuery.of(context).size.width*0.8,
//         decoration: BoxDecoration(
//         borderRadius: BorderRadius.all( Radius.circular(40)),
//         color: Color(0xff073b61),
        
//       ),

//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         Icon(Icons.download_sharp, color: Colors.white,),
//         Text("Download Contact", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),)


//       ],),
//       )
//       ,),

// Padding(padding: EdgeInsets.all(10),
            
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [

//                    Text("My vCard: bhaviklimani.widlestudio.com", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)
//                    ],) ,),

// Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text("Email: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),),

//                   GestureDetector(
//                     onHorizontalDragEnd: (value){

//                     },
//                     child: Text("limanibhavik@gmail.com", style: TextStyle(fontSize: 18, color: Colors.blueAccent),),
//                   ) 
//                    ],) ,
//       SizedBox(
//         height: 10
//       ),
//         Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text("Mobile: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),)
// ,
//                   GestureDetector(
//                     onHorizontalDragEnd: (value){

//                     },
//                     child: Text("942-742-1083", style: TextStyle(fontSize: 18, color: Colors.blueAccent),),
//                   ) 
//                    ],) ,
//          SizedBox(
//         height: 10
//       ),
//         Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                    Text("Website: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),)
// ,
//                   GestureDetector(
//                     onHorizontalDragEnd: (value){

//                     },
//                     child: Text("linkedin.com", style: TextStyle(fontSize: 18, color: Colors.blueAccent),),
//                   ) 
//                    ],) ,
//          SizedBox(
//         height: 10
//       ),
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
            
//         ],
//       )
            
//     );
// }
// }


// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:async';
// import 'dart:typed_data';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }


// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:ui';

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// const kCanvasSize = 200.0;

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ImageGenerator(),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ImageGenerator extends StatefulWidget {
//   final Random rd;
//   final int numColors;

//   ImageGenerator()
//       : rd = Random(),
//         numColors = Colors.primaries.length;

//   @override
//   _ImageGeneratorState createState() => _ImageGeneratorState();
// }

// class _ImageGeneratorState extends State<ImageGenerator> {
//   ByteData imgBytes;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: RaisedButton(
//                 child: Text('Generate image'), onPressed: generateImage),
//           ),
//           imgBytes != null
//               ? Center(
//                   child: Image.memory(
//                   Uint8List.view(imgBytes.buffer),
//                   width: kCanvasSize,
//                   height: kCanvasSize,
//                 ))
//               : Container()
//         ],
//       ),
//     );
//   }

//   void generateImage() async {
//     final color = Colors.primaries[widget.rd.nextInt(widget.numColors)];

//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder,
//         Rect.fromPoints(Offset(0.0, 0.0), Offset(kCanvasSize, kCanvasSize)));

//     final stroke = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke;

//     canvas.drawRect(Rect.fromLTWH(0.0, 0.0, kCanvasSize, kCanvasSize), stroke);

//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     canvas.drawCircle(
//         Offset(
//           widget.rd.nextDouble() * kCanvasSize,
//           widget.rd.nextDouble() * kCanvasSize,
//         ),
//         20.0,
//         paint);

//     final picture = recorder.endRecording();
//     final img = await picture.toImage(200, 200);
//     final pngBytes = await img.toByteData(format: ImageByteFormat.png);

//     setState(() {
//       imgBytes = pngBytes;
//     });
//   }
// }
