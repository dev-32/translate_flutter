import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:translator/data/model/translated_data_model.dart';
import 'package:translator/presentation/home/bloc/first_lang_sel_cubit.dart';
import 'package:translator/presentation/home/bloc/second_lang_cubit.dart';
import 'package:translator/presentation/home/bloc/second_lang_sel_cubit.dart';

class TranslateApiService {
  final String baseUrl = "https://translate-plus.p.rapidapi.com";

  var headers = {
    'x-rapidapi-key': "47f467a080msh6f3bf7f05fd1c36p1122a2jsnaf1ee60c7d6f",
    'x-rapidapi-host': "translate-plus.p.rapidapi.com",
    'Content-Type': "application/json"
  };

  Future<Either<String?, String?>> translate(
      String text, BuildContext context) async {
    String endpoint = "/translate";
    var body = json.encode({
      "text": text,
      "source": context.read<FirstLangSelCubit>().state.values.toList()[0],
      "target": context.read<SecondLangSelCubit>().state.values.toList()[0]
    });
    try {
      http.Response response = await http.post(Uri.parse(baseUrl + endpoint),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        TranslatedData data = TranslatedData.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        if (data.translations != null) {
          context
              .read<SecondLangCubit>()
              .setText(data.translations!.translation!);
        }
        return right("success");
      }
      throw "Something Went Wrong";
    } catch (e) {
      return left(e.toString());
    }
  }
}
