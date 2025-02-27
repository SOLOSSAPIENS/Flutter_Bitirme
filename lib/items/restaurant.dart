class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final double rating;
  final String deliveryTime;
  final String minOrder;
  final bool isOpen;
  final List<String> cuisines;
  final double deliveryFee;
  final bool hasDiscount;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.minOrder,
    this.isOpen = true,
    this.cuisines = const [],
    this.deliveryFee = 0.0,
    this.hasDiscount = false,
  });
}