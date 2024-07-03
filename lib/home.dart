import 'package:curd_practice/model/post_model.dart';
import 'package:curd_practice/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isApiLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "CRUD Operation",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<TaskModel>>(
        future: getTaskApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];
                return ListTile(
                  title: Text(
                    task.title ?? 'No title',
                  ),
                  subtitle: Text(
                    task.body ?? 'No body',
                  ),
                  leading: IconButton(
                    onPressed: () async {
                      await deleteTaskApi(snapshot.data?[index].sId ?? "0");
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await updateTaskApi(snapshot.data?[index].sId ?? "0");
                      setState(() {});
                    },
                    icon: const Icon(Icons.update, color: Colors.green),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isApiLoading = true;
          });
          await postTaskApi();
          setState(() {
            isApiLoading = false;
          });
        },
        child: isApiLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }
}
