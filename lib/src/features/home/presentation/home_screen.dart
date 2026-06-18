import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import '../../auth/presentation/auth_state.dart';
import '../../notes/presentation/notes_state.dart';
import '../../notes/presentation/note_view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedSection = 'BCA';

  final List<String> _courseSections = ['BCA', 'BA', 'BCom', 'BSc', 'BE', 'EEE'];

  // Map sections to dynamic background accents for brutalism variety
  Color _getSectionColor(String section) {
    switch (section) {
      case 'BCA':
        return NeoBrutalism.accentYellow;
      case 'BA':
        return NeoBrutalism.accentMint;
      case 'BCom':
        return NeoBrutalism.accentOrange;
      case 'BSc':
        return NeoBrutalism.accentBlue;
      case 'BE':
        return NeoBrutalism.primaryPurple;
      case 'EEE':
        return NeoBrutalism.lightPurple;
      default:
        return NeoBrutalism.pureWhite;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final notesState = Provider.of<NotesState>(context);
    final sectionNotes = notesState.getNotesBySection(_selectedSection);

    return Scaffold(
      backgroundColor: NeoBrutalism.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Info bar (Neo-brutalist)
              BrutalContainer(
                backgroundColor: NeoBrutalism.primaryPurple,
                padding: 16.0,
                child: Row(
                  children: [
                    Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: NeoBrutalism.accentYellow,
                        border: NeoBrutalism.border(),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: const Icon(Icons.school, color: NeoBrutalism.darkBlack, size: 28),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STUDENT: ${authState.studentName.toUpperCase()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              color: NeoBrutalism.pureWhite,
                            ),
                          ),
                          Text(
                            authState.universityName.isNotEmpty ? authState.universityName : 'No University set',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: NeoBrutalism.lightPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              
              // Sections Header
              const Text(
                'COURSE SECTIONS',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: NeoBrutalism.darkBlack,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12.0),

              // Course Categories Selector
              SizedBox(
                height: 54.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _courseSections.length,
                  itemBuilder: (context, index) {
                    final section = _courseSections[index];
                    final isSelected = _selectedSection == section;
                    final sectionBg = _getSectionColor(section);
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSection = section;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        margin: const EdgeInsets.only(right: 12.0, bottom: 6.0),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: isSelected ? sectionBg : NeoBrutalism.pureWhite,
                          border: NeoBrutalism.border(),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: isSelected ? NeoBrutalism.shadows(offset: 3.0) : null,
                        ),
                        child: Center(
                          child: Text(
                            section,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14.0,
                              color: (isSelected && section == 'BE') ? NeoBrutalism.pureWhite : NeoBrutalism.darkBlack,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),

              // Notes Header List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AVAILABLE NOTES: $_selectedSection',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: NeoBrutalism.darkBlack,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: NeoBrutalism.pureWhite,
                      border: Border.all(color: NeoBrutalism.darkBlack, width: 1.5),
                    ),
                    child: Text(
                      '${sectionNotes.length} DOCS',
                      style: const TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12.0),

              // List of Notes
              Expanded(
                child: sectionNotes.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: sectionNotes.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final note = sectionNotes[index];
                          return _buildNoteCard(note);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: BrutalContainer(
        backgroundColor: NeoBrutalism.pureWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '📭',
              style: TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'NO NOTES UPLOADED YET',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 14.0,
                color: NeoBrutalism.darkBlack,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Be the first to upload study guides for $_selectedSection courses!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(dynamic note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: BrutalContainer(
        backgroundColor: NeoBrutalism.pureWhite,
        padding: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section - Subject Title & Category badge
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: NeoBrutalism.darkBlack, width: 2.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note.subjectName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: NeoBrutalism.darkBlack,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: _getSectionColor(note.courseSection),
                      border: NeoBrutalism.border(),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      note.courseSection,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 11.0,
                        color: note.courseSection == 'BE' ? NeoBrutalism.pureWhite : NeoBrutalism.darkBlack,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Middle Section - Metadata Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.apartment, size: 16.0, color: NeoBrutalism.darkBlack),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'College: ${note.collegeName}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(Icons.school, size: 16.0, color: NeoBrutalism.darkBlack),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'University: ${note.universityName}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timeline, size: 16.0, color: NeoBrutalism.darkBlack),
                          const SizedBox(width: 8.0),
                          Text(
                            'Semester: ${note.semester}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.menu_book, size: 16.0, color: NeoBrutalism.darkBlack),
                          const SizedBox(width: 8.0),
                          Text(
                            '${note.pageCount} Pages',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Bottom Section - Open / Read Notes Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteViewScreen(note: note),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: const BoxDecoration(
                  color: NeoBrutalism.primaryPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(NeoBrutalism.borderRadius - 3),
                    bottomRight: Radius.circular(NeoBrutalism.borderRadius - 3),
                  ),
                  border: Border(
                    top: BorderSide(color: NeoBrutalism.darkBlack, width: 2.0),
                  ),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye_outlined, color: NeoBrutalism.pureWhite, size: 18.0),
                      SizedBox(width: 8.0),
                      Text(
                        'OPEN NOTES',
                        style: TextStyle(
                          color: NeoBrutalism.pureWhite,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
