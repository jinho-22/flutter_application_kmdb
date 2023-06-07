import 'package:flutter/material.dart';
import 'package:flutter_application_kmdb/movie_api.dart';
import 'package:flutter_application_kmdb/movie_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var controller = TextEditingController();
  dynamic body = const Center(
      child: Text(
    '검색검색',
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
  ));

  void searchMovie(String keyword) async {
    MovieApi movieApi = MovieApi();
    var movies = movieApi.search(keyword);

    setState(() {
      body = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movieData = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  return MovieForm(movie: movieData[index]);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: movieData!.length);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );

      // body = ListView.separated(
      //     itemBuilder: (context, index) {
      //       return MovieForm(movie: movies[index]);
      //     },
      //     separatorBuilder: (context, index) => const Divider(),
      //     itemCount: movies.length);
    });
  }

  void showSearchPage() async {
    var result = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                label: const Text('닫기')), // 닫기 창
            TextFormField(
              controller: controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      searchMovie(controller.text);
                      Navigator.pop(context);
                    },
                    child: const Text('검색하기')),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showSearchPage,
        child: const Icon(Icons.search),
      ),
    );
  }
}
