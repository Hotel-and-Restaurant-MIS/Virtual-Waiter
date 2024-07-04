class MenuItem {
  final int id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final int availableQuantity;
  final List<String> tags;

  MenuItem({
    required this.tags,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.availableQuantity,
  });

  // Factory constructor to create an instance of MenuItem from a map
  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      category: map['category'],
      imageUrl: map['imageUrl'] ?? 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
      availableQuantity: map['availableQuantity'],
      tags: List<String>.from(map['tags']),
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
      'availableQuantity': availableQuantity,
      'tags':tags,
    };
  }
}
