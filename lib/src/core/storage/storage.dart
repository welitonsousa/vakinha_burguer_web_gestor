abstract class Storage {
  String getData(String key);
  void setData(String key, String value);
  void clear();
}

class StorageKeys {
  static const ACCESS_TOKEN = '/access_token/';
}
