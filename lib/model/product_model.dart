
class Product {

  final String id;
  final String title;
  final String description;
  final String image;
  final String size;
  final String rate;


  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.size,
    required this.rate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'rate': rate,
      'size': size,
    };
  }

}
