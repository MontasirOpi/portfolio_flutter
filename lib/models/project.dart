class Project {
  final String title;
  final String description;
  final String image;

  Project({required this.title, required this.description, required this.image});

  static List<Project> get sampleProjects => [
        Project(title: "Smart Room App", description: "An IoT-based app to control temperature and humidity.", image: "assets/images/dummy_project.png"),
        Project(title: "Parking System", description: "A real-time parking slot manager using Flutter & Firebase.", image: "assets/images/dummy_project.png"),
        Project(title: "News Reader", description: "A Flutter app fetching news via NewsAPI.", image: "assets/images/dummy_project.png"),
        Project(title: "Student Attendance", description: "Role-based Flutter app to track student attendance.", image: "assets/images/dummy_project.png"),
        Project(title: "Skin Cancer Detector", description: "Deep learning app to classify skin cancer types.", image: "assets/images/dummy_project.png"),
      ];
}
