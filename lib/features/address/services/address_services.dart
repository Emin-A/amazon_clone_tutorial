// ignore: unused_import
import 'dart:convert';
// ignore: unused_import
import 'dart:developer';
// ignore: unused_import
import 'dart:io';

import 'package:amazon_clone_tutorial/constants/error_handling.dart';
import 'package:amazon_clone_tutorial/constants/utils.dart';
// ignore: unused_import
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:amazon_clone_tutorial/models/user.dart';
// ignore: unused_import
import 'package:amazon_clone_tutorial/providers/user_provider.dart';
// ignore: unused_import
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) {}
}

void placeOrder(
    {required BuildContext context,
    required String address,
    required double total}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  try {
    var totalSum;
    http.Response res = await http.post(Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalSum,
        }));

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        showSnackBar(context, 'Your order has been placed!');
        User user = userProvider.user.copyWith(
          cart: [],
        );
        userProvider.setUserFromModel(user);
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

void deleteProduct({
  required BuildContext context,
  required Product product,
  required VoidCallback onSuccess,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  try {
    http.Response res = await http.post(
      Uri.parse('$uri/admin/delete-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'id': product.id,
      }),
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        onSuccess();
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
