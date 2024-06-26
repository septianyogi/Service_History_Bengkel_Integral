// ignore_for_file: unnecessary_import, prefer_const_constructors, unnecessary_to_list_in_spreads

import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:bengkel_service/config/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class AppResponse {
  static Map data(Response response) {
    DMethod.printResponse(response);

    switch (response.statusCode) {
      case 200: // read
        var responseBody = jsonDecode(response.body);
        return responseBody;
      case 201: // create,update
        var responseBody = jsonDecode(response.body);
        return responseBody;
      case 204: //delete
        return {'success':true};
      case 400:
        throw BadRequestFailure(response.body);
      case 401:
        throw UnauthorisedFailure(response.body);
      case 422:
        throw InvalidInputFailure(response.body);
      case 403: // url bermasalah
        throw ForbiddenFailure(response.body);
      case 404: // url tidak ditemukan, data kosong
        throw NotFoundFailure(response.body);
      case 500: // server error
        throw ServerFailure(response.body);
      default:
        throw FetchFailure(response.body);
    }
  }


  static invalidInput(BuildContext context, String messageBody) {
    Map errors = jsonDecode(messageBody)['errors'];
    showDialog(
      context: context, 
      builder: (context) {
        return SimpleDialog(
          titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          title : const Text('Invalid Input'),
          children: [
            ...errors.entries.map((e) {
              return ListTile(
                title: Text(e.key),
                subtitle: Column(
                  children: (e.value as List).map((itemError) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- '),
                        Expanded(child: Text(itemError))
                      ],
                    );
                  }).toList(),
                ),
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              )
          ],
        );
      });
  }
}