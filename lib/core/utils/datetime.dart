import 'dart:ffi';
import 'dart:math' as math;

const List<String> tuan = <String>[
  'Chủ Nhật',
  'Thứ Hai',
  'Thứ Ba',
  'Thứ Tư',
  'Thứ Năm',
  'Thứ Sáu',
  'Thứ Bảy'
];
const List<String> thang = <String>[
  'Giêng',
  'Hai',
  'Ba',
  'Tư',
  'Năm',
  'Sáu',
  'Bảy',
  'Tám',
  'Chín',
  'Mười',
  'Một',
  'Chạp'
];
const List<String> can = <String>[
  'Giáp',
  'Ất',
  'Bính',
  'Đinh',
  'Mậu',
  'Kỷ',
  'Canh',
  'Tân',
  'Nhâm',
  'Quý'
];
const List<String> chi = <String>[
  'Tý',
  'Sửu',
  'Dần',
  'Mão',
  'Thìn',
  'Tỵ',
  'Ngọ',
  'Mùi',
  'Thân',
  'Dậu',
  'Tuất',
  'Hợi'
];

const List<String> gioHd = <String>[
  '110100101100',
  '001101001011',
  '110011010010',
  '101100110100',
  '001011001101',
  '010010110011'
];

const List<String> tietkhi = <String>[
  'Xuân phân',
  'Thanh minh',
  'Cốc vũ',
  'Lập hạ',
  'Tiểu mãn',
  'Mang chủng',
  'Hạ chí',
  'Tiểu thử',
  'Đại thử',
  'Lập thu',
  'Xử thử',
  'Bạch lộ',
  'Thu phân',
  'Hàn lộ',
  'Sương giáng',
  'Lập đông',
  'Tiểu tuyết',
  'Đại tuyết',
  'Đông chí',
  'Tiểu hàn',
  'Đại hàn',
  'Lập xuân',
  'Vũ Thủy',
  'Kinh trập'
];

/* Discard the fractional part of a number, e.g., integer(3.2) = 3 */
int integer(double d) {
  return d.floor();
}

class YearlyEvent {
  final int dd;
  final int mm;
  final String info;
  YearlyEvent({
    required this.dd,
    required this.mm,
    required this.info,
  });
}

List<YearlyEvent> yearlyEvent = [
  YearlyEvent(dd: 1, mm: 1, info: 'Tết Nguyên Đán'),
  YearlyEvent(dd: 15, mm: 1, info: 'Rằm tháng Giêng'),
  YearlyEvent(dd: 10, mm: 3, info: 'Giỗ Tổ Hùng Vương (10/3 ÂL)'),
  YearlyEvent(dd: 15, mm: 4, info: 'Phật Đản (15/4 ÂL)'),
  YearlyEvent(dd: 5, mm: 5, info: 'Lễ Đoan Ngọ (5/5 ÂL)'),
  YearlyEvent(dd: 15, mm: 7, info: 'Vu Lan (15/7 ÂL)'),
  YearlyEvent(dd: 15, mm: 8, info: 'Tết Trung Thu (Rằm tháng 8)'),
  YearlyEvent(dd: 23, mm: 12, info: 'Ông Táo chầu trời (23/12 ÂL)'),
];

List findEvents(int dd, int mm) {
  var ret = [];
  for (var i = 0; i < yearlyEvent.length; i++) {
    var evt = yearlyEvent[i];
    if (evt.dd == dd && evt.mm == mm) {
      ret.add(evt);
    }
  }
  return ret;
}

String getDayInfo(int dd, int mm) {
  var events = findEvents(dd, mm);
  var ret = '';
  for (var i = 0; i < events.length; i++) {
    ret += events[i].info + ' ';
  }
  return ret;
}

String getDayOfWeek(int jd) {
  return tuan[(jd + 1) % 7];
}

String isLeapYear(int leap) {
  return leap == 0 ? '' : ' Nhuận';
}

String getMonthName(int mm, int length, int leap) {
  return ('Tháng ${thang[mm - 1]}${isLeapYear(leap)}${length == 30 ? ' (Đ)' : ' (T)'}');
}

String getYearCanChi(int year) {
  return '${can[(year + 6) % 10]} ${chi[(year + 8) % 12]}';
}

String getMonthCanChi(int mm, int yy) {
  return '${'Tháng ${can[(yy * 12 + mm + 3) % 10]}'} ${chi[(mm + 1) % 12]}';
}

