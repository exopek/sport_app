class StoragePath {
  static String profilImage(String uid) => 'profilImage/$uid';
}


class CloudPath {
  static String setfavorite(String uid, String id) => 'users/$uid/favorites/$id';
  static String getfavorite(String uid) => 'users/$uid/favorites/';
}