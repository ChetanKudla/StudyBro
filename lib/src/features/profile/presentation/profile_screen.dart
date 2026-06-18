import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import '../../auth/presentation/auth_state.dart';
import '../../notes/presentation/notes_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = Provider.of<AuthState>(context, listen: false);
      _nameController.text = authState.studentName;
      _universityController.text = authState.universityName;
      _collegeController.text = authState.collegeName.isNotEmpty ? authState.collegeName : 'Default College';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _universityController.dispose();
    _collegeController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_nameController.text.trim().isEmpty || _universityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: NeoBrutalism.accentOrange,
              border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
            ),
            child: const Text(
              'Name and University cannot be empty!',
              style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return;
    }

    Provider.of<AuthState>(context, listen: false).updateProfile(
      name: _nameController.text.trim(),
      university: _universityController.text.trim(),
      college: _collegeController.text.trim(),
    );

    setState(() {
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: NeoBrutalism.accentMint,
            border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
          ),
          child: const Text(
            'Profile updated successfully!',
            style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final notesState = Provider.of<NotesState>(context);
    
    final userNotesCount = notesState.notes
        .where((note) => note.uploadedBy == authState.studentName)
        .length;

    return Scaffold(
      backgroundColor: NeoBrutalism.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'STUDENT PROFILE',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    color: NeoBrutalism.darkBlack,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 20.0),

                // Avatar and Status Card
                BrutalContainer(
                  backgroundColor: NeoBrutalism.primaryPurple,
                  child: Row(
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: NeoBrutalism.accentYellow,
                          border: NeoBrutalism.border(color: NeoBrutalism.darkBlack),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Center(
                          child: Text(
                            authState.studentName.isNotEmpty
                                ? authState.studentName.substring(0, 1).toUpperCase()
                                : 'S',
                            style: const TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.w900,
                              color: NeoBrutalism.darkBlack,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authState.studentName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w900,
                                color: NeoBrutalism.pureWhite,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: NeoBrutalism.accentMint,
                                border: Border.all(color: NeoBrutalism.darkBlack, width: 1.5),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                authState.isLoggedIn ? 'LOGGED IN STUDENT' : 'GUEST STUDENT',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w900,
                                  color: NeoBrutalism.darkBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),

                // Academic Information Detail Box
                BrutalContainer(
                  backgroundColor: NeoBrutalism.pureWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ACADEMIC PROFILE',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              color: NeoBrutalism.darkBlack,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isEditing ? Icons.check_circle : Icons.edit,
                              color: NeoBrutalism.primaryPurple,
                            ),
                            onPressed: () {
                              if (_isEditing) {
                                _saveProfile();
                              } else {
                                setState(() {
                                  _isEditing = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const Divider(color: NeoBrutalism.darkBlack, thickness: 2.0),
                      const SizedBox(height: 12.0),
                      
                      // Editable fields
                      _buildProfileField(
                        label: 'FULL NAME',
                        controller: _nameController,
                        enabled: _isEditing,
                      ),
                      const SizedBox(height: 16.0),
                      _buildProfileField(
                        label: 'COLLEGE NAME',
                        controller: _collegeController,
                        enabled: _isEditing,
                      ),
                      const SizedBox(height: 16.0),
                      _buildProfileField(
                        label: 'UNIVERSITY',
                        controller: _universityController,
                        enabled: _isEditing,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),

                // Stats Dashboard
                const Text(
                  'STATISTICS',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: NeoBrutalism.darkBlack,
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: BrutalContainer(
                        backgroundColor: NeoBrutalism.accentYellow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CONTRIBUTIONS',
                              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '$userNotesCount DOCS',
                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: BrutalContainer(
                        backgroundColor: NeoBrutalism.accentBlue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SYSTEM RATING',
                              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              '4.9 STARS',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),

                // Log out Button
                BrutalButton(
                  backgroundColor: NeoBrutalism.accentOrange,
                  onPressed: () {
                    // Log out states and pop to onboarding
                    Provider.of<AuthState>(context, listen: false).logout();
                    Provider.of<NotesState>(context, listen: false).clearNotes();
                    Navigator.of(context).pushNamedAndRemoveUntil('/onboarding', (route) => false);
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'RESET & LOGOUT',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          color: NeoBrutalism.darkBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: enabled ? NeoBrutalism.background : NeoBrutalism.pureWhite,
            border: Border.all(
              color: enabled ? NeoBrutalism.primaryPurple : NeoBrutalism.darkBlack,
              width: enabled ? 2.0 : 1.5,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: NeoBrutalism.darkBlack,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
