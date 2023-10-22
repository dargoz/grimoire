
import 'package:flutter_riverpod/flutter_riverpod.dart';


final sectionStateNotifierProvider = StateNotifierProvider<
    SectionController,
    int?>((ref) => SectionController(ref));

class SectionController
    extends StateNotifier<int?> {

  SectionController(Ref ref) : super(null);

  Future setActiveSection(int? index) async {
    state = index;
  }
}
