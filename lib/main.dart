import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_web_view/pages/web_view_page.dart';

import 'pages/on_boarding_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var hasSeenOnboarding = prefs.getBool("hasSeenOnboarding") ?? false;
  // var hasSeenOnboarding = false;
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: hasSeenOnboarding ? const WebViewPage() : const OnBoardingPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
