import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

final _appstate = getIt.get<AppState>();

class DataCommons {
  // ignore: non_constant_identifier_names
  static final String base_url = "http://13.58.220.136:4001/api";
  static const Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  static Map<String, String> authHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer " + _appstate.state.token
      };
  static Map<String, String> formDataAuthHeader = {
    'Authorization': "Bearer " + _appstate.state.token
  };
}
