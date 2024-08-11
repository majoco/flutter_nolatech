class BookModel {
  final int? bookId;
  final int canchaId;
  final int userId;
  final String reservedStart;
  final String reservedEnd;
  final String createdAt;

  const BookModel(
      {this.bookId,
      required this.canchaId,
      required this.userId,
      required this.reservedStart,
      required this.reservedEnd,
      required this.createdAt});

  factory BookModel.fromMap(Map<String, dynamic> json) => BookModel(
      bookId: json["bookId"],
      canchaId: json["canchaId"],
      userId: json["userId"],
      reservedStart: json["reservedStart"],
      reservedEnd: json["reservedEnd"],
      createdAt: json["createdAt"]);

  Map<String, dynamic> toMap() => {
        "bookId": bookId,
        "canchaId": canchaId,
        "userId": userId,
        "reservedStart": reservedStart,
        "reservedEnd": reservedEnd,
        "createdAt": createdAt
      };
}
