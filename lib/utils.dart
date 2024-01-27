import 'dart:io';

class Utils{
  static String get databasePath {
    if(Platform.isWindows){
      final Directory directory= Directory("C:\\DashDatabase");
      directory.create();
      return "C:\\DashDatabase\\";
    }
    return '';
  }

}