import 'package:date_format/date_format.dart';

class TimeFormat {
  const TimeFormat._();

  ///[时间戳转换年月日]
  static dateFormat(createtime) {
    if (createtime == 0) {
      return '';
    }
    var time = createtime * 1000;
    return formatDate(
        DateTime.fromMillisecondsSinceEpoch(time), [yyyy, '-', mm, '-', dd]);
  }

  ///[时间戳转换年月日]
  static dateMmFormat(createtime) {
    if (createtime == 0) {
      return '';
    }
    var time = createtime * 1000;
    return formatDate(DateTime.fromMillisecondsSinceEpoch(time), [mm, '-', dd]);
  }

  static dateFormatMMDD(createtime) {
    if (createtime == null) return '';
    if (createtime == 0) {
      return '';
    }
    var time = createtime * 1000;

    return formatDate(DateTime.fromMillisecondsSinceEpoch(time),
        [mm, '月', dd, '日 ', HH, ':', nn]);
  }
}
