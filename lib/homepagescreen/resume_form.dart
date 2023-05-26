import 'package:flutter/material.dart';
import 'package:resume_builder/resumeformscreen/career_details/careerobjective.dart';
import 'package:resume_builder/resumeformscreen/certification_details/certifications.dart';
import 'package:resume_builder/resumeformscreen/hobbies_details/hobbies_form.dart';
import 'package:resume_builder/resumeformscreen/language_details/languages_form.dart';
import 'package:resume_builder/resumeformscreen/personal_details/personal_form.dart';
import 'package:resume_builder/resumeformscreen/project_details/projects_form.dart';
import 'package:resume_builder/resumeformscreen/skill_details/skills_form.dart';

import '../resumeformscreen/education_details/education_form.dart';
import '../resumeformscreen/experience_details//experience_form.dart';
import '../resumeformscreen/reference_details/reference_form.dart';

class ResumeForm extends StatefulWidget {
  const ResumeForm({super.key});

  @override
  State<ResumeForm> createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 10,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            bottom: const TabBar(
              // labelColor: Colors.white,
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Tab(child: Text("Personal"),),
                Tab(child: Text("Education")),
                Tab(child: Text("Professional Skills")),
                Tab(child: Text("Career Objective")),
                Tab(child: Text("Experience")),
                Tab(child: Text("Projects")),
                Tab(child: Text("Certifications")),
                Tab(child: Text("Hobbies")),
                Tab(child: Text("Languages")),
                Tab(child: Text("References")),
              ],
            ),
            title:Center(
              child: Text('Create Resume',
              ),
            ),
            backgroundColor: Color.fromARGB(255,0,121,139),
          ),
          body: const
          TabBarView(
            children: <Widget>[
              PersonalForm(),
              EducationForm(),
              Skills(),
              AboutForm(),
              ExperienceForm(),
              ProjectForm(),
              CertificateForm(),
              HobbiesForm(),
              LanguagesForm(),
              SocialsForm(),
            ],
          ),
        ),
      ),
    );
  }
}
