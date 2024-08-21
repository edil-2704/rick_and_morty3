import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchTextController;
  final String hintText;
  final VoidCallback? onPressed;
  final VoidCallback? onChanged;

  const SearchWidget({
    super.key,
    required this.searchTextController,
    required this.hintText,
    this.onPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.filter_alt_outlined),
        ),
        prefixIcon: Icon(Icons.search_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}
