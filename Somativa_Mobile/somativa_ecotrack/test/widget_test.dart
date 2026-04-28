import 'package:flutter_test/flutter_test.dart';
import 'package:somativa_ecotrack/main.dart';

void main() {
  testWidgets('carrega tela inicial do EcoTrack', (WidgetTester tester) async {
    await tester.pumpWidget(const EcoTrackApp());

    expect(find.text('EcoTrack'), findsWidgets);
    expect(
      find.textContaining('Acompanhe seus habitos sustentaveis'),
      findsOneWidget,
    );
  });
}
