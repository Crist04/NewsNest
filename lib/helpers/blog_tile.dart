import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/news_details.dart';

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile(
      {required this.desc,
      required this.imageUrl,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewsDetails(title: title, description: desc, imgUrl:imageUrl,url: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          imageUrl: imageUrl,
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.red,
                            ),
                          ),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ))),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0),
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}