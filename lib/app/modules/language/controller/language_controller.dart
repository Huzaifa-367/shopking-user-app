import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/language/model/language_model.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';

class LanguageController extends GetxController {
  final box = GetStorage();

  LanguageModel languageModelData = LanguageModel();
  LanguageData languageData = LanguageData();
  List<LanguageData> languageDataList = <LanguageData>[];

  @override
  void onInit() {
    getLanguageData();
    if (box.read('selectedLanguageValue') == null) {
      box.write('languageCode', 'en');
      box.write('selectedLanguageValue', 'English');
      update();
    }
    super.onInit();
  }

  changeLanguage(String languageCode, String languageName) {
    box.write('languageCode', languageCode);
    box.write('selectedLanguageValue', languageName);
    Get.updateLocale(Locale(languageCode, null));
    update();
  }

  Future<LanguageModel> getLanguage() async {
    try {
      await AppServer()
          .getRequestWithoutToken(endPoint: ApiList.language)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          languageModelData = LanguageModel.fromJson(jsonResponse);
          return languageData;
        }
      });
      return languageModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return languageModelData;
  }

  getLanguageData() async {
    var langData = await getLanguage();
    if (langData.data!.isNotEmpty) {
      languageDataList = langData.data!;
      update();
    }
  }
}
