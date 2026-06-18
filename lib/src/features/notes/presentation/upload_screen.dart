import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import '../../auth/presentation/auth_state.dart';
import 'notes_state.dart';
import '../domain/note.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  String _selectedSection = 'BCA';
  int _selectedSemester = 1;
  String _selectedFileName = '';
  bool _isFilePicked = false;

  final List<String> _courseSections = ['BCA', 'BA', 'BCom', 'BSc', 'BE', 'EEE'];
  final List<int> _semesters = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  void initState() {
    super.initState();
    // Auto-fill university from onboarding state if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = Provider.of<AuthState>(context, listen: false);
      if (authState.universityName.isNotEmpty) {
        setState(() {
          _universityController.text = authState.universityName;
        });
      }
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _collegeController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  void _simulateFilePicker() {
    // Generate a mockup filename based on subject name
    final prefix = _subjectController.text.trim().isNotEmpty
        ? _subjectController.text.trim().replaceAll(' ', '_').toLowerCase()
        : 'syllabus';
        
    setState(() {
      _selectedFileName = '${prefix}_notes_sem$_selectedSemester.pdf';
      _isFilePicked = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: NeoBrutalism.accentMint,
            border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
          ),
          child: Text(
            'Selected PDF: $_selectedFileName',
            style: const TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void _handleUpload() {
    final subject = _subjectController.text.trim();
    final college = _collegeController.text.trim();
    final university = _universityController.text.trim();

    if (subject.isEmpty || college.isEmpty || university.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: NeoBrutalism.accentOrange,
              border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
            ),
            child: const Text(
              'Please fill all form fields!',
              style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return;
    }

    if (!_isFilePicked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: NeoBrutalism.accentOrange,
              border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
            ),
            child: const Text(
              'Please select a PDF notes file!',
              style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return;
    }

    final authState = Provider.of<AuthState>(context, listen: false);
    final notesState = Provider.of<NotesState>(context, listen: false);

    // Create new StudyNote object
    final note = StudyNote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subjectName: subject,
      collegeName: college,
      universityName: university,
      semester: _selectedSemester,
      courseSection: _selectedSection,
      uploadedBy: authState.studentName.isNotEmpty ? authState.studentName : 'Contributor',
      pageCount: 3,
      pageContents: [
        'CHAPTER 1: Fundamental Concepts of $subject\n\nStudy Notes contributed by ${authState.studentName}.\n\nThis syllabus outlines core topics for semester $_selectedSemester of study in $_selectedSection.\n\nSection 1.1: Foundations\nReview calculations, designs, and systems relevant to $college syllabus models.',
        'CHAPTER 2: Operational Standards\n\nAdvanced analytical reviews of primary mechanics. Study questions include calculations and design definitions.',
        'CHAPTER 3: Exam Summary\n\nFocus on topic details provided during campus evaluations.'
      ],
    );

    // Save note to shared state
    notesState.addNote(note);

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: NeoBrutalism.pureWhite,
          shape: Border.all(color: NeoBrutalism.darkBlack, width: 3.0),
          title: const Text(
            'UPLOAD SUCCESS!',
            style: TextStyle(fontWeight: FontWeight.w900, color: NeoBrutalism.darkBlack),
          ),
          content: Text(
            'Your note "$subject" has been successfully uploaded to the $_selectedSection section.',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            BrutalButton(
              backgroundColor: NeoBrutalism.accentMint,
              onPressed: () {
                Navigator.of(context).pop();
                
                // Clear fields
                _subjectController.clear();
                _collegeController.clear();
                setState(() {
                  _isFilePicked = false;
                  _selectedFileName = '';
                });
              },
              child: const Text(
                'AWESOME',
                style: TextStyle(fontWeight: FontWeight.w900, color: NeoBrutalism.darkBlack),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalism.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Title
                const Text(
                  'UPLOAD STUDY NOTES',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    color: NeoBrutalism.darkBlack,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Contribute notes and lecture documents for fellow students.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24.0),

                // Form Container
                BrutalContainer(
                  backgroundColor: NeoBrutalism.pureWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subject Field
                      BrutalTextField(
                        controller: _subjectController,
                        labelText: 'SUBJECT / MODULE NAME',
                        hintText: 'e.g. Database Systems',
                        prefixIcon: Icons.book,
                      ),
                      const SizedBox(height: 18.0),

                      // College Field
                      BrutalTextField(
                        controller: _collegeController,
                        labelText: 'COLLEGE NAME',
                        hintText: 'e.g. ABC College of Science',
                        prefixIcon: Icons.apartment,
                      ),
                      const SizedBox(height: 18.0),

                      // University Field
                      BrutalTextField(
                        controller: _universityController,
                        labelText: 'UNIVERSITY NAME',
                        hintText: 'e.g. VTU',
                        prefixIcon: Icons.school,
                      ),
                      const SizedBox(height: 18.0),

                      // Semester Dropdown & Category Section
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'SEMESTER',
                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.0),
                                ),
                                const SizedBox(height: 6.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: NeoBrutalism.pureWhite,
                                    border: NeoBrutalism.border(),
                                    borderRadius: BorderRadius.circular(NeoBrutalism.borderRadius),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      value: _selectedSemester,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down, color: NeoBrutalism.darkBlack),
                                      style: const TextStyle(fontWeight: FontWeight.w900, color: NeoBrutalism.darkBlack),
                                      items: _semesters.map((sem) {
                                        return DropdownMenuItem<int>(
                                          value: sem,
                                          child: Text('Sem $sem'),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _selectedSemester = val!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'COURSE SECTION',
                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.0),
                                ),
                                const SizedBox(height: 6.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: NeoBrutalism.pureWhite,
                                    border: NeoBrutalism.border(),
                                    borderRadius: BorderRadius.circular(NeoBrutalism.borderRadius),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedSection,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down, color: NeoBrutalism.darkBlack),
                                      style: const TextStyle(fontWeight: FontWeight.w900, color: NeoBrutalism.darkBlack),
                                      items: _courseSections.map((sec) {
                                        return DropdownMenuItem<String>(
                                          value: sec,
                                          child: Text(sec),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _selectedSection = val!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),

                      // File Selection Area
                      const Text(
                        'SELECT NOTES DOCUMENT (PDF)',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.0),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: _simulateFilePicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: _isFilePicked ? NeoBrutalism.lightPurple : NeoBrutalism.background,
                            border: Border.all(
                              color: NeoBrutalism.darkBlack,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(NeoBrutalism.borderRadius),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  _isFilePicked ? Icons.picture_as_pdf : Icons.cloud_upload_outlined,
                                  size: 36.0,
                                  color: _isFilePicked ? NeoBrutalism.primaryPurple : NeoBrutalism.darkBlack,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  _isFilePicked ? _selectedFileName : 'TAP TO PICK A PDF FILE',
                                  style: TextStyle(
                                    fontWeight: _isFilePicked ? FontWeight.w900 : FontWeight.bold,
                                    fontSize: 12.0,
                                    color: _isFilePicked ? NeoBrutalism.primaryPurple : NeoBrutalism.darkBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),

                // Submit Upload Button
                BrutalButton(
                  backgroundColor: NeoBrutalism.accentMint,
                  onPressed: _handleUpload,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'UPLOAD NOTES NOW',
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
}
