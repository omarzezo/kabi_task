extension ListExt<T> on List<T> {
  void bubbleSort(int compare(T a, T b)) {
    int len = this.length;
    for (int i = 0; i < len - 1; i++) {
      for (int j = 0; j < len - i - 1; j++) {
        if (compare(this[j], this[j + 1]) > 0) {
          T tempValue = this[j];
          this[j] = this[j + 1];
          this[j + 1] = tempValue;
        }
      }
    }
  }
}
