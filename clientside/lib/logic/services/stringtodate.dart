DateTime StringToDate(String fulldate) {
  String dateString = fulldate;
  // Convert the string to DateTime
  DateTime dateTime = DateTime.parse(dateString);
  // Print the resulting DateTime
  return dateTime;
}
