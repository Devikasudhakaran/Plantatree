import 'package:flutter/material.dart';
import 'package:plantatree/controller/all_projects_screen_controller.dart';
import 'package:plantatree/model/all_project_screen_delete_model.dart';
import 'package:plantatree/model/all_project_screen_fetch_model.dart';
import 'package:plantatree/widget/alert_message.dart';
import 'package:plantatree/widget/appbar.dart';
import 'package:plantatree/view/new_project.dart';
import 'package:plantatree/view/project_single_screen.dart';
import 'package:plantatree/widget/list_view_builder.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/project_card.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectsScreenController projectsScreenController =
      ProjectsScreenController();
  bool flotingbutton = true;
  bool isLoading = true;
  List<DataList> dataList = [];

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  Future deleteProject(String id) async {
    final user = ProjectScreenDeleteModel(id: id);
    try {
      final statuscode =
          await projectsScreenController.deleteProject(context, user);
      fetchData();
    } catch (e) {
      print('Error Deleteing Project: $e');
    }
  }

  Future fetchData() async {
    dataList.clear();
    final statuscode = await projectsScreenController.fetchData();
    setState(() {
      flotingbutton = false;

      if (statuscode != null) {
        dataList = statuscode.dataList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: flotingbutton
            ? Container()
            : FloatingActionButton(
                onPressed: (() async {
                  String? Refreash =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateProjectPageOne(),
                  ));
                  if (Refreash == "refresh") {
                    fetchData();
                  }
                }),
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF497a39),
                ),
              ),
        body: Stack(
          children: [
            if (dataList.isEmpty)
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Loadingwidget(color: Colors.green, size: 40)],
                  )),
            if (dataList.isNotEmpty)
              Column(
                children: [
                  Appbar(
                    headingtext: 'All Project',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.15,
                    child: ListViewBuilder(
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext, index) {
                        final project = dataList[index];
                        return GestureDetector(
                          onTap: () async {
                            if (project.status == "2") {
                              return Altermessage.showCustomDialog(
                                onConfirmed: () {
                                  deleteProject(project.id);
                                  Navigator.of(context).pop("refresh");
                                },
                                title: "Rejected",
                                message:
                                    "This project has been rejected by the admin for not meeting the basic guidelines. Please remove it.",
                                confirmnavi: 1,
                                cannelbutton: "Cancel",
                                confirmbutton: "Delete",
                                context: context,
                                cannelnavi: 0,
                                onCannel: () {},
                              );
                            } else {
                              String? Refreash = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => SingleViewProjectScreen(
                                  projectId: project.id,
                                ),
                              ));
                              print(Refreash);

                              if (Refreash == "refresh") {
                                fetchData();
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ProjectCard(
                              imageURL: project.image,
                              status: project.status,
                              Name: project.name,
                              description: project.description,
                              temperture: project.temperture,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
          ],
        ));
  }
}
