import 'package:flutter/material.dart';
import 'package:newsapp/helpers/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails(
      {super.key,
      required this.title,
      required this.description,
      required this.imgUrl,
      required this.url});

  final String title;
  final String description;
  final String imgUrl;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(height: 10.0),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                      TextButton(
                          onPressed: () async {
                            print(url);
                            if (!await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch url');
                            }
                          },
                          child: Text(
                            'Read More..',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
