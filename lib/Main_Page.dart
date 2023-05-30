import 'package:flutter/material.dart';
import 'package:flutter_application_kmdb/movie_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var controller = TextEditingController();

  void searchMovie(String keyword) {
    MovieApi movieApi = MovieApi();
    movieApi.search(keyword);
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
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: 200,
              child: Column(
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('닫기')),
                  TextFormField(
                    controller: controller,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        searchMovie(controller.text);
                        Navigator.pop(context);
                      },
                      child: const Text('검색하기'))
                ],
              ),
            ));
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: null,
      floatingActionButton: FloatingActionButton(
        onPressed: showSearchPage,
        child: const Icon(Icons.search),
      ),
    );
  }
}
