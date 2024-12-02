class Assets {
  static const path = 'assets/image';

  static String logos(String name) {
    return '$path/logo/$name.png';
  }

  static String icons(String name) {
    return '$path/icon/$name.png';
  }

  static String files(String name) {
    return 'assets/docs/$name.pdf';
  }
}
