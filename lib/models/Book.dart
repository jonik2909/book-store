class Book {
  String? id;
  String? bookName;
  int? bookPrice;
  String? bookDesc;
  String? bookCategory;
  String? bookImage;
  String? bookAuthor;
  String? bookAuthorDesc;

  Book({
    required this.id,
    required this.bookName,
    required this.bookPrice,
    required this.bookDesc,
    required this.bookCategory,
    required this.bookImage,
    required this.bookAuthor,
    required this.bookAuthorDesc,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['bookName'];
    bookPrice = json['bookPrice'];
    bookDesc = json['bookDesc'];
    bookDesc = json['bookCategory'];
    bookImage = json['bookImage']['url'];
    bookAuthor = json['bookAuthor'];
    bookAuthorDesc = json['bookAuthorDesc'];
  }
}
