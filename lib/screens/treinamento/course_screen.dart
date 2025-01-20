import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class CourseScreen extends StatelessWidget {
  final String courseName;
  final String courseDescription;
  final String expiryDate;
  final List<LessonItem> lessons;
  final double progress;

  const CourseScreen({
    Key? key,
    required this.courseName,
    required this.courseDescription,
    required this.expiryDate,
    required this.lessons,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      contentPadding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: _buildCourseDetails(),
          ),
          const SizedBox(height: 50),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: lessons.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return LessonButton(
                    lesson: lessons[index],
                    onPressed: () {
                      context.go("/video_screen");
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildCourseDetails() {
    // const width = 300.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          courseName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          courseDescription,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Expira em $expiryDate',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          // width: width,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[300]!),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[300],
                  foregroundColor: Colors.white,
                ),
                child: const Text('começar agora'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LessonItem {
  final String title;
  final String duration;
  final bool isCompleted;

  const LessonItem({
    required this.title,
    required this.duration,
    this.isCompleted = false,
  });
}

class LessonButton extends StatelessWidget {
  final Function onPressed;
  final LessonItem lesson;

  const LessonButton({
    Key? key,
    required this.lesson,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: lesson.isCompleted
                          ? Colors.green[50]
                          : Colors.grey[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      lesson.isCompleted ? Icons.check : Icons.play_arrow,
                      color: lesson.isCompleted ? Colors.green : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson.duration,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icon(
                  //   Icons.star_border,
                  //   color: Colors.grey[400],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
