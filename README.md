# bottom_sheet_golden_test_failure

Project which demostrates [showModalBottomSheet](https://api.flutter.dev/flutter/material/showModalBottomSheet.html) failure during golden tests (using [golden_toolkit](https://pub.dev/packages/golden_toolkit)).

## Usage demo

Let's say, we'd like to display draggable bottom sheet, which height is 200. It's snaps are 0 (closed) and 1 (fully opened).

```dart
    showModalBottomSheet<void>(
      context: context,
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          minChildSize: 0.0,
          initialChildSize: 1.0,
          snap: true,
          snapSizes: const [0.0, 1],
          builder: (context, scrollController) {
            return Container(
              color: Colors.blue,
            );
          },
        );
      },
    );
```

See [entire example](lib/main.dart).

## How to reproduce

Run `flutter test`.

## Failure cause

Seems like `DraggableScrollableSheet`'s `builer` requires scrollable `Widget` with `controller` passed into constructor when it's displayed by `showModalBottomSheet`.

## How to fix

Wrap sheet's content into scrollable widget with `NeverScrollableScrollPhysics`.

```dart
    showModalBottomSheet<void>(
      context: context,
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          minChildSize: 0.0,
          initialChildSize: 1,
          snap: true,
          snapSizes: const [0.0, 1],
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
```

## Stack trace

``` bash
00:03 +1: MyHomePage golden tests shows bottom sheet                                                      
══╡ EXCEPTION CAUGHT BY SCHEDULER LIBRARY ╞═════════════════════════════════════════════════════════
The following assertion was thrown during a scheduler callback:
ScrollController not attached to any scroll views.
'package:flutter/src/widgets/scroll_controller.dart':
Failed assertion: line 107 pos 12: '_positions.isNotEmpty'

Either the assertion indicates an error in the framework itself, or we should provide substantially
more information in this error message to help you determine and fix the underlying cause.
In either case, please report this assertion by filing a bug on GitHub:
  https://github.com/flutter/flutter/issues/new?template=2_bug.md

When the exception was thrown, this was the stack:
#2      ScrollController.position (package:flutter/src/widgets/scroll_controller.dart:107:12)
#3      _DraggableScrollableSheetScrollController.position (package:flutter/src/widgets/draggable_scrollable_sheet.dart:725:13)
#4      _DraggableScrollableSheetState._replaceExtent.<anonymous closure> (package:flutter/src/widgets/draggable_scrollable_sheet.dart:656:27)
#5      SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1144:15)
#6      SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1089:9)
#7      AutomatedTestWidgetsFlutterBinding.pump.<anonymous closure> (package:flutter_test/src/binding.dart:995:9)
#10     TestAsyncUtils.guard (package:flutter_test/src/test_async_utils.dart:71:41)
#11     AutomatedTestWidgetsFlutterBinding.pump (package:flutter_test/src/binding.dart:982:27)
#12     WidgetTester.pump.<anonymous closure> (package:flutter_test/src/widget_tester.dart:608:53)
#15     TestAsyncUtils.guard (package:flutter_test/src/test_async_utils.dart:71:41)
#16     WidgetTester.pump (package:flutter_test/src/widget_tester.dart:608:27)
#17     _twoPumps (package:golden_toolkit/src/multi_screen_golden.dart:18:16)
#18     multiScreenGolden.<anonymous closure> (package:golden_toolkit/src/multi_screen_golden.dart:71:30)
#19     multiScreenGolden.<anonymous closure> (package:golden_toolkit/src/multi_screen_golden.dart:66:13)
#20     WidgetFlutterBindingExtensions.runWithDeviceOverrides (package:golden_toolkit/src/widget_tester_extensions.dart:32:17)
<asynchronous suspension>
<asynchronous suspension>
(elided 7 frames from class _AssertionError, dart:async, and package:stack_trace)
════════════════════════════════════════════════════════════════════════════════════════════════════
══╡ EXCEPTION CAUGHT BY SCHEDULER LIBRARY ╞═════════════════════════════════════════════════════════
The following assertion was thrown during a scheduler callback:
ScrollController not attached to any scroll views.
'package:flutter/src/widgets/scroll_controller.dart':
Failed assertion: line 107 pos 12: '_positions.isNotEmpty'

Either the assertion indicates an error in the framework itself, or we should provide substantially
more information in this error message to help you determine and fix the underlying cause.
In either case, please report this assertion by filing a bug on GitHub:
  https://github.com/flutter/flutter/issues/new?template=2_bug.md

When the exception was thrown, this was the stack:
#2      ScrollController.position (package:flutter/src/widgets/scroll_controller.dart:107:12)
#3      _DraggableScrollableSheetScrollController.position (package:flutter/src/widgets/draggable_scrollable_sheet.dart:725:13)
#4      _DraggableScrollableSheetState._replaceExtent.<anonymous closure> (package:flutter/src/widgets/draggable_scrollable_sheet.dart:656:27)
#5      SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1144:15)
#6      SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1089:9)
#7      AutomatedTestWidgetsFlutterBinding.pump.<anonymous closure> (package:flutter_test/src/binding.dart:995:9)
#10     TestAsyncUtils.guard (package:flutter_test/src/test_async_utils.dart:71:41)
#11     AutomatedTestWidgetsFlutterBinding.pump (package:flutter_test/src/binding.dart:982:27)
#12     WidgetTester.pump.<anonymous closure> (package:flutter_test/src/widget_tester.dart:608:53)
#15     TestAsyncUtils.guard (package:flutter_test/src/test_async_utils.dart:71:41)
#16     WidgetTester.pump (package:flutter_test/src/widget_tester.dart:608:27)
#17     _twoPumps (package:golden_toolkit/src/multi_screen_golden.dart:18:16)
#18     multiScreenGolden.<anonymous closure> (package:golden_toolkit/src/multi_screen_golden.dart:71:30)
#19     multiScreenGolden.<anonymous closure> (package:golden_toolkit/src/multi_screen_golden.dart:66:13)
#20     WidgetFlutterBindingExtensions.runWithDeviceOverrides (package:golden_toolkit/src/widget_tester_extensions.dart:32:17)
<asynchronous suspension>
<asynchronous suspension>
(elided 7 frames from class _AssertionError, dart:async, and package:stack_trace)
════════════════════════════════════════════════════════════════════════════════════════════════════
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following message was thrown:
Multiple exceptions (2) were detected during the running of the current test, and at least one was
unexpected.
════════════════════════════════════════════════════════════════════════════════════════════════════
00:03 +1 -1: MyHomePage golden tests shows bottom sheet [E]                                               
  Test failed. See exception logs above.
  The test description was: shows bottom sheet
  
00:04 +2 -1: Some tests failed.
```
