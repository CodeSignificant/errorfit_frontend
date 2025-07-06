import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/styles/app_colors.dart';

/// Controller class for managing selected model item and dynamic item list
class CustomModelDropDownControl<T> extends GetxController {
  final RxList<T> _items = <T>[].obs;
  final Rxn<T> _selected = Rxn<T>();

  List<T> get items => _items;

  T? get value => _selected.value;

  void setSelected(T value) => _selected.value = value;

  void clear() => _selected.value = null;

  void addItem(T item) => _items.add(item);

  void addAllItems(List<T> items) => _items.addAll(items);

  void removeItem(T item) => _items.remove(item);

  Rxn<T> get selected => _selected;
}

class CustomModelDropDown<T> extends StatefulWidget {
  final CustomModelDropDownControl<T>? controller;
  final Widget Function(T model) tile;
  final Widget Function(T model) child;
  final T selectedItem;
  final List<T>? items;
  final ValueChanged<T>? onItemSelected;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  const CustomModelDropDown({
    super.key,
    this.controller,
    required this.tile,
    required this.child,
    required this.selectedItem,
    this.onItemSelected,
    this.padding,
    this.items, this.constraints,
  });

  @override
  State<CustomModelDropDown<T>> createState() => _CustomModelDropDownState<T>();
}

class _CustomModelDropDownState<T> extends State<CustomModelDropDown<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  late final CustomModelDropDownControl control;

  @override
  void initState() {
    super.initState();
    control = widget.controller ?? CustomModelDropDownControl();
    control.setSelected(widget.selectedItem);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.items != null) control.addAllItems(widget.items!);
    },);
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  void _showDropdown() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;
    const double dropdownMaxHeight = 200;
    final double dropdownMaxWidth = size.width;

    final double spaceAbove = position.dy;
    final double spaceBelow = screenHeight - (position.dy + size.height);

    final bool showAbove = spaceBelow < dropdownMaxHeight;
    final double dropdownHeight = showAbove
        ? spaceAbove.clamp(0, dropdownMaxHeight)
        : spaceBelow.clamp(0, dropdownMaxHeight);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeDropdown,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            left: position.dx,
            width: size.width,
            top: showAbove ? null : position.dy + size.height,
            bottom: showAbove ? screenHeight - position.dy : null,
            child: Material(
              elevation: 4,
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  constraints: widget.constraints??BoxConstraints(
                    maxHeight: dropdownHeight,
                    maxWidth: dropdownMaxWidth,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.light,
                            offset: Offset(4, 0),
                            spreadRadius: 1,
                            blurRadius: 7)
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: control.items.map((item) {
                        return InkWell(
                          onTap: () => _selectItem(item),
                          child: widget.tile(item),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _selectItem(T item) {
    control.setSelected(item);
    widget.onItemSelected?.call(item);
    _removeDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _key,
        onTap: _toggleDropdown,
        child: Obx(() {
          final selected = control.selected.value;
          return Container(
            // padding: widget.padding ??
            //     const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.grey.shade400),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.etYellow),
              borderRadius: BorderRadius.circular(50),
            ),

            child: selected != null
                ? widget.child(selected)
                : const Row(
                    children: [
                      Text("Select One"),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
