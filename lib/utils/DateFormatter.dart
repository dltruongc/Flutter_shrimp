class DateFormatter {
  static String toDMY(DateTime date) {
    return '${date.day} ${date.month} ${date.year}';
  }

  static String toVietNamString(DateTime date) {
    return 'ngày ${date.day} tháng ${date.month}, ${date.year}';
  }
}
