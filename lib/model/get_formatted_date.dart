String getFormattedDate(DateTime dateTime) {
  String formattedDate;
  String dayOfWeek = getDayOfWeek(dateTime);
  String day = dateTime.day.toString();
  String month = getMonth(dateTime);
  String year = dateTime.year.toString();

  formattedDate = '$dayOfWeek, $month $day, $year';

  return formattedDate;
}

String getMonth(DateTime dateTime){
    int month = dateTime.month;
    switch (month) {
      case 1 : return 'January';

      case 2 : return 'February';

      case 3 : return 'March';

      case 4 : return 'April';

      case 5 : return 'May';

      case 6 : return 'June';
      
      case 7 : return 'July';
      
      case 8 : return 'August';
      
      case 9 : return 'September';
      
      case 10 : return 'October';
      
      case 11 : return 'November';
      
      case 12 : return 'December';
        
        break;
    }
    return 'January';
}

String getDayOfWeek(DateTime dateTime){
    int month = dateTime.weekday;
    switch (month) {
      case 1 : return 'Monday';

      case 2 : return 'Tuesday';

      case 3 : return 'Wednesday';

      case 4 : return 'Thursday';

      case 5 : return 'Friday';

        break;
    }
    return 'Friday';
}
