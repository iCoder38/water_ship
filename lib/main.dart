import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'classes/splash/splash.dart';
import 'firebase_options.dart';

RemoteMessage? initialMessage;
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  
  await Firebase.initializeApp(
    name: "Ship",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  ,
  // NOTIFICATION PERMISSION
  // show notification alert ( banner )
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (kDebugMode) {
    print('User granted permission =====> ${settings.authorizationStatus}');
  }
  //
  // background access
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // foreground access
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //
  /*// FETCH TOKEN
  final token = await _firebaseMessaging.getToken();

  //
  if (kDebugMode) {
    print('=============> HERE IS MY DEVICE TOKEN <=============');
    print('======================================================');
    print(token);
    print('======================================================');
    print('======================================================');
  }

  // save token locally
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('deviceToken', token.toString());
  //
  */
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      /*routes: {
        'push_to_page_control': (context) => const PageControlScreen(),
        'push_get_started_now': (context) => const GetStartedScreen(),
        'push_to_login_screen': (context) => const LoginScreen(),
        'push_to_sign_up_screen': (context) => const SignUpScreen(),
        'push_to_home_screen': (context) => const HomeScreen(),
        'push_to_profile_screen': (context) => const MyProfileScreen(
              strUserId: '',
            ),
        'push_to_menu_screen': (context) => const MenuScreen(),
        'push_to_search_friend_screen': (context) =>
            const SearchFriendsScreen(),
        'push_to_settings_screen': (context) => const SettingScreen(),
        'push_to_general_setting_screen': (context) =>
            const GeneralSettingsScreen(),
        'push_to_unblock_friends_setting_screen': (context) =>
            const UnblockFriendsScreen(),
        'push_to_forgot_password_screen': (context) =>
            const ForgotPasswordScreen(),
        'push_to_create_group_screen': (context) => const CreateGroupScreen(),
      },*/
    ),
  );
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}
