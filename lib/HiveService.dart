import 'package:hive/hive.dart';

class Hiveservice {
  final box=Hive.box('myBox');
  Future<void> createData(String value) async {
    await box.add(value);
  }

  Future<List> read() async {
    return await box.values.toList();
  }


  Future<void> update(int index, String value) async {
    await box.putAt(index, value);
  }

  Future<void> delete(int index) async{
    await box.deleteAt(index);
  }

}
