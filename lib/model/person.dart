import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Person extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int age;
}
