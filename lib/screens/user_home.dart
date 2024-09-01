import 'package:flutter/material.dart';
import 'base_screen.dart';
import '../global_state.dart';

class UserHome extends StatelessWidget {
  final String userType; // 'professional' ou 'owner'
  final String userId; // ID do usuário atual

  const UserHome({super.key, required this.userType, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: Text(
          userType == 'professional'
              ? 'Área dos Profissionais'
              : 'Área dos Proprietários',
          style: TextStyle(fontSize: 24),
        ),
      ),
      userType: userType,
      userId: userId,
      userName: GlobalState.userName,
      userPhotoUrl: GlobalState.userPhotoUrl,
    );
  }
}
