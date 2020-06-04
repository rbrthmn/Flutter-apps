import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtubefavorites/models/video.dart';

const API_KEY = 'AIzaSyB4gH23lny5x2YKZdA1LxiYv0dQfol-Pvc';

class Api {
  search(String search) async {
    http.Response response = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if(response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}