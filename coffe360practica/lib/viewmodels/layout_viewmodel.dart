import 'package:flutter/foundation.dart';
import '../models/app_module.dart';

class LayoutViewModel extends ChangeNotifier {
  final List<AppModuleType> _activeModules = [
    AppModuleType.blog,
    AppModuleType.catalog,
    AppModuleType.cart,
  ];

  List<AppModuleType> get activeModules => _activeModules;

  bool isModuleActive(AppModuleType type) => _activeModules.contains(type);

  void toggleModule(AppModuleType type) {
    if (_activeModules.contains(type)) {
      _activeModules.remove(type);
    } else {
      _activeModules.add(type);
    }
    notifyListeners();
  }

  void reorderModules(int oldIndex, int newIndex) {
    // Безопасная вставка: индекс не может выходить за пределы длины списка
    final item = _activeModules.removeAt(oldIndex);
    final safeIndex = newIndex.clamp(0, _activeModules.length);
    _activeModules.insert(safeIndex, item);
    notifyListeners();
  }
}