import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsapp/helpers/enums.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/models/slider_model.dart';

class NewsNotifier extends ChangeNotifier {
  List<ArticleModel> _news = [];
  List<ArticleModel> get news => _news;

  List<ShowCategoryModel> _categories = [];
  List<ShowCategoryModel> get categories => _categories;

   List<sliderModel> _sliders = [];
    List<sliderModel> get sliders => _sliders;

  ApiStatus _apiStatus = ApiStatus.initial;
  ApiStatus get apiStatus => _apiStatus;

  void _setApiStatus(ApiStatus apiStatus, {bool notify = true}) {
    _apiStatus = apiStatus;
    if (notify) notifyListeners();
  }

  Future<void> getNews(bool notify) async {
    _setApiStatus(ApiStatus.loading, notify: notify);
    
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=83af25a1130f4735bda370064b445436";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          print(element["title"]);
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"]==null?'':element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          _news.add(articleModel);
        }
        _setApiStatus(ApiStatus.success);
      });
      
    } else {
      print(response.body);
      _setApiStatus(ApiStatus.error);
    }
  }

   Future<void> getCategoriesNews(String category,bool notify) async {
    _setApiStatus(ApiStatus.loading, notify: notify);
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=83af25a1130f4735bda370064b445436";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          _categories.add(categoryModel);
        }
      });
      _setApiStatus(ApiStatus.success);
    }
    else {
      print(response.body);
      _setApiStatus(ApiStatus.error);
    }
  }

  Future<void> getSlider(bool notify) async {
    _setApiStatus(ApiStatus.loading, notify: notify);
    String url =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=83af25a1130f4735bda370064b445436";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {

      //one can easily use to json format but i made the models manually instead of generating
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          sliderModel slidermodel = sliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          _sliders.add(slidermodel);
        }
      });
      _setApiStatus(ApiStatus.success);
    }
    else {
      print(response.body);
      _setApiStatus(ApiStatus.error);
    }
  }
}
