import '../items/menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  int quantity;
  final List<String> selectedOptions;

  CartItem({
    required this.menuItem,
    this.quantity = 1,
    this.selectedOptions = const [],
  });

  double get totalPrice => menuItem.price * quantity;
}