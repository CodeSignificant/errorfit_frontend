class PaginationModel<T> {
  final int presentPage;
  final int totalPages;
  final T data;

  PaginationModel({
    required this.presentPage,
    required this.totalPages,
    required this.data,
  });
}
