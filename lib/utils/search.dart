List<Map<String, String>> filterTraining(
    List<Map<String, String>> training, String searchQuery) {
  if (searchQuery.isEmpty) {
    return training;
  } else {
    return training.where((item) {
      return item['jenis_latihan']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
  }
}
