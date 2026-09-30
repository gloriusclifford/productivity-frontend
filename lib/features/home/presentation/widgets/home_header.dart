import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget{
  final String name;
  final String avatarUrl;

  const HomeHeader({
    super.key,
    required this.name,
    required this.avatarUrl,
});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hi, $name',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
          )
        ],
      ),
    );
  }
}