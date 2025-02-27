import 'package:flutter/material.dart';
import '../items/restaurant.dart';
import '../screens/restaurant_detail_screen.dart';
import '../cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Restaurant> allRestaurants = [
    Restaurant(
      id: '1',
      name: 'Burger King',
      imageUrl: 'assets/images/burger.jpg',
      category: 'Burger',
      rating: 4.5,
      deliveryTime: '30-40 dk',
      minOrder: '50 TL',
      cuisines: ['Burger', 'Fast Food', 'İçecekler'],
      deliveryFee: 0.0,
      hasDiscount: true,
    ),
    Restaurant(
      id: '2',
      name: 'Dominos Pizza',
      imageUrl: 'assets/images/pizza.jpg',
      category: 'Pizza',
      rating: 4.3,
      deliveryTime: '40-50 dk',
      minOrder: '75 TL',
      cuisines: ['Pizza', 'İtalyan', 'İçecekler'],
      deliveryFee: 5.0,
      hasDiscount: true,
    ),
    Restaurant(
      id: '3',
      name: 'Köfteci Yusuf',
      imageUrl: 'assets/images/kofte.jpg',
      category: 'Kebap',
      rating: 4.7,
      deliveryTime: '25-35 dk',
      minOrder: '100 TL',
      cuisines: ['Köfte', 'Türk Mutfağı', 'Izgara'],
      deliveryFee: 7.5,
      hasDiscount: false,
    ),
    Restaurant(
      id: '4',
      name: 'Starbucks',
      imageUrl: 'assets/images/coffee.jpg',
      category: 'Kahve',
      rating: 4.4,
      deliveryTime: '15-25 dk',
      minOrder: '40 TL',
      cuisines: ['Kahve', 'Tatlı', 'Sandviç'],
      deliveryFee: 0.0,
      hasDiscount: true,
    ),
  ];

  List<Restaurant> displayedRestaurants = [];
  final TextEditingController _searchController = TextEditingController();
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    displayedRestaurants = allRestaurants;
  }

  void _filterRestaurants(String query) {
    setState(() {
      displayedRestaurants = allRestaurants.where((restaurant) {
        final matchesSearch = restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
            restaurant.category.toLowerCase().contains(query.toLowerCase()) ||
            restaurant.cuisines.any((cuisine) =>
                cuisine.toLowerCase().contains(query.toLowerCase()));

        final matchesCategory = selectedCategory == null ||
            restaurant.category == selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      if (selectedCategory == category) {
        selectedCategory = null;
      } else {
        selectedCategory = category;
      }
      _filterRestaurants(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yemeksepeti',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterRestaurants,
              decoration: InputDecoration(
                hintText: 'Restoran veya yemek ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryItem(Icons.local_pizza, 'Pizza', 'Pizza'),
                _buildCategoryItem(Icons.lunch_dining, 'Burger', 'Burger'),
                _buildCategoryItem(Icons.kebab_dining, 'Kebap', 'Kebap'),
                _buildCategoryItem(Icons.coffee, 'Kahve', 'Kahve'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = displayedRestaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailScreen(restaurant: restaurant),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image: AssetImage(restaurant.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      restaurant.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${restaurant.rating}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                restaurant.cuisines.join(' • '),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    restaurant.deliveryTime,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(Icons.shopping_bag,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Min. ${restaurant.minOrder}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              if (restaurant.deliveryFee > 0) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Servis Ücreti: ${restaurant.deliveryFee} TL',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                              if (restaurant.hasDiscount) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.local_offer,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'İndirimli Ürünler',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, String categoryValue) {
    final isSelected = selectedCategory == categoryValue;
    return GestureDetector(
      onTap: () => _filterByCategory(categoryValue),
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.red : Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}