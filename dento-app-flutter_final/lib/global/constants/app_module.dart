import '../../main.dart';
import '../widgets/custom_dialogs.dart';

void setUp() {
  getIt.registerSingleton<CustomDialogs>(CustomDialogs());
}
