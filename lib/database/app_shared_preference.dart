import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  /// Define key prefs
  static const String _firstAttempt = 'firstAttempt';
  static const String _highScore = 'highScore';

  /// Event
  /// First Attempt
  static Future<bool> saveFirstAttempt(bool isFirstAttempt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_firstAttempt, isFirstAttempt);
  }

  static Future<bool?> getFirstAttempt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstAttempt = prefs.getBool(_firstAttempt);
    if (isFirstAttempt != null) {
      return isFirstAttempt;
    }
    return null;
  }

  static Future<bool?> removeFirstAttempt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_firstAttempt);
  }

  /// 2048 High Score
  static Future<bool> saveHighScore(int highScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_highScore, highScore);
  }

  static Future<int?> getHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var highScore = prefs.getInt(_highScore);
    if (highScore != null) {
      return highScore;
    }
    return null;
  }

  static Future<bool?> removeHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_highScore);
  }
}
