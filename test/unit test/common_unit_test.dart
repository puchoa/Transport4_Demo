import 'package:flutter_test/flutter_test.dart';
import 'package:transport4_demo_app/common.dart';

void main() {
  group('Common Functions', () {
    test('formatText removes special characters', () {
      expect(formatText('Hello @world!'), equals('Hello world'));
      expect(formatText('H%el*lo @wor#~ld!'), equals('Hello world'));
      expect(formatText("!@#%^&*()-_=+[]{}|;:'\",.<>?/"), equals(''));
    });

    test('convertCalories returns formatted string', () {
      expect(convertCalories(150.5), equals('151 kcal'));
      expect(convertCalories(150), equals('150 kcal'));
      expect(convertCalories(150.1), equals('151 kcal'));
    });

    test('convertCookTime returns formatted string', () {
      expect(convertCookTime(30.75), equals('31 mins'));
      expect(convertCookTime(31.001), equals('32 mins'));
      expect(convertCookTime(3), equals('3 mins'));
    });

    test('convertServings returns formatted string', () {
      expect(convertServings(4.2), equals('5'));
      expect(convertServings(0), equals('0'));
      expect(convertServings(-2.001), equals('-2'));
    });
  });
}
