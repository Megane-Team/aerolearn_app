String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 4 && hour < 10) {
    return 'Selamat Pagi';
  } else if (hour >= 10 && hour < 14) {
    return 'Selamat Siang!';
  } else if (hour >= 14 && hour < 18) {
    return 'Selamat Sore!';
  } else {
    return 'Selamat Malam!';
  }
}
