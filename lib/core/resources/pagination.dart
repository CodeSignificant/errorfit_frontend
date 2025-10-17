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

  late ScrollController scrollController;
  double _offset = 300;

  Future<PaginationModel<T>?> Function()? _onInitialLoad;
  Future<PaginationModel<T>?> Function(int nextPage)? _onFetch;

  bool get hasMore => currentPage.value < totalPages.value;
  List<T> get list => List.unmodifiable(items);

  Pagination() {
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  /// --- Static initializer ---
  static Future<Pagination<T>> listener<T>({
    required Pagination<T> controller,
    double offset = 300,
    required Future<PaginationModel<T>?> Function() onInitialLoad,
    required Future<PaginationModel<T>?> Function(int nextPage) onFetch,
  }) async {
    controller._offset = offset;
    controller._onInitialLoad = onInitialLoad;
    controller._onFetch = onFetch;

    await controller._loadInitial();
    return controller;
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
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - _offset &&
        !isFetching.value &&
        !isLoading.value &&
        hasMore) {
      _fetchNext();
    }
  }

  Future<void> _loadInitial() async {
    if (_onInitialLoad == null) return;

    isLoading.value = true;
    try {
      final model = await _onInitialLoad!();
      if (model != null) _applyModel(model);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchNext() async {
    if (_onFetch == null) return;

    isFetching.value = true;
    try {
      final model = await _onFetch!(currentPage.value + 1);
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
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
