import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchTextController;
  final String hintText;
  const SearchWidget({
    super.key,
    required this.searchTextController, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        suffixIcon: const Icon(Icons.filter_alt_outlined),
        prefixIcon: const Icon(Icons.search_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}
