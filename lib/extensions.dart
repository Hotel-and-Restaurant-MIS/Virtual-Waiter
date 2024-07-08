extension UpdateWhereExtension<E> on List<E> {
  void updateWhere(bool Function(E) test, E Function(E) update) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = update(this[i]);
      }
    }
  }
}