String getDayCanChi(int jd) {
  return '${'Ngày ${can[(jd + 9) % 10]}'} ${chi[(jd + 1) % 12]}';
}

String getHourCanChi(int jd) {
  return '${'Giờ ${can[((jd - 1) * 2) % 10]}'} ${chi[0]}';
}

String getTietKhi(int jd) {
  return 'Tiết ${tietkhi[getSolarTerm(jd + 1, 7.0)]}';
}

String getGioHoangDao(int jd) {
  var chiOfDay = (jd + 1) % 12;
  var gioHD = gioHd[chiOfDay %
      6]; // same values for Ty' (1) and Ngo. (6), for Suu and Mui etc.
  var ret = '';
  var count = 0;
  for (var i = 0; i < 12; i++) {
    if (gioHD[i] == '1') {
      ret += chi[i];
      ret += ' (${((i * 2 + 23) % 24)}-${((i * 2 + 1) % 24)})';
      if (count++ < 5) ret += ', ';
      //if (count == 3) ret += '\n';
    }
  }
  return 'Giờ hoàng đạo: $ret';
}

/* Compute the (integral) Julian day number of day dd/mm/yyyy, i.e., the number
 * of days between 1/1/4713 BC (Julian calendar) and dd/mm/yyyy.
 * Formula from http://www.tondering.dk/claus/calendar.html
 */
int jdFromDate(int dd, int mm, int yy) {
  int a, y, m, jd;
  a = integer(((14 - mm) / 12));
  y = yy + 4800 - a;
  m = mm + 12 * a - 3;
  jd = dd +
      integer(((153 * m + 2) / 5)) +
      365 * y +
      integer((y / 4)) -
      integer((y / 100)) +
      integer((y / 400)) -
      32045;
  if (jd < 2299161) {
    jd = dd + integer(((153 * m + 2) / 5)) + 365 * y + integer(y / 4) - 32083;
  }
  return jd;
}

/* Convert a Julian day number to day/month/year. Parameter jd is an integer */
Array jdToDate(jd) {
  int a, b, c, d, e, m, day, month, year;
  if (jd > 2299160) {
    // After 5/10/1582, Gregorian calendar
    a = jd + 32044;
    b = integer((4 * a + 3) / 146097);
    c = a - integer((b * 146097) / 4);
  } else {
    b = 0;
    c = jd + 32082;
  }
  d = integer((4 * c + 3) / 1461);
  e = c - integer((1461 * d) / 4);
  m = integer((5 * e + 2) / 153);
  day = e - integer((153 * m + 2) / 5) + 1;
  month = m + 3 - 12 * integer(m / 10);
  year = b * 100 + d - 4800 + integer(m / 10);
  return Array(day, month, year);
}

/* Compute the time of the k-th new moon after the new moon of 1/1/1900 13:52 UCT
 * (measured as the number of days since 1/1/4713 BC noon UCT, e.g., 2451545.125 is 1/1/2000 15:00 UTC).
 * Returns a floating number, e.g., 2415079.9758617813 for k=2 or 2414961.935157746 for k=-2
 * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
 */
dynamic newMoon(k) {
  dynamic T, t2, t3, dr, jd1, M, mpr, F, c1, deltat, jdNew;
  T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
  t2 = T * T;
  t3 = t2 * T;
  dr = math.pi / 180;
  jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * t2 - 0.000000155 * t3;
  jd1 = jd1 +
      0.00033 *
          math.sin((166.56 + 132.87 * T - 0.009173 * t2) * dr); // Mean new moon
  M = 359.2242 +
      29.10535608 * k -
      0.0000333 * t2 -
      0.00000347 * t3; // Sun's mean anomaly
  mpr = 306.0253 +
      385.81691806 * k +
      0.0107306 * t2 +
      0.00001236 * t3; // Moon's mean anomaly
  F = 21.2964 +
      390.67050646 * k -
      0.0016528 * t2 -
      0.00000239 * t3; // Moon's argument of latitude
  c1 = (0.1734 - 0.000393 * T) * math.sin(M * dr) +
      0.0021 * math.sin(2 * dr * M);
  c1 = c1 - 0.4068 * math.sin(mpr * dr) + 0.0161 * math.sin(dr * 2 * mpr);
  c1 = c1 - 0.0004 * math.sin(dr * 3 * mpr);
  c1 = c1 + 0.0104 * math.sin(dr * 2 * F) - 0.0051 * math.sin(dr * (M + mpr));
  c1 = c1 -
      0.0074 * math.sin(dr * (M - mpr)) +
      0.0004 * math.sin(dr * (2 * F + M));
  c1 = c1 -
      0.0004 * math.sin(dr * (2 * F - M)) -
      0.0006 * math.sin(dr * (2 * F + mpr));
  c1 = c1 +
      0.001 * math.sin(dr * (2 * F - mpr)) +
      0.0005 * math.sin(dr * (2 * mpr + M));
  if (T < -11) {
    deltat = 0.001 +
        0.000839 * T +
        0.0002261 * t2 -
        0.00000845 * t3 -
        0.000000081 * T * t3;
  } else {
    deltat = -0.000278 + 0.000265 * T + 0.000262 * t2;
  }
  jdNew = jd1 + c1 - deltat;
  return jdNew;
}

