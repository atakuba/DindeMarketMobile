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
  bool _isLoading = true; // Added a loading flag

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getToken(_secureStorage, ref);

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.read(tokenProvider.notifier).state;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == "" ? DistrictPage() : NavigationBarPage(),
    );
  }
}


Future<void> getToken(FlutterSecureStorage storage, WidgetRef ref) async {
  String? token = await storage.read(key: "auth_token");
  if (token == null) {
    ref.read(tokenProvider.notifier).state = "";
  } else {
    ref.read(tokenProvider.notifier).state = token;
  }
}
