import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/models/project.dart';
import 'package:portfolio_flutter/widgets/project_card.dart';

void main() {
  test('Sample projects contain InnoTrip B2C with App Store and Play Store links', () {
    final innoTrip = Project.sampleProjects.firstWhere(
      (p) => p.title == 'InnoTrip B2C',
    );
    expect(innoTrip.appStoreLink, 'https://apps.apple.com/us/app/innotrip-b2c/id6793119243');
    expect(innoTrip.playStoreLink, 'https://play.google.com/store/apps/details?id=com.innotrip.app&hl=en');
    expect(innoTrip.category, 'Mobile');
  });

  testWidgets('ProjectCard renders project title and highlights', (WidgetTester tester) async {
    final testProject = Project.sampleProjects.first;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            height: 550,
            child: ProjectCard(project: testProject),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(testProject.title), findsOneWidget);
    expect(find.text('KEY HIGHLIGHTS'), findsOneWidget);
  });
}
