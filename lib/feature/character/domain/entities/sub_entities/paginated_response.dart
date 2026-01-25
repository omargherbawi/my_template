import 'character_info.dart';

class PaginatedResponse<T> {
  final List<T> data;
  final Pagination pagination;

  PaginatedResponse({
    required this.data,
    required this.pagination,
  });
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 10,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }

  // Create pagination from CharacterInfo
  factory Pagination.fromCharacterInfo(CharacterInfo info, int currentPage) {
    return Pagination(
      currentPage: currentPage,
      lastPage: info.pages,
      perPage: 20, // Rick and Morty API default
      total: info.count,
      nextPageUrl: info.next,
      prevPageUrl: info.prev,
    );
  }

  bool get hasMore => currentPage < lastPage;
}