import 'package:dento_support/core/configs/enviornment.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/app/app.dart';
import 'package:dento_support/firebase_options.dart';
import 'package:dento_support/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

String version = '';
String buildNumber = '';

String get versionName => '$version($buildNumber)';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Enviorment enviorment = LiveEnviormentImpl();

  /// Setup DI
  await initializeDependencies(enviorment);

  /// Setup Firebase
  await initializeFirebase();

  /// Get Application information
  final packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;

  runApp(const DentoSupportApp());
}

/// Initialize [Firebase]
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Setup Firebase Messaging
  await initializeFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  /// Pass all uncaught asynchronous errors that aren't handled by
  /// the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      fatal: true,
    );
    return true;
  };
}

/// Access the registration token
Future<void> initializeFirebaseMessaging() async {
  final messaging = FirebaseMessaging.instance;

  // Request permission to receive messages
  final settings = await messaging.requestPermission();
  debugPrint('User granted permission: ${settings.authorizationStatus}');

  final fcmToken = await FirebaseMessaging.instance.getToken();
  getIt<LocalStorageService>().fcmToken = fcmToken ?? '';

  messaging.onTokenRefresh.listen((fcmToken) {
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
    getIt<LocalStorageService>().fcmToken = fcmToken;
  }).onError((err) {
    // Error getting token.
  });

  /// Message handling
  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
        'Message also contained a notification: ${message.notification}',
      );
    }
  });
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ignore: lines_longer_than_80_chars
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint('Handling a background message: ${message.messageId}');
}
