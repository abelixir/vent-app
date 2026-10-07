import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/vent_service.dart';

class CreateVentScreen extends StatefulWidget {
  const CreateVentScreen({super.key});

  @override
  State<CreateVentScreen> createState() => _CreateVentScreenState();
}

class _CreateVentScreenState extends State<CreateVentScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  String selectedCategory = 'Random';
  bool isPosting = false;

  final List<String> categories = [
    'Work',
    'Relationships',
    'Mental health',
    'Random',
  ];

  @override
  void dispose() {
    _contentController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _postVent() {
    final content = _contentController.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something')),
      );
      return;
    }

    setState(() => isPosting = true);

    VentService.addVent(
      content: content,
      category: selectedCategory,
      nickname: _nicknameController.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Share a vent'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: isPosting ? null : _postVent,
            child: isPosting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Post',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nickname (optional)
            const Text(
              'Nickname (optional)',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nicknameController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'Leave empty for fully anonymous',
                hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.6)),
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Category
            const Text(
              'Category',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() => selectedCategory = cat);
                  },
                  selectedColor: AppTheme.primary.withOpacity(0.2),
                  backgroundColor: AppTheme.surface,
                  labelStyle: TextStyle(
                    color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? AppTheme.primary : Colors.transparent,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Content
            const Text(
              'What’s on your mind?',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _contentController,
              maxLines: 8,
              maxLength: 1000,
              style: const TextStyle(color: AppTheme.textPrimary, height: 1.4),
              decoration: InputDecoration(
                hintText: 'Write freely... this is a safe space',
                hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.6)),
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}