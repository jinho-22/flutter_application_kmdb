import 'dart:convert';

import 'package:http/http.dart' as http;
// http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=3O0KL1336U86Y73P1712&query=인어공주&detail=Y

class MovieApi {
  final api_key = '3O0KL1336U86Y73P1712';

  Future<List<dynamic>> search(String keyword) async {
    String site =
        'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=$api_key&title=$keyword&detail=Y';
    var response = await http.get(Uri.parse(site));
    if (response.statusCode == 200) {
      var movies =
          jsonDecode(response.body)['Date'][0]['Result'] as List<dynamic>;
      return movies;
    } else {
      return [];
    }
  }
}
