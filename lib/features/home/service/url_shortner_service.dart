import 'package:vrit_project/core/services/dio_services.dart';
import 'package:vrit_project/features/home/model/shortner.dart';

abstract class UrlShortnerService {
  Future<Shortner> shortNewUrl(String url);
}

class UrlShortnerServiceImp implements UrlShortnerService {
  final DioServices dioServices = DioServices();

  @override
  Future<Shortner> shortNewUrl(String url) async {
    final newUrl = url.contains("https://") ? url : "https://$url";
    try {
      final dynamic data =
          await dioServices.postWithAuth("", {"long_url": newUrl});
      return Shortner.fromMap(data);
    } catch (e) {
      rethrow;
    }
  }
}
