import 'package:virtual_waiter/model/menu_item.dart';

final List<MenuItem> kMenuItemList = [
  MenuItem(
    id: 1,
    name: 'Spring Rolls',
    category: 'Cold Dishes',
    imageUrl: 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
    price: 2500.0,
    tags: ['Vegan', 'Vegetarian'],
    description: 'Crispy and fresh spring rolls filled with a delightful mix of vegetables and spices, perfect for a light appetizer. Each bite delivers a satisfying crunch and a burst of flavor.',
    addOns: [
      {'id': 'b1', 'name': 'Extra Chicken', 'price': 3.00},
      {'id': 'b2', 'name': 'Side Salad', 'price': 2.50},
    ],
  ),
  MenuItem(
    id: 2,
    name: 'Spring Rolls',
    category: 'Appetizer',
    imageUrl: 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
    price: 2500.0,
    tags: ['Vegan', 'Vegetarian'],
    description: 'Golden-brown spring rolls with a crunchy exterior and a flavorful vegetable filling, ideal for starting your meal. Enjoy the perfect combination of taste and texture.',
    addOns: [
      {'id': 'b3', 'name': 'Dipping Sauce', 'price': 1.00},
      {'id': 'b4', 'name': 'Extra Vegetables', 'price': 2.00},
    ],
  ),
];
