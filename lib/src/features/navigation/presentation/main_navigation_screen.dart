import 'package:flutter/material.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import '../../home/presentation/home_screen.dart';
import '../../notes/presentation/upload_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const UploadScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalism.background,
      body: _tabs[_selectedTabIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: const BoxDecoration(
          color: NeoBrutalism.pureWhite,
          border: Border(
            top: BorderSide(
              color: NeoBrutalism.darkBlack,
              width: NeoBrutalism.borderWidth,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                index: 0,
                icon: Icons.home_filled,
                label: 'HOME',
                color: NeoBrutalism.accentYellow,
              ),
              _buildBottomNavItem(
                index: 1,
                icon: Icons.cloud_upload,
                label: 'UPLOAD',
                color: NeoBrutalism.primaryPurple,
                labelColor: NeoBrutalism.pureWhite,
              ),
              _buildBottomNavItem(
                index: 2,
                icon: Icons.person,
                label: 'PROFILE',
                color: NeoBrutalism.accentMint,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required int index,
    required IconData icon,
    required String label,
    required Color color,
    Color labelColor = NeoBrutalism.darkBlack,
  }) {
    final isSelected = _selectedTabIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          border: isSelected ? NeoBrutalism.border() : Border.all(color: Colors.transparent, width: NeoBrutalism.borderWidth),
          borderRadius: BorderRadius.circular(NeoBrutalism.borderRadius),
          boxShadow: isSelected ? NeoBrutalism.shadows(offset: 3.0) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? (labelColor == NeoBrutalism.pureWhite ? NeoBrutalism.pureWhite : NeoBrutalism.darkBlack) : NeoBrutalism.darkBlack.withAlpha(153),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12.0,
                  color: labelColor,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