/* Compute the longitude of the sun at any time.
 * Parameter: floating number jdn, the number of days since 1/1/4713 BC noon
 * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
 */
dynamic sunLongitude(jdn) {
  dynamic T, t2, dr, M, l0, dl, L;
  T = (jdn - 2451545.0) /
      36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
  t2 = T * T;
  dr = math.pi / 180; // degree to radian
  M = 357.5291 +
      35999.0503 * T -
      0.0001559 * t2 -
      0.00000048 * T * t2; // mean anomaly, degree
  l0 = 280.46645 + 36000.76983 * T + 0.0003032 * t2; // mean longitude, degree
  dl = (1.9146 - 0.004817 * T - 0.000014 * t2) * math.sin(dr * M);
  dl = dl +
      (0.019993 - 0.000101 * T) * math.sin(dr * 2 * M) +
      0.00029 * math.sin(dr * 3 * M);
  L = l0 + dl; // true longitude, degree
  L = L * dr;
  L = L -
      math.pi * 2 * integer(L / (math.pi * 2)); // Normalize to (0, 2*math.pi)
  return L;
}

/* Compute the longitude of the sun at any time.
 * Parameter: floating number jdn, the number of days since 1/1/4713 BC noon
 * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
 */
dynamic sunLongitude2(jdn) {
  dynamic T, t2, dr, M, l0, dl, lambda, theta, omega;
  T = (jdn - 2451545.0) /
      36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
  t2 = T * T;
  dr = math.pi / 180; // degree to radian
  M = 357.5291 +
      35999.0503 * T -
      0.0001559 * t2 -
      0.00000048 * T * t2; // mean anomaly, degree
  l0 = 280.46645 + 36000.76983 * T + 0.0003032 * t2; // mean longitude, degree
  dl = (1.9146 - 0.004817 * T - 0.000014 * t2) * math.sin(dr * M);
  dl = dl +
      (0.019993 - 0.000101 * T) * math.sin(dr * 2 * M) +
      0.00029 * math.sin(dr * 3 * M);
  theta = l0 + dl; // true longitude, degree
  // obtain apparent longitude by correcting for nutation and aberration
  omega = 125.04 - 1934.136 * T;
  lambda = theta - 0.00569 - 0.00478 * math.sin(omega * dr);
  // Convert to radians
  lambda = lambda * dr;
  lambda = lambda -
      math.pi *
          2 *
          integer(lambda / (math.pi * 2)); // Normalize to (0, 2*math.pi)
  return lambda;
}

/* Compute sun position at midnight of the day with the given Julian day number.
 * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
 * The function returns a number between 0 and 11.
 * From the day after March equinox and the 1st major term after March equinox, 0 is returned.
 * After that, return 1, 2, 3 ...
 */
int getSunLongitude(dayNumber, timeZone) {
  return integer((sunLongitude(dayNumber - 0.5 - timeZone / 24) / math.pi) * 6);
}

/* Compute the day of the k-th new moon in the given time zone.
 * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00
 */
int getNewMoonDay(k, timeZone) {
  return integer(newMoon(k) + 0.5 + timeZone / 24);
}

