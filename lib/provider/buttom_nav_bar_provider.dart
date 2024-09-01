import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavBarVisibilityProvider = StateProvider<bool>((ref) => true);
final selectedIndexProvider = StateProvider<int>((ref) => 0);

