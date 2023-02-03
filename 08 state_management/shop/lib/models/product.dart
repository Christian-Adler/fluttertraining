class Product {
  final String id;
  final String title;
  final String desc;
  final double price;
  final String imageURL;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.desc,
      required this.price,
      required this.imageURL,
      this.isFavorite = false});
}
