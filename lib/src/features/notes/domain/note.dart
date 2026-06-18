class StudyNote {
  final String id;
  final String subjectName;
  final String collegeName;
  final String universityName;
  final int semester;
  final String courseSection; // BCA, BA, BCom, BSc, BE, EEE
  final String uploadedBy;
  final int pageCount;
  final List<String> pageContents;

  StudyNote({
    required this.id,
    required this.subjectName,
    required this.collegeName,
    required this.universityName,
    required this.semester,
    required this.courseSection,
    required this.uploadedBy,
    required this.pageCount,
    required this.pageContents,
  });

  factory StudyNote.createEmptyMock(String id, String subject, String section, String uni) {
    return StudyNote(
      id: id,
      subjectName: subject,
      collegeName: "Default College",
      universityName: uni,
      semester: 1,
      courseSection: section,
      uploadedBy: "Admin",
      pageCount: 3,
      pageContents: [
        "CHAPTER 1: Introduction to $subject\n\nThis is a simulated notes viewer for $subject. Neo-brutalist aesthetics focus on structural clarity and high-contrast design.\n\nSection 1.1: Core Concepts\nThis chapter introduces the fundamental models of $section, covering the foundations, structural designs, and real-world implications.",
        "CHAPTER 2: Advanced Topics in $subject\n\nDetailed breakdowns of modern algorithms and systems. Topics covered include advanced theory, application frameworks, optimization protocols, and industry standards.",
        "CHAPTER 3: Exam Prep Summary\n\n- Key Terminology: Make sure to review basic definitions.\n- Focus Questions: Focus on short-answer derivations of core models.\n- Revision Exercises: Complete past year question banks for semesters 1 and 2."
      ],
    );
  }
}
