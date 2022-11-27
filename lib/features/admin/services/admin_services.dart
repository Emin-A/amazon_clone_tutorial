// ignore: unused_import
import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dnte2jj7t', 'mbh7nz0l');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      // ignore: unused_local_variable
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
