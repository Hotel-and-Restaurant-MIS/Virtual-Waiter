class MenuItem {
  final int id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  final List<String> tags;
  List<Map<String, dynamic>> addOns;

  MenuItem({
    required this.description,
    required this.tags,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.addOns,
  });

  // Factory constructor to create an instance of MenuItem from a map
  factory MenuItem.fromMap(Map<String, dynamic> map) {
    List<String> tagNames = (map['tags'] as List)
        .map((tag) => tag['tagName'] as String)
        .toList();

    return MenuItem(
      id: map['menuItemId'],
      name: map['menuItemName'],
      price: map['menuItemPrice'],
      category: map['category']['categoryName'],
      imageUrl: map['imageUrl'] ?? 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
      tags: tagNames,
      description: map['description'],
      addOns: List<Map<String, dynamic>>.from(map['addOns'] ?? []),
    );
  }

  // Method to convert an instance of MenuItem to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'tags':tags,
      'description':description,
      'addOns':addOns,
    };
  }
}
