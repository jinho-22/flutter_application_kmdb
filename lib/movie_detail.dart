import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetail extends StatelessWidget {
  Map<String, dynamic> movie;
  MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var movieTitle = movie['title']
        .toString()
        .replaceAll(' !HS ', '')
        .replaceAll(' !HE ', '');
    dynamic titleImage = movie['posters'].toString().isEmpty
        ? Image.asset('asset/images/no-image.jpg')
        : Image.network(movie['posters'].toString().split('|')[0]);
    // var stills = movie['stlls'].toString().split('|');
    List<Widget> stills = [];
    if (movie['stlls'].toString().isEmpty) {
      stills.add(Image.asset(
        'asset/images/no-image.jpg',
        fit: BoxFit.fitHeight,
      ));
    } else {
      for (var k in movie['stlls'].toString().split('|')) {
        stills.add(Image.network(
          k,
          fit: BoxFit.fitHeight,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('영화상세 정보($movieTitle)')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(movieTitle),
            Row(
              children: [
                Text(movie['keywords']),
                Hero(tag: movie['movieSeq'], child: titleImage)
              ],
            ),
            ReadMoreText(
              movie['plots']['plot'][0]['plotText'],
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: '더보기',
              trimExpandedText: '숨기기',
              moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              lessStyle: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            ImageSlideshow(
                autoPlayInterval: 3000,
                isLoop: true,
                width: double.infinity,
                height: 200,
                children: stills),
            ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(movie['kmdbUrl'].toString()));
                },
                child: const Text('사이트 연결'))
          ],
        ),
      ),
    );
  }
}
