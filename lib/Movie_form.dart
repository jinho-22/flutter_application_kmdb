import 'package:flutter/material.dart';
import 'package:flutter_application_kmdb/movie_detail.dart';

class MovieForm extends StatelessWidget {
  Map<String, dynamic> movie;

  MovieForm({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    print(movie);
    var directorNm = movie['directors']['director'][0]['directorNm'];
    var actorNm = movie['actors']['actor'][0]['actorNm'];
    var posters = movie['posters'].split('|')[0];
    var movieTitle = movie['title']
        .toString()
        .replaceAll(' !HS ', '')
        .replaceAll(' !HE ', '');
    // !HS , !HE 빼기

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetail(movie: movie),
            ));
      },
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 100,
              child:
                  Hero(tag: movie['movieSeq'], child: Image.network(posters)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$movieTitle(${movie['prodYear']})',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text('$directorNm/($actorNm)'),
                  Text('${movie['repRlsDate']}'),
                  Text('${movie['audiAcc']}'),
                  Text('${movie['rating']}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
