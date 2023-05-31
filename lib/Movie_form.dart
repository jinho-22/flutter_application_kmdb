import 'package:flutter/material.dart';

class MovieForm extends StatelessWidget {
  Map<String, dynamic> movie;

  MovieForm({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var directorNm = movie['directors']['director'][0]['directorNm'];
    var posters = movie['posters'].split('||')[0];
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 100,
            child: Image.network(posters),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${movie['title']}(${movie['prodYear']})',
                style: const TextStyle(fontSize: 20),
              ),
              Text('$directorNm/${movie['actorNm']}'),
              Text('${movie['repRlsDate']}'),
              Text('${movie['audiAcc']}'),
              Text('${movie['rating']}')
            ],
          ))
        ],
      ),
    );
  }
}
