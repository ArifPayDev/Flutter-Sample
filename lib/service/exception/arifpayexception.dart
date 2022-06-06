class ArifpayException implements Exception {
  String msg;
  int errorCode;

  ArifpayException(this.msg, this.errorCode);
}
