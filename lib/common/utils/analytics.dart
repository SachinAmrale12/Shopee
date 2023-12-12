import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  static void logEvent(String eventName, Map<String, dynamic>? parameter) {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameter,
    );
  }
}
