import 'package:flutter/material.dart';
import 'package:tailor_book/colors.dart';
import 'package:tailor_book/home/category_page.dart';
import 'package:tailor_book/home/order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blue,
        centerTitle: true,
        title: const Text(
          "Tailor Book",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
      ),
      body: Expanded(
        child: Container(
          child: _currentIndex == 0 ? const OrderPage() : const CategoryPage(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
        backgroundColor: white,
        selectedIconTheme: const IconThemeData(size: 40, color: blue),
        unselectedIconTheme: IconThemeData(size: 30, color: grey!),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: blue,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_long_outlined,
              ),
              label: "Order"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
            ),
            label: "Category",
          )
        ],
      ),
    );
  }
}
