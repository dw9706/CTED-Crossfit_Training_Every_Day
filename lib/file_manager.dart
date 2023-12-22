import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static FileManager _instance = FileManager._internal();

  FileManager._internal() {}

  factory FileManager() => _instance;

  get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    print(directory.path.runtimeType);
    return directory.path;
  }

  get _file async {
    final path = await _directoryPath;
    return File('$path/programContent.txt');
  }

  readTextFile() async {
    String fileContent = 'nothing';

    File file = await _file;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }

    return fileContent;
  }

  writeTextFile(String content) async {
    File file = await _file;

    await file.writeAsString(content);
    return content;
  }
}
