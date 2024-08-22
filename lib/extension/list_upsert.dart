extension ListUpsert<T> on List<T> {
  /// Upsert method to update or insert an item in the list
  void upsert(T item, bool Function(T element) condition) {
    // Check if the item exists in the list
    final index = indexWhere(condition);
    if (index != -1) {
      // Update the existing item
      this[index] = item;
    } else {
      // Insert the new item
      add(item);
    }
  }
}
