import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vrit_project/core/widget/progress_dialog.dart';
import 'package:vrit_project/features/home/model/shortner.dart';
import 'package:vrit_project/features/home/service/url_shortner_service.dart';
import 'package:vrit_project/features/home/widget/qr_generation_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Shortner> shortedLinks = [];
  final TextEditingController urlController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Url Link Shortner"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: urlController,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Enter Url";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Enter Url",
                    suffixIcon: IconButton(
                        onPressed: () {
                          urlController.clear();
                        },
                        icon: const Icon(Icons.close))),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      ProgressDialog pr = ProgressDialog(context);
                      await pr.show();
                      try {
                        final data = await UrlShortnerServiceImp()
                            .shortNewUrl(urlController.text);

                        await pr.hide();
                        urlController.clear();
                        setState(() {
                          shortedLinks.add(data);
                        });
                      } catch (e) {
                        await pr.hide();
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    }
                  },
                  child: const Text("Short URL")),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final currentData = shortedLinks[index];
                        return ListTile(
                          title: Row(
                            children: [
                              Text(currentData.id),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: currentData.link));
                                  },
                                  icon: const Icon(Icons.copy_rounded))
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Text(currentData.link),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(currentData.createdAt.toString())
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: QrGeneration(url: currentData.link),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.qr_code)),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: shortedLinks.length)),
            ],
          ),
        ),
      ),
    );
  }
}
