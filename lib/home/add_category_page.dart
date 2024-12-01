import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor_book/config.dart';
import '../colors.dart';
import 'package:http/http.dart' as http;

class AddCategoryPage extends StatefulWidget {
  final id, categoryName, categoryPic, categoryType;
  const AddCategoryPage(
      {this.categoryName,
      this.categoryPic,
      this.categoryType,
      this.id,
      super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController categoryNameController = TextEditingController();
  Object? image;
  final ImagePicker _imagePicker = ImagePicker();
  String? base64String;
  var category_type = 0;
  var delShow = false;

  Future<void> imagePicker() async {
    final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedImage != null) {
      image = await File(pickedImage.path).readAsBytes();

      base64String = base64Encode(image as Uint8List);
      print(base64String);

      setState(() {});
    } else {
      print("Image not picked.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkData();
  }

  void deleteCategory(id) async {
    var body = {
      "id": id,
    };
    try {
      var res = await http.post(
        Uri.parse(deleteCategoryApi),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );

      if (res.statusCode == 200) {
        Fluttertoast.showToast(msg: "The Categroy successfully deleted");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: "Some error occur while deleting Categroy.");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  void showDeleteCategoryDialog(
      BuildContext context, String categoryName, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Category"),
          content: Text(
              "Are you sure you want to delete the category $categoryName ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteCategory(widget.id);
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  void addCategory() async {
    if (categoryNameController.text.isNotEmpty) {
      var categoryBody = {
        "category_pic": base64String,
        "category_name": categoryNameController.text,
        "category_type": category_type == 0 ? "Upper" : "Lower",
      };

      try {
        var response = await http.post(
          Uri.parse(addCategoryApi),
          body: jsonEncode(categoryBody),
          headers: {"Content-Type": "application/json; charset=UTF-8"},
        );

        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          print("Message: $message");
          Fluttertoast.showToast(msg: "Category Added Successful");
          Navigator.pop(context);
        } else {
          print("Error : ${response.body}");
        }
      } catch (e) {
        print("error: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "some error occured or select all fields.");
    }
  }

  void updateCategory() async {
    var base64StringForUpdate = base64Encode(image as Uint8List);
    if (categoryNameController.text.isNotEmpty) {
      var categoryBody = {
        "category_pic": base64StringForUpdate,
        "category_name": categoryNameController.text,
        "category_type": category_type == 0 ? "Upper" : "Lower",
      };

      try {
        var response = await http.post(
          Uri.parse(updateCategoryApi),
          body: jsonEncode(categoryBody),
          headers: {"Content-Type": "application/json; charset=UTF-8"},
        );

        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          print("Message: $message");
          Fluttertoast.showToast(msg: "Category Updated Successful");
          Navigator.pop(context);
        } else {
          print("Error : ${response.body}");
        }
      } catch (e) {
        print("error: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "some error occured or select all fields.");
    }
  }

  void checkData() {
    if (widget.id == null &&
        widget.categoryName == null &&
        widget.categoryType == null &&
        widget.categoryPic == null) {
      categoryNameController.text = "";
      image = null;
    } else {
      delShow = true;
      categoryNameController.text = widget.categoryName ?? "";

      if (widget.categoryType == "Upper") {
        category_type = 0;
      } else {
        category_type = 1;
      }

      if (widget.categoryPic != null) {
        if (widget.categoryPic.startsWith('http') ||
            widget.categoryPic.startsWith('https')) {
          image = widget.categoryPic;
        } else {
          Uint8List decodedImage = base64Decode(widget.categoryPic);
          if (decodedImage.isNotEmpty) {
            image = decodedImage;
          } else {
            image = null;
          }
        }
      } else {
        image = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: delShow == false
          ? Container()
          : FloatingActionButton(
              backgroundColor: grey!,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.delete_outline,
                size: 30,
                color: white,
              ),
              onPressed: () {
                showDeleteCategoryDialog(
                  context,
                  "${widget.categoryName}",
                  () {
                    // Perform the delete action here
                    print("Category deleted");
                  },
                );
              },
            ),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                imagePicker();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    height: MediaQuery.of(context).size.width / 1.2,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: image != null
                        ? (image is String
                            ? Image.network(image.toString())
                            : Image.memory(image as Uint8List))
                        : Icon(
                            Icons.add_a_photo,
                            size: MediaQuery.of(context).size.width / 2.2,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: grey!,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "Enter Category Name",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: grey!,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                "Category Type",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: grey!,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category_type = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: category_type == 0 ? Colors.blue : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        "Upper",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category_type = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: category_type == 1 ? Colors.blue : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        "Lower",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.id != null &&
                      widget.categoryName != null &&
                      widget.categoryType != null &&
                      widget.categoryPic != null) {
                    updateCategory();
                  } else {
                    addCategory();
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 70)),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
