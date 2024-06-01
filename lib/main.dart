import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';


import 'application.dart';
import 'locator.dart';

void main() async {
  await Hive.initFlutter();

  setup();

  runApp(const Application());
}

