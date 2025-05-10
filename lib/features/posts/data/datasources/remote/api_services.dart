import 'package:http/http.dart' as http;
class ApiServices{
final http.Client client;

  ApiServices({required this.client});

     get({required String url,required String endPoint})async{
       await client.get(Uri.parse(url+ "/$endPoint/"),
           headers:{'Content-type': 'application/json'} );
     }
}