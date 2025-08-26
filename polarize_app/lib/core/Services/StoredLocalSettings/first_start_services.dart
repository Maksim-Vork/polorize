import 'package:shared_preferences/shared_preferences.dart';

class FirstStartServices {
  final SharedPreferences prefs;

  FirstStartServices({required this.prefs});

  Future<bool> isFirstStart() async {
    final bool isFirstStart = prefs.getBool('isFirstStart') ?? true;
    if (isFirstStart) {
      await prefs.setBool('isFirstStart', false);
    }
    return isFirstStart;
  }
}
