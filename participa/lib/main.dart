import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:participa/core/theme/theme.dart';
import 'package:participa/core/theme/app_theme_notifier.dart';
import 'package:participa/presentation/pages/forgotPassword/forgotpassword_page.dart';
import 'package:participa/presentation/pages/home/home_page.dart';
import 'package:participa/presentation/pages/login/login_page.dart';
import 'package:participa/presentation/pages/news/news_page.dart';
import 'package:participa/presentation/pages/oneTimePassword/otp_page.dart';
import 'package:participa/presentation/pages/register/register_page.dart';
import 'package:participa/presentation/pages/resetPassword/resetpassword_page.dart';
import 'package:participa/presentation/pages/pauta/pauta_page.dart';
import 'package:participa/presentation/pages/start_page.dart';
import 'package:participa/presentation/pages/transmission/transmission_page.dart';
import 'package:participa/presentation/pages/voting/voting_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const ParticipaApp());
}

class ParticipaApp extends StatelessWidget {
  const ParticipaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Participa',
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const StartPage(),
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/forgotpassword': (context) => ForgotpasswordPage(),
            '/otp': (context) => OtpPage(),
            '/reset': (context) => ResetPassword(),
            '/home': (context) => HomePage(),
            '/voting': (context) => VotingPage(),
            '/news': (context) => NewsPage(),
            '/transmission': (context) => TransmissionPage(),
            '/pauta': (context) => PautaPage(),
          },
        );
      },
    );
  }
}
