import 'package:flutter/material.dart';
import 'package:flutter_evapro/apiroute/Post.dart';
import 'package:flutter_evapro/apiroute/remote_services.dart';


class ApiRoute extends StatefulWidget {
  const ApiRoute({Key? key}) : super(key: key);

  @override
  State<ApiRoute> createState() => _HomePageState();
}

class _HomePageState extends State<ApiRoute> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteServices().getPosts();
    print(posts);

    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(
                posts![index].body ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
