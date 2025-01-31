import 'package:droidcon_app/providers/sessions/bookmarked_sessions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/session/session.dart';
import '../../../../styles/colors/colors.dart';
import '../../widgets/afrikon_icon.dart';

class BookmarkSessionButton extends ConsumerWidget {
  const BookmarkSessionButton({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedSessions = ref.watch(bookmarkedSessionsProvider);
    final isBookmarked = bookmarkedSessions.maybeWhen(
      success: (sessions) =>
          (sessions as List<Session>)
              .indexWhere((element) => element.id == session.id) >
          -1,
      orElse: () => false,
    );

    return IconButton(
      padding: EdgeInsets.zero,
      icon: AfrikonIcon(
        isBookmarked ? 'star' : 'star-outline',
        height: 24,
        color: isBookmarked ? AppColors.orangeColor : AppColors.blueColor,
      ),
      onPressed: () {
        ref.read(bookmarkedSessionsProvider.notifier).toggle(session);
      },
    );
  }
}
