import 'package:flutter/material.dart';

class TeenModeNotice extends StatelessWidget {
  final VoidCallback onClose;

  const TeenModeNotice({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '已关闭青少年模式',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }
}