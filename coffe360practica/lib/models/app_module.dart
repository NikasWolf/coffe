enum AppModuleType {
  blog,
  catalog,
  cart,
}

extension AppModuleExtension on AppModuleType {
  String get title {
    switch (this) {
      case AppModuleType.blog: return 'Блог';
      case AppModuleType.catalog: return 'Каталог';
      case AppModuleType.cart: return 'Корзина';
    }
  }
}