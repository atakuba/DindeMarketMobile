
import 'package:dinde_market/config/database_configuration.dart';
import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/pages/opening_pages/district_page.dart';
import 'package:dinde_market/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // clearDatabase();
      // _secureStorage.delete(key: 'auth_token');
      await getToken(_secureStorage, ref);
      setState(() {});
    });
  }

  void clearDatabase() async {
    await DatabaseHelper.instance.resetDatabase();
  }

  Future<void> getToken(FlutterSecureStorage storage, WidgetRef ref) async {
    String? token = await storage.read(key: "auth_token");
    if (token != null) {
      ref.read(tokenProvider.notifier).state = token;
    } else {
      ref.read(tokenProvider.notifier).state = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.read(tokenProvider.notifier).state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == "" ? const DistrictPage() : const NavigationBarPage(),
    );
  }
}
