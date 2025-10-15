import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationModel<T> {
  final int totalPages;
  final int currentPage;
  final List<T> items;

  PaginationModel({
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });
}

class Pagination<T> extends GetxController {
  final RxList<T> items = <T>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isFetching = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;

  late Future<PaginationModel<T>?> Function() _onInitialLoad;
  late Future<PaginationModel<T>?> Function(int nextPage) _onFetch;

  ScrollController _scrollController = ScrollController();
  double _offset = 300;

  bool get hasMore => currentPage.value < totalPages.value;

  ScrollController get scrollController => _scrollController;
  List<T> get list => List.unmodifiable(items);

  /// --- Static initializer ---
  static Future<Pagination<T>> listener<T>({
    Pagination<T>? controller,
    ScrollController? scrollController,
    double offset = 300,
    required Future<PaginationModel<T>?> Function() onInitialLoad,
    required Future<PaginationModel<T>?> Function(int nextPage) onFetch,
  }) async {
    final instance = controller ?? Pagination<T>();

    instance._scrollController = scrollController ?? ScrollController();
    instance._offset = offset;
    instance._onInitialLoad = onInitialLoad;
    instance._onFetch = onFetch;

    instance._scrollController.addListener(instance._onScroll);
    await instance._loadInitial();

    return instance;
  }

  /// --- Public Actions ---
  Future<void> reload() async {
    items.clear();
    currentPage.value = 1;
    totalPages.value = 1;
    await _loadInitial();
  }

  Future<void> reset() async {
    items.clear();
    currentPage.value = 1;
    totalPages.value = 1;
  }

  Future<void> fetchNext() async {
    if (isFetching.value || !hasMore) return;
    await _fetchNext();
  }

  /// --- Private logic ---
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _offset &&
        !isFetching.value && !isLoading.value &&
        hasMore) {
      _fetchNext();
    }
  }

  Future<void> _loadInitial() async {
    isLoading.value = true;
    try {
      final model = await _onInitialLoad();
      if (model != null) _applyModel(model);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchNext() async {
    isFetching.value = true;
    try {
      final model = await _onFetch(currentPage.value + 1);
      if (model != null) _applyModel(model, append: true);
    } finally {
      isFetching.value = false;
    }
  }

  void _applyModel(PaginationModel<T> model, {bool append = false}) {
    totalPages.value = model.totalPages;
    currentPage.value = model.currentPage;
    if (append) {
      items.addAll(model.items);
    } else {
      items.assignAll(model.items);
    }
    isLoading.value = false;
    isFetching.value = false;
  }

  @override
  void onClose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.onClose();
  }
}
