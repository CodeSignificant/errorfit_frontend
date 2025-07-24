// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../config/styles/app_colors.dart';
// import '../../config/styles/font_styles.dart';
//
// // Dropdown model to represent selectable items
// class DropdownModel<T> {
//   final String title;
//   final T model;
//
//   DropdownModel({required this.title, required this.model});
//
//   @override
//   String toString() => title;
// }
//
// // Controller for the dropdown logic
// class SearchableDropDownControl<T> extends GetxController {
//   final textController = TextEditingController();
//   final RxList<DropdownModel<T>> _items = <DropdownModel<T>>[].obs;
//   final Rxn<DropdownModel<T>> _selected = Rxn<DropdownModel<T>>();
//
//   void onChange(Function(String value) onChange) {
//     textController.addListener(() => onChange(textController.text.trim()));
//   }
//
//   List<DropdownModel<T>> get items => _items;
//
//   DropdownModel<T>? get value => _selected.value;
//
//   void setSelected(DropdownModel<T> value) => _selected.value = value;
//
//   T? get selected => _selected.value?.model;
//
//   void clear() => _selected.value = null;
//
//   void addItem(DropdownModel<T> item) {
//     _items.add(item);
//     _items.refresh();
//   }
//
//   void addAllItems(List<DropdownModel<T>> items) {
//     _items
//       ..clear()
//       ..addAll(items);
//     _items.refresh();
//   }
//
//
//   void removeItem(DropdownModel<T> item) => _items.remove(item);
// }
//
// // The main widget for searchable dropdown
// class SearchableDropDown<T> extends StatefulWidget {
//   final SearchableDropDownControl<T>? controller;
//   final Widget Function(DropdownModel<T> dropdownItem) tile;
//   final DropdownModel<T>? selectedItem;
//   final String? label;
//   final bool mandatory;
//   final List<DropdownModel<T>>? items;
//   final ValueChanged<DropdownModel<T>>? onItemSelected;
//   final EdgeInsets? padding;
//   final BoxConstraints? constraints;
//
//   const SearchableDropDown({
//     super.key,
//     this.controller,
//     required this.tile,
//     this.selectedItem,
//     this.onItemSelected,
//     this.padding,
//     this.items,
//     this.constraints,
//     this.label,
//     this.mandatory = true,
//   });
//
//   @override
//   State<SearchableDropDown<T>> createState() => _SearchableDropDownState<T>();
// }
// class _SearchableDropDownState<T> extends State<SearchableDropDown<T>> {
//   final LayerLink _layerLink = LayerLink();
//   final GlobalKey _key = GlobalKey();
//   OverlayEntry? _overlayEntry;
//   late final SearchableDropDownControl<T> control;
//
//   @override
//   void initState() {
//     super.initState();
//     control = widget.controller ?? SearchableDropDownControl<T>();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.selectedItem != null) {
//         control.setSelected(widget.selectedItem!);
//       }
//       if (widget.items != null) {
//         control.addAllItems(widget.items!);
//       }
//       control.textController.addListener(() {
//         if (_overlayEntry == null) {
//           _showDropdown();
//         }
//       });
//     });
//
//   }
//
//   @override
//   void dispose() {
//     _removeDropdown();
//     super.dispose();
//   }
//
//   void _toggleDropdown() {
//     if (_overlayEntry == null) {
//       _showDropdown();
//     } else {
//       _removeDropdown();
//     }
//   }
//
//   void _showDropdown() {
//     final RenderBox renderBox =
//     _key.currentContext!.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//     final position = renderBox.localToGlobal(Offset.zero);
//
//     final screenHeight = MediaQuery.of(context).size.height;
//     const double dropdownMaxHeight = 200;
//     final double dropdownMaxWidth = size.width;
//
//     final double spaceAbove = position.dy;
//     final double spaceBelow = screenHeight - (position.dy + size.height);
//
//     final bool showAbove = spaceBelow < dropdownMaxHeight;
//     final double dropdownHeight = showAbove
//         ? spaceAbove.clamp(0, dropdownMaxHeight)
//         : spaceBelow.clamp(0, dropdownMaxHeight);
//
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Stack(
//         children: [
//           Positioned.fill(
//             child: GestureDetector(
//               onTap: _removeDropdown,
//               behavior: HitTestBehavior.translucent,
//               child: Container(color: Colors.transparent),
//             ),
//           ),
//           Positioned(
//             left: position.dx,
//             width: size.width,
//             top: showAbove ? null : position.dy + size.height,
//             bottom: showAbove ? screenHeight - position.dy : null,
//             child: Material(
//               elevation: 4,
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Container(
//                   constraints: widget.constraints ??
//                       BoxConstraints(
//                         maxHeight: dropdownHeight,
//                         maxWidth: dropdownMaxWidth,
//                       ),
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: AppColors.light,
//                         offset: Offset(4, 0),
//                         spreadRadius: 1,
//                         blurRadius: 7,
//                       ),
//                     ],
//                   ),
//                   child: Obx(() =>
//                       SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisSize: MainAxisSize.min,
//                           children: control.items.map((item) {
//                             return GestureDetector(
//                               onTap: () => _selectItem(item),
//                               child: widget.tile(item),
//                             );
//                           }).toList(),
//                         ),
//                       )),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//
//     Overlay.of(context).insert(_overlayEntry!);
//   }
//
//   void _removeDropdown() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }
//
//   void _selectItem(DropdownModel<T> item) {
//     control.setSelected(item);
//     widget.onItemSelected?.call(item);
//     control.textController.text = item.title;
//     _removeDropdown();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         key: _key,
//         onTap: _toggleDropdown,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             if (widget.label != null)
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "${widget.label} ",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppColors.accent,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     if (widget.mandatory)
//                       TextSpan(
//                         text: "*",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: AppColors.primary,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     if (!widget.mandatory)
//                       TextSpan(
//                         text: "(optional)",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.grey,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             if (widget.label != null) const SizedBox(height: 8),
//             Container(
//               padding:
//               widget.padding ?? const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.primary),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: TextField(
//                 controller: control.textController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: control.value?.title ?? "Select", // Default value
//                   hintStyle: FontStyles.s12Grey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
