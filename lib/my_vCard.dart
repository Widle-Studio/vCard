

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share/share.dart';
import 'package:image/image.dart' as img;

class MyVCard extends StatefulWidget {
  MyVCard({Key key, this.title,
  
    this.name,
    this.company_name,
    this.designation,
    this.email,
    this.mobile,
    this.website,
    this.image
  
  }) : super(key: key);
  String name;
  String company_name;
  String designation;
  String email;
  String mobile;
  String website;
  String image;
  final String title;

  @override
  _MyVCardState createState() => new _MyVCardState();
}

class _MyVCardState extends State<MyVCard> {
  ui.Image image;
  bool isImageloaded = false;
  bool isCanvasloaded = false;
  ByteData imgBytes;
  File savedFile;

  void initState() {
    super.initState();
    init();
  }

Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File file = new File.fromUri(myUri);
    Uint8List bytes;
    await file.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value); 
    print('reading of bytes is completed');
  }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
      onError.toString());
  });
  return bytes;
}


  Future <Null> init() async {
    Uint8List audioByte;
  String myPath= widget.image;
  audioByte = await _readFileByte(myPath);
    // final ByteData data = await File();
    image = await resizeImage(audioByte);
    generateImage(image, widget.name, widget.designation, widget.company_name, widget.email, widget.mobile, widget.website, widget.image);
  }

  // Future<ui.Image> loadImage(List<int> img) async {
  //   final Completer<ui.Image> completer = new Completer();
  //   ui.decodeImageFromList(img, (ui.Image img) {
  //     setState(() {
  //       isImageloaded = true;
  //     });
  //     return completer.complete(img);
  //   });
  //   return completer.future;
  // }

  Future<ui.Image> resizeImage( List<int> data ) async {

   final img.Image image = img.decodeImage(data);
   final img.Image resized = img.copyResize(image, width: 310, height: 310);
   final List<int> resizedBytes = img.encodePng(resized);
   final Completer<ui.Image> completer = new Completer();

   ui.decodeImageFromList(resizedBytes, (ui.Image img) => completer.complete(img));
   return completer.future;
}

  // Widget _buildImage() async {
  //   if (this.isImageloaded) {
  //     ImageEditor imageEditor = ImageEditor(image: image, name: widget.name, designation: widget.designation, company_name: widget.company_name, email: widget.email, mobile: widget.mobile, website: widget.website);
  //     File file = await imageEditor.paint();
  //     return Image.file(file);
        
  //   } else {
  //     return new Center(child: new Text('loading'));
  //   }
  // }

    void generateImage(ui.Image image,
  String name,
  String company_name,
  String designation,
  String email,
  String mobile,
  String website,
  String myPath) async {
double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset(0.0, 0.0), Offset(width, height)));

    // final stroke = Paint()
    //   ..color = Colors.grey
    //   ..style = PaintingStyle.stroke;

    

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;



  final textPainter_name = TextPainter(
    text: TextSpan(
    text: name,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
  ),
    textDirection: TextDirection.ltr,
  );

    final textPainter_designation = TextPainter(
    text: TextSpan(
    text: designation,
    style: TextStyle(
    color: Colors.black,
    fontSize: 35,
  ),
  ),
    textDirection: TextDirection.ltr,
  );

    final textPainter_companyname = TextPainter(
    text: TextSpan(
    text: company_name,
    style: TextStyle(
    color: Colors.black,
    fontSize: 40,
  ),
  ),
    textDirection: TextDirection.ltr,
  );

      final textPainter_email = TextPainter(
    text: TextSpan(
    text: email,
    style: TextStyle(
    color: Colors.black,
    fontSize: 30,
  ),
  ),
    textDirection: TextDirection.ltr,
  );

      final textPainter_mobile = TextPainter(
    text: TextSpan(
    text: mobile,
    style: TextStyle(
    color: Colors.black,
    fontSize: 30,
  ),
  ),
    textDirection: TextDirection.ltr,
  );

      final textPainter_website = TextPainter(
    text: TextSpan(
    text: website,
  
    style: TextStyle(
    
    color: Colors.black,
    
    fontSize: 30,
  ),
  ),
    textDirection: TextDirection.ltr,
  );
  textPainter_name.layout(
    minWidth: 0,
  );
    textPainter_designation.layout(
    minWidth: 0,
  );
    textPainter_companyname.layout(
    minWidth: 0,
  );
    textPainter_email.layout(
    minWidth: 0,
  );
    textPainter_mobile.layout(
    minWidth: 0,
  );
    textPainter_website.layout(
    minWidth: 0,
  );
  
  double offset_x = 350;
  final offset_name = Offset((350 - textPainter_name.width) * 0.5, offset_x);
  final offset_designation = Offset((350 - textPainter_designation.width) * 0.5, offset_x+60);
  final offset_companyname = Offset((350 - textPainter_companyname.width) * 0.5, offset_x+100);
  final offset_email = Offset((350 - textPainter_email.width) * 0.5, offset_x+150);
  final offset_mobile = Offset((350 - textPainter_mobile.width) * 0.5, offset_x+190);
  final offset_website = Offset((350 - textPainter_website.width) * 0.5, offset_x+220);
  
      final paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  
    // canvas.drawRect(Rect.fromPoints(Offset.zero, Offset(250, 410)), new Paint());
    print(image.height);
    print(image.width);
    canvas.drawRect(Offset(0, 0) & Size(1000, 1200), paint1);
    canvas.drawImage(image, new Offset(20.0, 20.0), paint);
    textPainter_name.paint(canvas, offset_name);
    textPainter_designation.paint(canvas, offset_designation);
    textPainter_companyname.paint(canvas, offset_companyname);
    textPainter_email.paint(canvas, offset_email);
    textPainter_mobile.paint(canvas, offset_mobile);
    textPainter_website.paint(canvas, offset_website);

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);

    setState(() {
      imgBytes = pngBytes;
      writeToFile(imgBytes, myPath);
    });


  }

 writeToFile(ByteData data, String myPath) async {

  
       var cacheDir = await getTemporaryDirectory();
  String filePath = path.join(cacheDir.path,
    '${path.basenameWithoutExtension(myPath)}.png');
  final buffer = data.buffer;
  File _savedFile = await File(filePath).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

  setState(() {
    savedFile = _savedFile;
  });
   Fluttertoast.showToast(
                        msg: "vCard saved to " + _savedFile.path,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
}

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff073b61),
        title: new Text("Your vCard"),
      ),
      body: new Container(
        
        child:           imgBytes != null
              ?  Center(
                  child: Container(
                  child: Image.memory(
                  Uint8List.view(imgBytes.buffer),
                   width: 500,
                  height: 600,
                )
                  
                  ,) )
              : Container()
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        backgroundColor:  Color(0xff073b61),
        onPressed: (){
          final RenderBox box = context.findRenderObject();
                 Share.shareFiles([savedFile.path],
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        },
      ),
    );
  }
}




