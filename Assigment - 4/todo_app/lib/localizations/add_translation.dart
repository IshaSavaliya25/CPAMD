import 'package:get/get.dart';
import 'package:todo_app/localizations/languages/ur.dart';
import 'package:todo_app/localizations/languages/en.dart';
import 'package:todo_app/localizations/languages/mr.dart';
import 'package:todo_app/localizations/languages/gu.dart';
import 'package:todo_app/localizations/languages/hi.dart';

class AddTraslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'hi': hi,
    'gu': gu,
    'ur': ur,
    'mr': mr,
  };
}
