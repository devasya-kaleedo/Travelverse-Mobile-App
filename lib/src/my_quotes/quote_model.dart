class QuoteApp {
  int id;
  String country;
  Map<String, dynamic> quote;

  QuoteApp(this.id, this.country, this.quote);

  static QuoteApp fromStrapiResponse(Map<String, dynamic> data) {
    Map<String, dynamic> quoteRes = data['attributes']['quote']['data'];
    Map<String, dynamic> quoteFile = <String, dynamic>{};
    quoteFile['id'] = quoteRes['id'];
    quoteFile['name'] = quoteRes['attributes']['name'];
    quoteFile['ext'] = quoteRes['attributes']['ext'];
    quoteFile['url'] = quoteRes['attributes']['url'];
    return QuoteApp(data['id'], data['attributes']['country'], quoteFile);
  }
}
