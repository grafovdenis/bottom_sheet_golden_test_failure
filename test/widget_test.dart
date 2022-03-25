import 'package:bottom_sheet_golden_test_failure/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('MyHomePage golden tests', () {
    const myHomePage = MyHomePage();

    testGoldens('screen renders correctly', (tester) async {
      await tester.pumpWidgetBuilder(myHomePage);

      await multiScreenGolden(tester, 'my_home_page');
    });

    testGoldens('shows bottom sheet', (tester) async {
      await tester.pumpWidgetBuilder(myHomePage);

      await tester.tap(find.text('Open BottomSheet'));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      await multiScreenGolden(tester, 'my_home_page_bottom_sheet');
    });

    testGoldens('shows fixed bottom sheet', (tester) async {
      await tester.pumpWidgetBuilder(myHomePage);

      await tester.tap(find.text('Open fixed BottomSheet'));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      await multiScreenGolden(tester, 'my_home_page_bottom_sheet_fixed');
    });
  });
}
