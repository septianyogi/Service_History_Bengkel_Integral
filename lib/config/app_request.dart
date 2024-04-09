class AppRequest {
  static Map<String,String> header([String? bearerToken]){
    if(bearerToken == null) {
      return {
        "Accept" : "Application/json"
      };
    } else {
      return {
        "Accept" : "Application/json",
        "Authorization" : "Bearer $bearerToken"
      };
    }
  }
}