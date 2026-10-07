class Vent {
  final String id;
  final String content;
  final String category;          // Work, Relationships, Mental health, Random
  final String? nickname;         // null = fully anonymous
  final DateTime createdAt;
  final int heartCount;
  final int sadCount;
  final int fireCount;
  final int clapCount;
  final int relateCount;

  Vent({
    required this.id,
    required this.content,
    required this.category,
    this.nickname,
    required this.createdAt,
    this.heartCount = 0,
    this.sadCount = 0,
    this.fireCount = 0,
    this.clapCount = 0,
    this.relateCount = 0,
  });

  // Helper for temporary local storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'category': category,
      'nickname': nickname,
      'createdAt': createdAt.toIso8601String(),
      'heartCount': heartCount,
      'sadCount': sadCount,
      'fireCount': fireCount,
      'clapCount': clapCount,
      'relateCount': relateCount,
    };
  }

  factory Vent.fromMap(Map<String, dynamic> map) {
    return Vent(
      id: map['id'],
      content: map['content'],
      category: map['category'],
      nickname: map['nickname'],
      createdAt: DateTime.parse(map['createdAt']),
      heartCount: map['heartCount'] ?? 0,
      sadCount: map['sadCount'] ?? 0,
      fireCount: map['fireCount'] ?? 0,
      clapCount: map['clapCount'] ?? 0,
      relateCount: map['relateCount'] ?? 0,
    );
  }
}