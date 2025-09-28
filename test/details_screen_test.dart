import 'package:dave_portfolio/features/detail_view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DetailsScreen has a title and a description', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: DetailsScreen()));

    // Verify that our screen has a title.
    expect(find.text('Hi, this is'), findsOneWidget);
    expect(find.text('Dave.'), findsOneWidget);

    // Verify that our screen has a description.
    expect(find.text('Mobile App developer → Flutter Developer'), findsOneWidget);
  });
}
