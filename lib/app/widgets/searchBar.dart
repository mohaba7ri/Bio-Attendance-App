import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  
  const SearchBar({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
         
        },
        // controller: editingController,
        decoration: InputDecoration(
            labelText: "Search".tr,
            hintText: "Search".tr,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  
  }
}
