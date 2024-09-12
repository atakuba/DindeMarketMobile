import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final secureStorage = const FlutterSecureStorage();
    
    return Consumer(
      builder: (context, ref, child) {
        // getToken(secureStorage, ref);
        // final token = ref.watch(tokenProvider.notifier);
        // print("******************************");
        // print(token);
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: token != "" ? NavigationBarPage() : Container(color: Colors.pink,)
      home: NavigationBarPage()
    );
      },
    );
  }
}
Future<void> getToken(FlutterSecureStorage storage, WidgetRef ref, ) async {
  String? token = await storage.read(key: "auth_token");
  if(token == null) {
  ref.read(tokenProvider.notifier).state = "";
  }else {
    ref.read(tokenProvider.notifier).state = token;
  }
}