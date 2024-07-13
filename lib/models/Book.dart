class BookModel {
  String? id;
  String? bookName;
  int? bookPrice;
  String? bookDesc;
  String? bookImage;
  String? bookAuthor;
  String? bookAuthorDesc;

  BookModel({
    required this.id,
    required this.bookName,
    required this.bookPrice,
    required this.bookDesc,
    required this.bookImage,
    required this.bookAuthor,
    required this.bookAuthorDesc,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['bookName'];
    bookPrice = json['bookPrice'];
    bookDesc = json['bookDesc'];
    bookImage = json['bookImage']['url'];
    bookAuthor = json['bookAuthor'];
    bookAuthorDesc = json['bookAuthorDesc'];
  }
}
