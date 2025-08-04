import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = Project.sampleProjects;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Projects", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Column(
            children: projects.map((project) => ProjectCard(project: project)).toList(),
          ),
        ],
      ),
    );
  }
}
