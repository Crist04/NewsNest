import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helpers/enums.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/services/news_provider.dart';
import 'package:newsapp/pages/news_details.dart';
import 'package:provider/provider.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    final notifier = context.read<NewsNotifier>();
    await notifier.getNews(false);
    articles = notifier.news;
  }

  getSlider() async {
    final notifier = context.read<NewsNotifier>();
    await notifier.getSlider(false);

    sliders = notifier.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Consumer<NewsNotifier>(builder: (context, notifier, _) {
          if (notifier.apiStatus == ApiStatus.loading) {
            Center(child: CircularProgressIndicator());
          }
          if (notifier.apiStatus == ApiStatus.error) {
            Center(child: Text("Something went Wrong"));
          }
          if(widget.news == "Breaking"
                        ? notifier.sliders.length==0
                        : notifier.news.length==0)
                        {
                          Center(child: Text("No News to Show"));
                        }
          return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount:
                  widget.news == "Breaking" ? sliders.length : articles.length,
              itemBuilder: (context, index) {
                return AllNewsSection(
                    Image: widget.news == "Breaking"
                        ? notifier.sliders[index].urlToImage!
                        : notifier.news[index].urlToImage!,
                    desc: widget.news == "Breaking"
                        ? notifier.sliders[index].description!
                        : notifier.news[index].description!,
                    title: widget.news == "Breaking"
                        ? notifier.sliders[index].title!
                        : notifier.news[index].title!,
                    url: widget.news == "Breaking"
                        ? notifier.sliders[index].url!
                        : notifier.news[index].url!);
              });
        }),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title, url;
  AllNewsSection(
      {required this.Image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetails(
                    title: title, description: desc, imgUrl: Image, url: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
