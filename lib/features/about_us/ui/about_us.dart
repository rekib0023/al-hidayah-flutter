import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "About us"),
      body: Padding(
        padding: const EdgeInsets.all(.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              RichText(
                text: const TextSpan(
                  text: "Al-Hidayah\n",
                  style: AppTextStyles.heading,
                  children: [
                    TextSpan(
                      text: "International Public School",
                      style: AppTextStyles.subtitle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Empowering Minds, Building Futures: Where Education Meets Excellence",
              ),
              const SizedBox(height: 16),
              const Text(
                """At our school, we embrace a passion for education that goes beyond textbooks and exams. We believe in fostering a nurturing environment where every student can thrive, explore their potential, and embark on an exciting journey of knowledge andgrowth.\n\nWith our dedicated team of experienced educators, state-of-the-art facilities, and innovative teaching methods, we strive to provide a holistic education that prepares students for success in a rapidly evolving world. From fostering critical thinking and creativity to promoting values of empathy and collaboration, we aim to develop well-rounded individuals who can make a positive impact on society.\n\nDiscover the joy of learning in our vibrant classrooms, engage in hands-on experiences, and unlock endless opportunities for personal and academic development. Join our close-knit community that celebrates diversity, encourages curiosity, and empowers students to reach for the stars.\n\nTogether, let's shape a brighter future. Welcome to our school, where education comes alive!""",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
