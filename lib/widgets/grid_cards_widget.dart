import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridCardsWidget<T> extends StatefulWidget {
  final String jsonPath;
  final String imagePath;

  final T Function(Map<String, dynamic> json) fromJson;

  final int Function(T item) getId;

  final String Function(T item) getTitle;

  final String Function(T item) getImage;

  final Function(T item) onItemTap;

  final Function(List<T>) onItemsSelected;

  const GridCardsWidget({
    super.key,
    required this.jsonPath,
    required this.imagePath,
    required this.fromJson,
    required this.getId,
    required this.getTitle,
    required this.getImage,
    required this.onItemTap,
    required this.onItemsSelected,
  });

  @override
  State<GridCardsWidget<T>> createState() => _GridCardsWidgetState<T>();
}

class _GridCardsWidgetState<T> extends State<GridCardsWidget<T>> {
  List<T> items = [];

  // Items selected by the user
  List<T> selectedItems = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final String jsonString = await rootBundle.loadString(widget.jsonPath);

    final List<dynamic> jsonData = jsonDecode(jsonString);

    final List<T> loadedItems = jsonData
        .map((item) => widget.fromJson(item as Map<String, dynamic>))
        .toList();

    if (!mounted) return;

    setState(() {
      items = loadedItems;
    });
  }

  void addItem(T item) {
    final int itemId = widget.getId(item);

    // Prevent duplicates
    final bool alreadyAdded = selectedItems.any(
      (selectedItem) => widget.getId(selectedItem) == itemId,
    );

    if (!alreadyAdded) {
      setState(() {
        selectedItems.add(item);
      });

      widget.onItemsSelected(List.from(selectedItems));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 145.h,
        left: 16.w,
        right: 16.w,
        bottom: 90.h,
      ),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          final T item = items[index];

          final int itemId = widget.getId(item);

          final bool isAdded = selectedItems.any(
            (selectedItem) => widget.getId(selectedItem) == itemId,
          );

          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                // Item Image
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      widget.onItemTap(item);
                    },
                    child: Image.asset(
                      '${widget.imagePath}/${widget.getImage(item)}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFD0C4C4),
                          child: Center(
                            child: Text(
                              'No Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.5),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),

                // Item Title
                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  right: 50.w,
                  child: Text(
                    widget.getTitle(item),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Add Button
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: Material(
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        addItem(item);
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isAdded ? Icons.check : Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
