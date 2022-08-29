import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'classes/articles_news.dart';
import 'model/news_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> urlLaunch(String url)async{
    if(await canLaunch(url)){
      launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String,String>{
          "my_header_view" : "my_header_view",
        },
      );
    }else{
      throw "This $url cannot View";
    }
  }
  Widget _buildSingleLatestNews({String image, String title, DateTime date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
             image: DecorationImage(
                fit: BoxFit.cover,
                  image: NetworkImage(image)
              ),
            ),
            width: 350,
          ),
        ),
        Container(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
             title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            DateFormat("MMM dd, yyy - kk:mm").format(date).toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleHotNews({String image, String title, DateTime date}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 60,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image)
                  ),
                ),

              ),
            ),
            Container(
              width: 290,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat("MMM dd, yyy - kk:mm").format(date).toString(),
            ),
          ],
        ),
    );
  }

  List<NewsModel> myList;
  List<NewsModel> myHotList;
  @override
  void initState() {
    News news = News();
    news.getNews();
    news.getHotNews();
    setState(() {
      myList = news.news;
      myHotList=news.newsHot;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(myList.length);
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xfff8f8f8),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 65,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Today's News",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "August,Monday",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 28,
                      backgroundImage: AssetImage("images/haad.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latest News",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Container(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myList.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                      onTap: (){
                        urlLaunch(myList[index].url);
                      },
                      child: _buildSingleLatestNews(
                        date: myList[index].publishedAt,
                        image: myList[index].urlToImage,
                        title: myList[index].title,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hot News",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 20),
                height: 290,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: myHotList.length,
                  itemBuilder: (ctx, index) => GestureDetector(
                    onTap: (){
                      urlLaunch(myList[index].url);
                    },
                    child: _buildSingleHotNews(
                      date: myHotList[index].publishedAt,
                      image: myHotList[index].urlToImage,
                      title: myHotList[index].title,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
