
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class News{
  // latest news
  List<NewsModel> news=[];
  NewsModel newsModel;
  //Hot news
  List<NewsModel> newsHot=[];
  NewsModel newsHotModel;

  Future<void> getNews()async{
    String api="https://newsapi.org/v2/everything?q=apple&from=2022-08-15&to=2022-08-15&sortBy=popularity&apiKey=954824d3d4e246d7b164211a6ab5d4f0";
    var response=await http.get(Uri.parse(api));
    var responseData=jsonDecode(response.body);
    if(responseData["status"]=="ok"){
      responseData["articles"].forEach((element){
        if(element["urlToImage"] !=null && element["description"]!=null){
          newsModel=NewsModel(
              title:element["title"],
              urlToImage: element["urlToImage"],
              publishedAt:DateTime.parse(element["publishedAt"]),
              url: element["url"],
          );
          news.add(newsModel);
        }
      }
      );

    }
  }
  Future<void> getHotNews()async{
    String api="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=954824d3d4e246d7b164211a6ab5d4f0";
    var response=await http.get(Uri.parse(api));
    var responseData=jsonDecode(response.body);
    if(responseData["status"]=="ok"){
      responseData["articles"].forEach((element){
        if(element["urlToImage"] !=null && element["description"]!=null && element["publishedAt"] !=null){
          newsHotModel=NewsModel(
            title:element["title"],
            urlToImage: element["urlToImage"],
            publishedAt:DateTime.parse(element["publishedAt"]),
            url: element["url"],
          );
          newsHot.add(newsHotModel);
        }
      }
      );

    }
  }
}