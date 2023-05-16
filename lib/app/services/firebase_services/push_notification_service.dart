import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_factores_flutter_web/app/widgets/custom_snackbars.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late final String? token;
  static final StreamController<dynamic> _messageStream =
      StreamController.broadcast();
  static Stream<dynamic> get dataNotification => _messageStream.stream;

  // Use service account credentials to obtain oauth credentials.
  Future<String?> getAccessToken() async {
    final List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging'
    ];
    final accountCredentials = ServiceAccountCredentials.fromJson({
      'https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mf2yx%40lizit-production-a28ef.iam.gserviceaccount.com'
    });
    final client = http.Client();
    final AccessCredentials credentials =
        await obtainAccessCredentialsViaServiceAccount(
            accountCredentials, scopes, client);

    client.close();
    return credentials.accessToken.data;
  }

  static initNotifications() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Este es el token $token');

    final box = GetStorage();
    box.write('pushToken', token);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onLaunch);
    FirebaseMessaging.onBackgroundMessage(onResume);
  }

  static Future<dynamic> onMessage(RemoteMessage message) async {
    debugPrint('======== ON Message ==========');
    debugPrint('Title: ${message.notification!.title}');
    debugPrint('Body: ${message.notification!.body}');
    CustomSnackBars.showNotificationSnackBar('Tienes una nueva notificación');
    final Map<String, dynamic> dataNotification = message.data;
    dataNotification.addAll({'isLocal': true});
    _messageStream.add(dataNotification);
  }

  static Future<dynamic> onLaunch(RemoteMessage message) async {
    debugPrint('======== ON Launch ==========');
    debugPrint('Title: ${message.notification!.title}');
    debugPrint('Body: ${message.notification!.body}');
    final dataNotification = message.data;
    dataNotification.addAll({'isLocal': false});
    _messageStream.add(dataNotification);
  }

  static Future<dynamic> onResume(RemoteMessage message) async {
    debugPrint('======== ON Resume ==========');
    debugPrint('Title: ${message.notification!.title}');
    debugPrint('Body: ${message.notification!.body}');
    final dataNotification = message.data;
    dataNotification.addAll({'isLocal': false});
    _messageStream.add(dataNotification);
  }

  static closeStream() {
    _messageStream.close();
  }

  /// Enviar notificaciones a un número limitado de usuarios (1-5 usuarios)
  Future<Map<String, dynamic>?> sendNotificationToToken1(
      String tokens, String title, String body) async {
    final accesstoken = await getAccessToken();
    print(accesstoken);
    final response = await http
        .post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/lizit-production-a28ef/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'message': {
            'token': tokens,
            'notification': <String, dynamic>{'body': body, 'title': title}
          }
        },
      ),
    )
        .catchError(
      (e) {
        debugPrint('ERROR AL POST NOTIF: $e');
      },
    );

    debugPrint('RESPONSE: ${response.body}');
    return null;
  }

  /// Enviar notificaciones a un usuario
  Future<Map<String, dynamic>?> sendNotificationToToken(
      String token, String title, String body) async {
    final response = await http
        .post(
      Uri.parse(
          'fcm.googleapis.com/v1/projects/lizit-production/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $getAccessToken()',
      },
      body: jsonEncode(
        <String, dynamic>{
          'to': token,
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'sound': 'default',
            'badge': 1,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
          },
        },
      ),
    )
        .catchError((e) {
      debugPrint('ERROR AL POST NOTIF: $e');
    });

    debugPrint('RESPONSE: ${response.body}');
    return null;
  }

  /// Enviar notificaciones a n usuarios que estén suscritos al topic
  Future<Map<String, dynamic>?> sendNotificationToTopic(
      String topic, String title, String body) async {
    final response = await http
        .post(
      Uri.parse(
          'fcm.googleapis.com/v1/projects/lizit-production/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $getAccessToken()',
      },
      body: jsonEncode(
        <String, dynamic>{
          'to': '/topics/$topic',
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'sound': 'default',
            'badge': 1,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
          },
        },
      ),
    )
        .catchError((e) {
      debugPrint('ERROR AL POST NOTIF: $e');
    });

    debugPrint('RESPONSE: ${response.body}');
    return null;
  }
}

PushNotificationService pushNotificationService = PushNotificationService();
