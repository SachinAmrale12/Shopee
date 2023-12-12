import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopee/common/utils/analytics.dart';
import 'package:shopee/main.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class FirebaseNotifications {
  final firebaseMessaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'channel id 1', 'Test Notification',
      importance: Importance.high,
      playSound: true,
      showBadge: true,
      description: 'test description');

  final _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed('home');
    if (message.data['page'] == "productListing") {
      Analytics.logEvent('plpNotificationClicked', null);
      navigatorKey.currentState?.pushNamed('plp');
    } else if (message.data['page'] == "productDetails") {
      navigatorKey.currentState?.pushNamed('plp');
      String url = message.data['redirect'];
      int productId = int.parse((url.split('/').last).toString()) ?? 1;
      Analytics.logEvent('pdpNotificationClicked', {'productId': productId});
      navigatorKey.currentState?.pushNamed('pdp', arguments: productId);
    }
  }

  Future<void> _initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    firebaseMessaging.subscribeToTopic('iPhones');

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      final notification = event.notification;
      if (notification == null) return;
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                icon: '@drawable/notification_icon'),
          ),
          payload: jsonEncode(event.toMap()));
    });
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('notification_icon');
    const settings = InitializationSettings(android: android);
    await _localNotification.initialize(settings,
        onDidReceiveNotificationResponse: (response) {
      print(response.payload);
    });
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(channel);
  }

  Future<void> initNotification() async {
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });
    _initPushNotification();
    initLocalNotification();
  }
}
