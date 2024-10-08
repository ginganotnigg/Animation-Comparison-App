import 'package:animation_app/screen/complex_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animation_app/main.dart';

void main() {
  testWidgets('BottomNavigationBar changes screen on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Complex Loading Comparison'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.motion_photos_auto_outlined));
    await tester.pump();

    expect(find.text('Complex Loading Comparison'), findsNothing);
  });

  testWidgets('FloatingActionButton toggles animation type',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.byIcon(Icons.animation), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.byIcon(Icons.extension), findsOneWidget);
  });

  testWidgets('Tapping the TrailerButton navigates to TrailerScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ComplexLoadingScreen(useBuiltIn: false),
    ));

    // Find the button to navigate to the trailer and tap it
    final trailerButton = find.text('Watch Trailer');
    expect(trailerButton, findsOneWidget);
    await tester.tap(trailerButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Trailer Loaded!'), findsOneWidget);
  });

  testWidgets('Tapping the TrailerButton navigates to TrailerScreen (built-in)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ComplexLoadingScreen(useBuiltIn: true),
    ));

    // Find the button to navigate to the trailer and tap it
    final trailerButton = find.text('Watch Trailer');
    expect(trailerButton, findsOneWidget);
    await tester.tap(trailerButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Trailer Loaded!'), findsOneWidget);
  });
}
