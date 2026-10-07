import 'dart:math';
import '../models/vent.dart';

class VentService {
  // In-memory list for now (we will replace with Firebase/Supabase later)
  static final List<Vent> _vents = [];

  static List<Vent> getVents({String? category}) {
    if (category == null || category == 'All') {
      return List.from(_vents.reversed); // newest first
    }
    return _vents
        .where((v) => v.category == category)
        .toList()
        .reversed
        .toList();
  }

  static void addVent({
    required String content,
    required String category,
    String? nickname,
  }) {
    final vent = Vent(
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(9999).toString(),
      content: content.trim(),
      category: category,
      nickname: nickname?.trim().isEmpty == true ? null : nickname?.trim(),
      createdAt: DateTime.now(),
    );
    _vents.add(vent);
  }

  static void addReaction(String ventId, String reaction) {
    final index = _vents.indexWhere((v) => v.id == ventId);
    if (index == -1) return;

    final vent = _vents[index];
    switch (reaction) {
      case 'heart':
        _vents[index] = Vent(
          id: vent.id,
          content: vent.content,
          category: vent.category,
          nickname: vent.nickname,
          createdAt: vent.createdAt,
          heartCount: vent.heartCount + 1,
          sadCount: vent.sadCount,
          fireCount: vent.fireCount,
          clapCount: vent.clapCount,
          relateCount: vent.relateCount,
        );
        break;
      case 'sad':
        _vents[index] = Vent(
          id: vent.id,
          content: vent.content,
          category: vent.category,
          nickname: vent.nickname,
          createdAt: vent.createdAt,
          heartCount: vent.heartCount,
          sadCount: vent.sadCount + 1,
          fireCount: vent.fireCount,
          clapCount: vent.clapCount,
          relateCount: vent.relateCount,
        );
        break;
      case 'fire':
        _vents[index] = Vent(
          id: vent.id,
          content: vent.content,
          category: vent.category,
          nickname: vent.nickname,
          createdAt: vent.createdAt,
          heartCount: vent.heartCount,
          sadCount: vent.sadCount,
          fireCount: vent.fireCount + 1,
          clapCount: vent.clapCount,
          relateCount: vent.relateCount,
        );
        break;
      case 'clap':
        _vents[index] = Vent(
          id: vent.id,
          content: vent.content,
          category: vent.category,
          nickname: vent.nickname,
          createdAt: vent.createdAt,
          heartCount: vent.heartCount,
          sadCount: vent.sadCount,
          fireCount: vent.fireCount,
          clapCount: vent.clapCount + 1,
          relateCount: vent.relateCount,
        );
        break;
      case 'relate':
        _vents[index] = Vent(
          id: vent.id,
          content: vent.content,
          category: vent.category,
          nickname: vent.nickname,
          createdAt: vent.createdAt,
          heartCount: vent.heartCount,
          sadCount: vent.sadCount,
          fireCount: vent.fireCount,
          clapCount: vent.clapCount,
          relateCount: vent.relateCount + 1,
        );
        break;
    }
  }
}