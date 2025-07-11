class ApiUrls {
  static const baseURL = 'https://api3.made2tech.com/api/v1';

  // Auth URLs
  static const register = '/auth/register/';
  static const login = '/auth/login/';
  static const logout = '/auth/logut/';
  static const refreshToken = '/auth/refresh/';
  static const updateFcmToken = "/user/fbs_token/";

  // User URLs
  static const getCurrentUser = '/auth/me/';

  // Collection URLs
  static const getAllCollections = '/collections/';
  static const getMyCollections = '/user-collections/my-collections/';
  static addUserToCollection(String collectionId) =>
      '/collections/$collectionId/users';
}
