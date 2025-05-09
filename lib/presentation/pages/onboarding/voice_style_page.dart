import 'package:flutter/material.dart';
import 'package:wakeai/core/util/color_extensions.dart';
import '../../widgets/peri_button.dart';
import '../../widgets/peri_app_bar.dart';
import '../../widgets/peri_card.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';

class VoiceStylePage extends StatefulWidget {
  const VoiceStylePage({super.key});

  @override
  State<VoiceStylePage> createState() => _VoiceStylePageState();
}

class _VoiceStylePageState extends State<VoiceStylePage> {
  int _selectedStyleIndex = 0;

  final List<Map<String, dynamic>> _voiceStyles = [
    {
      'title': 'Encouraging',
      'description':
          'Positive, uplifting guidance to start your day with motivation',
      'icon': Icons.emoji_emotions_outlined,
      'example': 'Great job with your water! Let\'s move on to stretching now.',
    },
    {
      'title': 'Calm',
      'description': 'Gentle, peaceful guidance for a serene morning routine',
      'icon': Icons.spa_outlined,
      'example':
          'When you\'re ready, we\'ll continue with your stretching routine.',
    },
    {
      'title': 'Efficient',
      'description':
          'Straightforward, time-focused guidance to keep you on schedule',
      'icon': Icons.timer_outlined,
      'example': 'Water complete. Stretching: 5 minutes. Starting now.',
    },
    {
      'title': 'Friendly',
      'description':
          'Conversational, warm guidance like talking to a good friend',
      'icon': Icons.favorite_border_outlined,
      'example':
          'Hey there! Water done? Awesome! Ready for some morning stretches?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: const PeriAppBar(
        title: 'Choose Your Voice Style',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How would you like Peri to speak with you?',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'Don\'t worry, you can change this anytime in settings.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textLight),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Voice Style Cards
              Expanded(
                child: ListView.builder(
                  itemCount: _voiceStyles.length,
                  itemBuilder: (context, index) {
                    final style = _voiceStyles[index];
                    final isSelected = index == _selectedStyleIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStyleIndex = index;
                        });
                      },
                      child: PeriCard(
                        margin: const EdgeInsets.only(bottom: 16),
                        backgroundColor:
                            isSelected
                                ? AppTheme.primaryGold.withAlphaValue(.8)
                                : Colors.white,
                        borderRadius: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? AppTheme.primaryGold
                                            : AppTheme.primaryGold
                                                .withAlphaValue(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    style['icon'] as IconData,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : AppTheme.primaryGold,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        style['title'] as String,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected
                                                  ? AppTheme.primaryGold
                                                  : AppTheme.textDark,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        style['description'] as String,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppTheme.primaryGold,
                                  ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Example speech bubble
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppTheme.primaryGold.withAlphaValue(
                                          0.2,
                                        )
                                        : Colors.grey.withAlphaValue(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.format_quote,
                                    size: 20,
                                    color:
                                        isSelected
                                            ? AppTheme.primaryGold
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      style['example'] as String,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontStyle: FontStyle.italic,
                                        color:
                                            isSelected
                                                ? AppTheme.primaryGold
                                                    .withAlphaValue(0.8)
                                                : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              PeriButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.routineSetup);
                },
                isFullWidth: true,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
