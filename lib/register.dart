
import 'dart:io';

import 'package:cv_app/home.dart';
import 'package:cv_app/user_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Register extends StatefulWidget {
Register(this.edit);

final bool edit;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with SingleTickerProviderStateMixin{

bool signinstatus = true;
final TextEditingController nameController = new TextEditingController();
final TextEditingController designationController = new TextEditingController();
final TextEditingController companNameController = new TextEditingController();
final TextEditingController vCardController = new TextEditingController();
final TextEditingController emailController = new TextEditingController();
final TextEditingController mobileController = new TextEditingController();
final TextEditingController websiteController = new TextEditingController();
final TextEditingController photoController = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
String vCardValue = '';

//  Future<img.Image> pickFile(ImageSource source) async {
//     final pickedFile = await _picker.getImage(source: source);
//     File imageFile = File(pickedFile.path);
//     img.Image image = img.decodeImage(imageFile.readAsBytesSync());
//     img.Image thumbnail = img.copyResize(image, width: 120);
//     return thumbnail;
//   }
  Map<String, String> userData = {};

getData() async {
  if(widget.edit == true){
    Map value = await UserDatabaseManager.getData();
    setState(() {
       nameController.text = value['name'];
 designationController.text = value['designation'];
 companNameController.text = value['company_name'];
 vCardController.text = value['vcardname'];
 emailController.text = value['email'];
 mobileController.text = value['mobile'];
 websiteController.text = value['website'];
 photoController.text = value['photo'];
 vCardValue = vCardController.text;
    });
  }
    
  }
  getPhoto(ImageSource imageSource) async {
        final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    File imageFile = File(pickedFile.path);

File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 310, ratioY: 310),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );
    img.Image image = img.decodeImage(croppedFile.readAsBytesSync());
    img.Image thumbnail = img.copyResize(image, width: 400);


    var cacheDir = await getTemporaryDirectory();
    String filePath = path.join(cacheDir.path,
            '${path.basenameWithoutExtension(croppedFile.path)}.jpg');
        
        File resizedImageFile =
            await File(filePath).writeAsBytes(img.encodeJpg(thumbnail));
    setState(() {
      photoController.text = resizedImageFile.path;
    });
  }
  

@override
  void initState() {
   getData();
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff073b61),
      title: Text("Register for vCard"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: 
          ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              shrinkWrap: true,
              children: <Widget>[
    
        Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.words,
                                        controller: nameController,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          vCardController.text = value.toLowerCase().trim().replaceAll(" ", "");
                                          setState(() {
                                            vCardValue = vCardController.text;
                                          });
                                        },
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "Your Name", // and add this line
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),

                                SizedBox(height: 15),

                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.words,
                                        controller: designationController,
                                        textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "Designation", // and add this line
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),

                                SizedBox(height: 15),

                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.words,
                                        controller: companNameController,
                                        textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "Company Name", // and add this line
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),

                                SizedBox(height: 15),
Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                     getPhoto(ImageSource.gallery);
                                    },
                                    child: Container(
                                      // height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                          // color: const Color(0xFFFDC5C2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: IgnorePointer(
                                            child: TextField(
                                              controller: photoController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Upload Permit Picture",
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.blueGrey[400]),
                                                ),
                                                labelStyle: new TextStyle(
                                                  color: Colors.blueGrey[400],
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),

SizedBox(height: 15),
                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.words,
                                        controller: vCardController,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          setState(() {
                                            vCardValue = value;
                                          });
                                        },
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "vCard Name", // and add this line
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),

SizedBox(height: 15),
                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text("Your vCard url: "),
                          Text(vCardValue + ".widlestudio.com", style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      )

                    
                    ),
                  ],
                ),
                



                 SizedBox(height: 15),

                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        textCapitalization: TextCapitalization.words,
                                        controller: emailController,
                                        textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "Email",
     hintText: "example@email.com"
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),

                 SizedBox(height: 15),

                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.phone,
                                        textCapitalization: TextCapitalization.words,
                                        controller: mobileController,
                                        textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "Mobile Number",
     hintText: "+911111111111"
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),

                 SizedBox(height: 15),

                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.all(5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Container(
                              // height: 30,
                              child: TextField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.words,
                                        controller: websiteController,
                                        textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical:5), //Change this value to custom as you like
    isDense: true,
     labelText: "Website", 
     hintText: "www.example.com"// and add this line
   ),

                                        //controller: email,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                            )
                          ]),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xff073b61))),
                      // height: 50,
                    ),
                  ],
                ),
                   SizedBox(height: 15),




  
                 SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  RaisedButton(
        onPressed: () async {
    //     if(nameController.text.isEmpty || designationController.text.isEmpty || companNameController.text.isEmpty || photoController.text.isEmpty || vCardController.text.isEmpty || emailController.text.isEmpty || mobileController.text.isEmpty || websiteController.text.isEmpty){
    //       Fluttertoast.showToast(
    //     msg: "Please fill all fields.",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.grey,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
    //     }else{
      await  UserDatabaseManager.setData(nameController.text, designationController.text, companNameController.text, photoController.text, vCardValue, emailController.text, mobileController.text, websiteController.text);
         
      await UserDatabaseManager.setSigninStatus(true);
                   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
  );

        // }
        },
        padding: EdgeInsets.symmetric(horizontal: 66, vertical: 14),
        color: Color(0xff073b61),
        
        shape: StadiumBorder(),
        child: Text("Generate vCard",style: TextStyle(color:Colors.white ),),
      ),
                ],)

                    
              ],
            ),
            
        
      )
            
    );
}
}
