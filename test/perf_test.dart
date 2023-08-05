import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_app/main.dart';

void main() {
  group("Testing App Performance", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    testWidgets("Test Scrolling Performance", (widgetTester) async {
      await widgetTester.pumpWidget(const TestingApp());
      final listFinder = find.byType(ListView);
      await binding.traceAction(() async {
        await widgetTester.fling(listFinder, const Offset(0, -500), 10000);
        await widgetTester.pumpAndSettle();
        await widgetTester.fling(listFinder, const Offset(0, 500), 10000);
        await widgetTester.pumpAndSettle();
      }, reportKey: "Scrolling_Summary");
    });
  });
}
