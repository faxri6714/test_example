class DateTimeHelper{
  static int differenceInSeconds (DateTime one , DateTime two){
    return one.difference(two).inSeconds;
  }
}