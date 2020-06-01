import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('\turl: ${data.url}');
    print('\theaders: ${data.headers}');
    print('\tbody: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('\tstatus code: ${data.statusCode}');
    print('\theaders: ${data.headers}');
    print('\tbody: ${data.body}');
    return data;
  }
}