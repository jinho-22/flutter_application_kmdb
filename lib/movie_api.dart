//http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=4KRO058M6TX83PY84AEE&query=인어공주&detail=Y
import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieApi {
  final api_key = '4KRO058M6TX83PY84AEE';

  Future<List<dynamic>> search(String keyword) async {
    String site =
        'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=$api_key&title=$keyword&detail=Y';
    var response = await http.get(Uri.parse(site));
    if (response.statusCode == 200) {
      var movies =
          jsonDecode(response.body)['Data'][0]['Result'] as List<dynamic>;
      return movies;
    } else {
      return [];
    }
  }
}
