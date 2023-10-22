import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helpers/enums.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/pages/news_details.dart';
import 'package:newsapp/services/news_provider.dart';
import 'package:provider/provider.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    final notifier = context.read<NewsNotifier>();
    await notifier.getCategoriesNews(widget.name.toLowerCase(), false);
    categories=notifier.categories;
  }

  @override
  void dispose() {
    categories.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Consumer<NewsNotifier>(builder: (context, notifier, _) {
          if (notifier.apiStatus == ApiStatus.loading) {
            Center(child: CircularProgressIndicator());
          }
          if (notifier.apiStatus == ApiStatus.error) {
            Center(child: Text("Something went Wrong"));
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  return ShowCategory(
                      Image:categories[index].urlToImage!,
                      desc: categories[index].description!,
                      title: categories[index].title!,
                      url: categories[index].url!);
                }),
          );
        }));
  }
}

class ShowCategory extends StatelessWidget {
  String Image, desc, title, url;
  ShowCategory(
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
      child: Material(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
