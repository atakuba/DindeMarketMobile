import 'package:dinde_market/models/district.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final districtProvider = StateProvider<List<District>>((ref) => []);

void addDistricts(WidgetRef ref, List<District> newDistricts) {
  final currentDistricts = ref.read(districtProvider.notifier).state;
  ref.read(districtProvider.notifier).state = [...currentDistricts, ...newDistricts];
}
int getDistrictById(WidgetRef ref, int id) {
  final districts = ref.read(districtProvider.notifier).state; // Read the current state of districts
  return districts.firstWhere((district) => district.id == id).id;
}
