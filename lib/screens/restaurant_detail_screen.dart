import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../items/restaurant.dart';
import '../items/menu_item.dart';
import '../cart/cart_provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurant,
  });

  List<MenuItem> _getMenuItems() {
    switch (restaurant.name) {
      case 'Burger King':
        return [
          MenuItem(
            id: 'bk1',
            name: 'Whopper Menü',
            description: 'Whopper® eti, büyük boy patates ve içecek',
            price: 150.0,
            imageUrl: 'assets/images/whopper.jpg',
            options: ['Ketçap', 'Mayonez', 'Büyük Boy'],
          ),
          MenuItem(
            id: 'bk2',
            name: 'Big King Menü',
            description: 'Big King® eti, orta boy patates ve içecek',
            price: 140.0,
            imageUrl: 'assets/images/bigking.jpg',
            options: ['Ketçap', 'Mayonez', 'Orta Boy'],
          ),
          MenuItem(
            id: 'bk3',
            name: 'Chicken Royale Menü',
            description: 'Tavuk fileto, patates ve içecek',
            price: 130.0,
            imageUrl: 'assets/images/chicken.jpg',
            options: ['Ketçap', 'Mayonez', 'Orta Boy'],
          ),
        ];

      case 'Dominos Pizza':
        return [
          MenuItem(
            id: 'dp1',
            name: 'Karışık Pizza',
            description: 'Sucuk, sosis, mantar, yeşil biber, mısır',
            price: 160.0,
            imageUrl: 'assets/images/karisik.jpg',
            options: ['İnce Hamur', 'Normal Hamur', 'Kalın Hamur'],
          ),
          MenuItem(
            id: 'dp2',
            name: 'Margarita',
            description: 'Mozarella peyniri, domates sosu, fesleğen',
            price: 120.0,
            imageUrl: 'assets/images/margarita.jpg',
            options: ['İnce Hamur', 'Normal Hamur', 'Kalın Hamur'],
          ),
          MenuItem(
            id: 'dp3',
            name: 'Tavuklu Pizza',
            description: 'Izgara tavuk, mantar, mısır',
            price: 140.0,
            imageUrl: 'assets/images/tavuklu.jpg',
            options: ['İnce Hamur', 'Normal Hamur', 'Kalın Hamur'],
          ),
        ];

      case 'Köfteci Yusuf':
        return [
          MenuItem(
            id: 'ky1',
            name: 'İnegöl Köfte Porsiyon',
            description: '8 adet köfte, pilav, salata',
            price: 120.0,
            imageUrl: 'assets/images/kofte_porsiyon.jpg',
            options: ['Az Pişmiş', 'Orta Pişmiş', 'Çok Pişmiş'],
          ),
          MenuItem(
            id: 'ky2',
            name: 'Karışık Izgara',
            description: 'Köfte, pirzola, tavuk şiş',
            price: 180.0,
            imageUrl: 'assets/images/karisik_izgara.jpg',
            options: ['Az Pişmiş', 'Orta Pişmiş', 'Çok Pişmiş'],
          ),
          MenuItem(
            id: 'ky3',
            name: 'Pide Menü',
            description: 'Kıymalı pide, ayran',
            price: 90.0,
            imageUrl: 'assets/images/pide.jpg',
            options: ['Acılı', 'Acısız'],
          ),
        ];

      case 'Starbucks':
        return [
          MenuItem(
            id: 'sb1',
            name: 'Latte',
            description: 'Espresso ve buharla ısıtılmış süt',
            price: 45.0,
            imageUrl: 'assets/images/latte.jpg',
            options: ['Tall', 'Grande', 'Venti'],
          ),
          MenuItem(
            id: 'sb2',
            name: 'Caramel Frappuccino',
            description: 'Karamel şurubu ile kahve ve süt karışımı',
            price: 55.0,
            imageUrl: 'assets/images/frappuccino.jpg',
            options: ['Tall', 'Grande', 'Venti'],
          ),
          MenuItem(
            id: 'sb3',
            name: 'Turkey & Cheese Tost',
            description: 'Hindi füme ve peynirli tost',
            price: 75.0,
            imageUrl: 'assets/images/tost.jpg',
            options: [],
          ),
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = _getMenuItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              restaurant.category,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text('${restaurant.rating}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Min. ${restaurant.minOrder}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(restaurant.deliveryTime),
                    const SizedBox(height: 4),
                    if (restaurant.deliveryFee > 0)
                      Text('Servis: ${restaurant.deliveryFee} TL'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: AssetImage(menuItem.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menuItem.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                menuItem.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${menuItem.price} TL',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (menuItem.options.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Seçenekler: ${menuItem.options.join(", ")}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addItem(menuItem);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${menuItem.name} sepete eklendi'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Sepete Ekle',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}