/* Find the day that starts the luner month 11 of the given year for the given time zone */
int getLunarMonth11(yy, timeZone) {
  dynamic k, off, nm, sunLong;
  //off = jdFromDate(31, 12, yy) - 2415021.076998695;
  off = jdFromDate(31, 12, yy) - 2415021;
  k = integer(off / 29.530588853);
  nm = getNewMoonDay(k, timeZone);
  sunLong = getSunLongitude(nm, timeZone); // sun longitude at local midnight
  if (sunLong >= 9) {
    nm = getNewMoonDay(k - 1, timeZone);
  }
  return nm;
}

/* Find the index of the leap month after the month starting on the day a11. */
int getLeapMonthOffset(a11, timeZone) {
  dynamic k, last, arc, i;
  k = integer((a11 - 2415021.076998695) / 29.530588853 + 0.5);
  last = 0;
  i = 1; // We start with the month following lunar month 11
  arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
  do {
    last = arc;
    i++;
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
  } while (arc != last && i < 14);
  return i - 1;
}

/* Comvert solar date dd/mm/yyyy to the corresponding lunar date */
List<int> convertSolar2Lunar(int dd, int mm, int yy, double timeZone) {
  int k,
      dayNumber,
      monthStart,
      a11,
      b11,
      lunarDay,
      lunarMonth,
      lunarYear,
      diff,
      leapMonthDiff,
      lunarLeap;
  dayNumber = jdFromDate(dd, mm, yy);
  k = integer((dayNumber - 2415021.076998695) / 29.530588853);
  monthStart = getNewMoonDay(k + 1, timeZone);
  if (monthStart > dayNumber) {
    monthStart = getNewMoonDay(k, timeZone);
  }
  a11 = getLunarMonth11(yy, timeZone);
  b11 = a11;
  if (a11 >= monthStart) {
    lunarYear = yy;
    a11 = getLunarMonth11(yy - 1, timeZone);
  } else {
    lunarYear = yy + 1;
    b11 = getLunarMonth11(yy + 1, timeZone);
  }
  lunarDay = dayNumber - monthStart + 1;
  diff = integer((monthStart - a11) / 29);
  lunarLeap = 0;
  lunarMonth = diff + 11;
  if (b11 - a11 > 365) {
    leapMonthDiff = getLeapMonthOffset(a11, timeZone);
    if (diff >= leapMonthDiff) {
      lunarMonth = diff + 10;
      if (diff == leapMonthDiff) {
        lunarLeap = 1;
      }
    }
  }
  if (lunarMonth > 12) {
    lunarMonth = lunarMonth - 12;
  }
  if (lunarMonth >= 11 && diff < 4) {
    lunarYear -= 1;
  }
  List<int> value = [];
  value.add(lunarDay);
  value.add(lunarMonth);
  value.add(lunarYear);
  value.add(lunarLeap);
  return value;
}

/* Convert a lunar date to the corresponding solar date */
Array convertLunar2Solar(lunarDay, lunarMonth, lunarYear, lunarLeap, timeZone) {
  dynamic k, a11, b11, off, leapOff, leapMonth, monthStart;
  if (lunarMonth < 11) {
    a11 = getLunarMonth11(lunarYear - 1, timeZone);
    b11 = getLunarMonth11(lunarYear, timeZone);
  } else {
    a11 = getLunarMonth11(lunarYear, timeZone);
    b11 = getLunarMonth11(lunarYear + 1, timeZone);
  }
  k = integer(0.5 + (a11 - 2415021.076998695) / 29.530588853);
  off = lunarMonth - 11;
  if (off < 0) {
    off += 12;
  }
  if (b11 - a11 > 365) {
    leapOff = getLeapMonthOffset(a11, timeZone);
    leapMonth = leapOff - 2;
    if (leapMonth < 0) {
      leapMonth += 12;
    }
    if (lunarLeap != 0 && lunarMonth != leapMonth) {
      return const Array(0, 0, 0);
    } else if (lunarLeap != 0 || off >= leapOff) {
      off += 1;
    }
  }
  monthStart = getNewMoonDay(k + off, timeZone);
  return jdToDate(monthStart + lunarDay - 1);
}

/* Compute the sun segment at start (00:00) of the day with the given integral Julian day number.
 * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
 * The function returns a number between 0 and 23.
 * From the day after March equinox and the 1st major term after March equinox, 0 is returned.
 * After that, return 1, 2, 3 ...
 */
int getSolarTerm(dayNumber, timeZone) {
  return integer(
      (sunLongitude(dayNumber - 0.5 - timeZone / 24.0) / math.pi) * 12);
}
