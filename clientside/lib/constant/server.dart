class ServerUrl {
  static String ipOnly = "10.0.2.2";
  static String ipaddress() {
    return "http://$ipOnly:3300/";
  }

  static String websocketIp() {
    return "ws://$ipOnly:8000";
  }
}
