import 'package:al_hidayah/features/overview/bloc/overview_bloc.dart';
import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentCreate extends StatefulWidget {
  const StudentCreate({super.key, required this.overviewBloc});
  final OverviewBloc overviewBloc;

  @override
  State<StudentCreate> createState() => _StudentCreateState();
}

class _StudentCreateState extends State<StudentCreate> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController parentsDetailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final OverviewBloc overviewBloc = OverviewBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: Text(
          "Student Create",
          style: AppTextStyles.title.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: BlocConsumer<OverviewBloc, OverviewState>(
            bloc: widget.overviewBloc,
            listenWhen: (previous, current) => current is OverviewActionState,
            buildWhen: (previous, current) => current is! OverviewActionState,
            listener: (context, state) {
              if (state is StudentCreatedSuccessState) {
                widget.overviewBloc.add(
                    StudentListInitialEvent(className: classController.text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Student created successfully"),
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case StudentCreateLoadingState:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case StudentListAddNewButtonClickState:
                  final successState =
                      state as StudentListAddNewButtonClickState;
                  final String className = successState.className;
                  classController.text = className;
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: "Enter first name",
                                  labelText: "First name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  hintText: "Enter last name",
                                  labelText: "Last name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Enter email address",
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: "Enter phone number",
                                  labelText: "Phone number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.datetime,
                          controller: dobController,
                          decoration: InputDecoration(
                            hintText: "Enter date of birth",
                            helperText: "Format is YYYY-MM-DD",
                            labelText: "Date of birth",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: classController,
                          decoration: InputDecoration(
                            hintText: "Enter class name",
                            labelText: "Class name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: "Enter address",
                            labelText: "Addresss",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          controller: parentsDetailController,
                          decoration: InputDecoration(
                            hintText: "Enter parent's details here",
                            labelText: "Parent's details",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                              text: "Create",
                              onPressed: () {
                                widget.overviewBloc.add(
                                  StudentCreateButtonClickEvent(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    dob: dobController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                    className: classController.text,
                                    parentsDetail: parentsDetailController.text,
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
