import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopperz/app/localization/language.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/config/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopperz/data/helper/notification_helper.dart';
import 'package:shopperz/data/model/body/notification_body.dart';
import 'package:shopperz/firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final box = GetStorage();

dynamic langValue = const Locale('en', null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await WishlistController().fetchFavorite();
  if (box.read('languageCode') != null) {
    langValue = Locale(box.read('languageCode'), null);
  } else {
    langValue = const Locale('en', 'EN');
  }

  // ignore: unused_local_variable
  NotificationBody? body;
  try {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      body = NotificationHelper.convertNotification(remoteMessage.data);
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: ((context, child) => GetMaterialApp(
            title: 'ShopKing',
            debugShowCheckedModeBanner: false,
            translations: Languages(),
            locale: langValue,
            theme: ThemeData(useMaterial3: false),
            initialRoute: AppPages.initial,
            getPages: AppPages.pages,
          )),
    );
  }
}
