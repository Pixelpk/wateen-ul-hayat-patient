import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:swift_care/constants/push_notifications.dart';
import '../../export.dart';

var log = Logger();
GetStorage storage = GetStorage();
TextTheme textTheme = Theme.of(Get.context!).textTheme;
var tempDir;

class GlobalVariable {
  static final GlobalKey<ScaffoldMessengerState> navState =
      GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  APIRepository();
  await Firebase.initializeApp();
  await PushNotificationsManager().init();
  initializeDateFormatting();
  await GetStorage.init();
  tempDir = await getTemporaryDirectory();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: COLOR_middleBlueM,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: GetMaterialApp(
                theme: themeData,
                darkTheme: darkThemeData,
                themeMode: ThemeMode.light,
                localizationsDelegates: [
                  CountryLocalizations.delegate,
                ],
                initialBinding: ReaderBinding(),
                scaffoldMessengerKey: GlobalVariable.navState,
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
                enableLog: true,
                textDirection: storage.read(LOCALKEY_english) == null ||
                        storage.read(LOCALKEY_english) == true
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                logWriterCallback: LoggerX.write,
                locale: TranslationService.locale,
                fallbackLocale: TranslationService.fallbackLocale,
                translations: TranslationService(),
                builder: EasyLoading.init(),
                defaultTransition: Transition.cupertino,
                // textDirection: TextDirection.ltr,
              ),
            ));
  }
}