// class ImageEditor {


//   ImageEditor({
//     this.image,
//     this.name,
//     this.company_name,
//     this.designation,
//     this.email,
//     this.mobile,
//     this.website
//   });

//   ui.Image image;
//   String name;
//   String company_name;
//   String designation;
//   String email;
//   String mobile;
//   String website;

//   Future<File> paint() async {
//         // ByteData data = image.toByteData();
//   final recorder = ui.PictureRecorder(); 
//   final canvas = Canvas(recorder);

//   final textPainter_name = TextPainter(
//     text: TextSpan(
//     text: this.name,
//     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
//   ),
//     textDirection: TextDirection.ltr,
//   );

//     final textPainter_designation = TextPainter(
//     text: TextSpan(
//     text: this.designation,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 25,
//   ),
//   ),
//     textDirection: TextDirection.ltr,
//   );

//     final textPainter_companyname = TextPainter(
//     text: TextSpan(
//     text: this.company_name,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 27,
//   ),
//   ),
//     textDirection: TextDirection.ltr,
//   );

//       final textPainter_email = TextPainter(
//     text: TextSpan(
//     text: this.email,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 23,
//   ),
//   ),
//     textDirection: TextDirection.ltr,
//   );

//       final textPainter_mobile = TextPainter(
//     text: TextSpan(
//     text: this.mobile,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 23,
//   ),
//   ),
//     textDirection: TextDirection.ltr,
//   );

//       final textPainter_website = TextPainter(
//     text: TextSpan(
//     text: this.website,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 23,
//   ),
//   ),
//     textDirection: TextDirection.ltr,
//   );
//   textPainter_name.layout(
//     minWidth: 0,
//     maxWidth: 200,
//   );
//     textPainter_designation.layout(
//     minWidth: 0,
//     maxWidth: 200,
//   );
//     textPainter_companyname.layout(
//     minWidth: 0,
//     maxWidth: 200,
//   );
//     textPainter_email.layout(
//     minWidth: 0,
//     maxWidth: 200,
//   );
//     textPainter_mobile.layout(
//     minWidth: 0,
//     maxWidth: 200,
//   );
//     textPainter_website.layout(
//     minWidth: 0,
//     maxWidth: 200,
//   );
  
//   double offset_x = 300;
//   final offset_name = Offset(100, offset_x);
//   final offset_designation = Offset(100, offset_x+40);
//   final offset_companyname = Offset(100, offset_x+70);
//   final offset_email = Offset(100, offset_x+100);
//   final offset_mobile = Offset(100, offset_x+130);
//   final offset_website = Offset(100, offset_x+160);
  
  
  

//     canvas.drawImage(image, new Offset(70.0, 30.0), new Paint());
//     textPainter_name.paint(canvas, offset_name);
//     textPainter_designation.paint(canvas, offset_designation);
//     textPainter_companyname.paint(canvas, offset_companyname);
//     textPainter_email.paint(canvas, offset_email);
//     textPainter_mobile.paint(canvas, offset_mobile);
//     textPainter_website.paint(canvas, offset_website);
    
//     final picture = recorder.endRecording();
//     final img = await picture.toImage(200, 200);
//     final pngBytes = await img.toByteData(format: ImageByteFormat.png);

//   final buffer = pngBytes.buffer;

//       var cacheDir = await getTemporaryDirectory();
//     String filePath = path.join(cacheDir.path,
//             'vCard.jpg');

//     File savedFile = await new File(filePath).writeAsBytes(
//       buffer.asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes));

//    return savedFile;
//   }

//   // @override
//   // Future<void> paint(Canvas _canvas, Size size) async {

//   // }

//   // @override
//   // bool shouldRepaint(CustomPainter oldDelegate) {
//   //   return false;
//   // }

// }
