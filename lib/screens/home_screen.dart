import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/vent_service.dart';
import '../widgets/vent_card.dart';
import 'create_vent_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Work',
    'Relationships',
    'Mental health',
    'Random',
  ];

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final vents = VentService.getVents(category: selectedCategory);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Vent'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.surface,
                  title: const Text('About Vent', style: TextStyle(color: AppTheme.textPrimary)),
                  content: const Text(
                    'A calm place to share what’s on your mind anonymously.\n\nBe kind. Be honest. You’re not alone.',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                    selectedColor: AppTheme.primary.withOpacity(0.2),
                    backgroundColor: AppTheme.surface,
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppTheme.primary : Colors.transparent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Feed
          Expanded(
            child: vents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 64,
                          color: AppTheme.textSecondary.withOpacity(0.4),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No vents yet',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Be the first to share something',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: vents.length,
                    itemBuilder: (context, index) {
                      return VentCard(
                        vent: vents[index],
                        onReaction: _refresh,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateVentScreen()),
          );
          _refresh(); // refresh after coming back
        },
        child: const Icon(Icons.edit_rounded),
      ),
    );
  }
}