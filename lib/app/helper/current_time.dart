import 'package:http/http.dart' as http;
import 'dart:convert';

Future<DateTime> fetchInternetTime() async {
  final response = await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final dateTime =
        DateTime.parse(data['datetime']).toLocal(); // Convert to local time
    return dateTime;
  } else {
    throw Exception('Failed to fetch internet time');
  }
}

void getTime() async {
  try {
    final currentTime = await fetchInternetTime();
    print('Current Time: $currentTime');
    // Do something with the current time
  } catch (e) {
    print('Error: $e');
    // Handle the error
  }
}
