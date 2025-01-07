import 'package:flutter/material.dart';

class NotificationIconWithDot extends StatelessWidget {
  final bool hasUnreadNotifications;

  const NotificationIconWithDot(
      {super.key, required this.hasUnreadNotifications});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          hasUnreadNotifications
              ? Icons.notifications_active
              : Icons.notifications,
          color: Colors.white,
        ),
        if (hasUnreadNotifications)
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
            ),
          ),
      ],
    );
  }
}
