import 'package:flutter/material.dart';
import '../models/vent.dart';
import '../theme/app_theme.dart';
import '../services/vent_service.dart';

class VentCard extends StatefulWidget {
  final Vent vent;
  final VoidCallback onReaction;

  const VentCard({
    super.key,
    required this.vent,
    required this.onReaction,
  });

  @override
  State<VentCard> createState() => _VentCardState();
}

class _VentCardState extends State<VentCard> {
  void _react(String type) {
    VentService.addReaction(widget.vent.id, type);
    widget.onReaction();
  }

  @override
  Widget build(BuildContext context) {
    final vent = widget.vent;
    final timeAgo = _timeAgo(vent.createdAt);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                vent.nickname ?? 'Anonymous',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                timeAgo,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Category chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              vent.category,
              style: const TextStyle(
                color: AppTheme.primary,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Content
          Text(
            vent.content,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          // Reactions
          Row(
            children: [
              _ReactionButton(
                emoji: '❤️',
                count: vent.heartCount,
                onTap: () => _react('heart'),
              ),
              _ReactionButton(
                emoji: '😢',
                count: vent.sadCount,
                onTap: () => _react('sad'),
              ),
              _ReactionButton(
                emoji: '🔥',
                count: vent.fireCount,
                onTap: () => _react('fire'),
              ),
              _ReactionButton(
                emoji: '👏',
                count: vent.clapCount,
                onTap: () => _react('clap'),
              ),
              _ReactionButton(
                emoji: '🫂',
                count: vent.relateCount,
                label: 'I relate',
                onTap: () => _react('relate'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}

class _ReactionButton extends StatelessWidget {
  final String emoji;
  final int count;
  final String? label;
  final VoidCallback onTap;

  const _ReactionButton({
    required this.emoji,
    required this.count,
    this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
            if (label != null) ...[
              const SizedBox(width: 4),
              Text(
                label!,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}