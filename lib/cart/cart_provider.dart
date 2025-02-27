import 'package:flutter/foundation.dart';
import '../cart/cart_item.dart';
import '../items/menu_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(MenuItem menuItem, {List<String> selectedOptions = const []}) {
    final existingIndex = _items.indexWhere(
          (item) => item.menuItem.id == menuItem.id &&
          item.selectedOptions.toString() == selectedOptions.toString(),
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(
        CartItem(
          menuItem: menuItem,
          selectedOptions: selectedOptions,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String menuItemId, List<String> selectedOptions) {
    _items.removeWhere(
          (item) =>
      item.menuItem.id == menuItemId &&
          item.selectedOptions.toString() == selectedOptions.toString(),
    );
    notifyListeners();
  }

  void updateQuantity(String menuItemId, List<String> selectedOptions, int quantity) {
    final index = _items.indexWhere(
          (item) =>
      item.menuItem.id == menuItemId &&
          item.selectedOptions.toString() == selectedOptions.toString(),
    );

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}