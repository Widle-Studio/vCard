import 'dart:async';

import 'package:hive/hive.dart';

class UserDatabaseManager {
  static String NAME = "name";
  static String DESIGNATION = "designation";
  static String COMPANY_NAME = "company_name";
  static String PHOTO = "photo";
  static String VCARDNAME = "vcardname";
  static String EMAIL = "email";
  static String MOBILE = "mobile";
  static String WEBSITE = "website";

  static String SIGNINSTATUS = "signinstatus";
  


  static Future<Box> _userSettingsBox = Hive.openBox('userDatabase');

  static setData(String name, String designation, String company_name, String photo, String vcardname, String email, String mobile, String website) async {
    Box userSettings = await _userSettingsBox;
    userSettings.put(NAME, name);
    userSettings.put(DESIGNATION, designation);
    userSettings.put(COMPANY_NAME, company_name);
    userSettings.put(PHOTO, photo);
    userSettings.put(VCARDNAME, vcardname);
    userSettings.put(EMAIL, email);
    userSettings.put(MOBILE, mobile);
    userSettings.put(WEBSITE, website);
  }

  static Future<Map<String,String>> getData() async {
    Box userSettings = await _userSettingsBox;

    Map<String,String> toReturn = {};

    toReturn['name'] = userSettings.get(NAME);
    toReturn['designation'] = userSettings.get(DESIGNATION);
    toReturn['company_name'] = userSettings.get(COMPANY_NAME);
    toReturn['photo'] = userSettings.get(PHOTO);
    toReturn['vcardname'] = userSettings.get(VCARDNAME);
    toReturn['email'] = userSettings.get(EMAIL);
    toReturn['mobile'] = userSettings.get(MOBILE);
    toReturn['website'] = userSettings.get(WEBSITE);


    return toReturn;
  }

    static setSigninStatus(bool status) async {
    Box userSettings = await _userSettingsBox;
    userSettings.put(SIGNINSTATUS, status);
  }

  static Future<bool> getSigninStatus() async {
    Box userSettings = await _userSettingsBox;
    return userSettings.get(SIGNINSTATUS) ?? false;
  }
}