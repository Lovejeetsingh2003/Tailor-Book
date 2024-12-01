import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tailor_book/config.dart';
import 'package:tailor_book/home/add_category_page.dart';
import 'package:tailor_book/objects/category_object.dart';
import 'package:http/http.dart' as http;
import '../colors.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var list_length = 0;
  static Future<List<CategoryObject>> getCategory() async {
    List<CategoryObject> category = [];
    try {
      final res = await http.get(
        Uri.parse(getCategoryApi),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        if (data['data'] != null && data['data'] is List) {
          data['data'].forEach((value) {
            category.add(
              CategoryObject(
                id: value['_id'],
                categoryName: value['category_name'] ?? 'Unknown',
                categoryPic: value['category_pic'] ?? 'Unknown',
                categoryType: value['category_type'] ?? 'Unknown',
              ),
            );
          });
          return category;
        } else {
          print("No Category found");
          return [];
        }
      } else {
        print("Failed to load Category. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      print("error : $e");
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddCategoryPage(),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        },
      ),
      body: CustomScrollView(slivers: [
        Expanded(
          child: FutureBuilder(
            future: getCategory(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                List<CategoryObject> list = snapshot.data;
                list_length = list.length;
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var category = list[index];
                      var id = category.id;
                      var categoryType = category.categoryType;
                      var image = category.categoryPic;
                      var categoryName = category.categoryName;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => AddCategoryPage(
                                id: id,
                                categoryName: categoryName,
                                categoryPic: image,
                                categoryType: categoryType,
                              ),
                              transitionDuration: const Duration(seconds: 1),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: image!.startsWith('http')
                                    ? Image.network(
                                        image,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Image.memory(
                                        base64Decode(image),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.fitHeight,
                                      ),
                              ),
                              Text(
                                categoryName!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: list_length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}
