
import 'package:flutter_riverpod/flutter_riverpod.dart';

final districtProvider = StateProvider<List<String>>((ref) => ['г. Бишкек', 'г. Ош', 'Баткенская область', 'Джалал-Абадская область', 'Иссык-Кульская область', 'Нарынская область', 'Ошская область', 'Таласская область', 'Чуйская область']);