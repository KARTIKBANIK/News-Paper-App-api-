import 'package:flutter/material.dart';
import 'package:newz_app/model/news_model.dart';
import 'package:newz_app/service/newz_api_service.dart';
import 'package:newz_app/widgets/const.dart';
import 'package:newz_app/widgets/error_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> newsList = [];
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    newsList = await NewsApiService.fetchNewsData();
  }

  int currentIndex = 1;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          "Newz App",
          style: myStyle(
            22,
            Colors.black,
            FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Newz",
                style: myStyle(18, Colors.black, FontWeight.w700),
              ),
              Container(
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    paginationButton(
                        onPresed: () {}, clr: Colors.blueAccent, title: "Prev"),
                    Flexible(
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: paginationButton(
                                onPresed: () {
                                  setState(() {
                                    currentIndex = index + 1;
                                  });
                                },
                                clr: index + 1 == currentIndex
                                    ? Colors.blue
                                    : Colors.grey,
                                title: "${index + 1}"),
                          );
                        },
                      ),
                    ),
                    paginationButton(
                        onPresed: () {}, clr: Colors.blueAccent, title: "Next"),
                  ],
                ),
              ),
              FutureBuilder<List<Articles>>(
                future: NewsApiService.fetchNewsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return ErrorScreen();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          height: 220,
                          width: double.infinity,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].title}",
                                style:
                                    myStyle(15, Colors.black, FontWeight.w700),
                              ),
                              Image.network(
                                "${newsList[index].urlToImage}",
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          // child: Text("${snapshot.data![index].title}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton paginationButton(
      {VoidCallback? onPresed, String? title, Color? clr}) {
    return MaterialButton(
      color: clr,
      onPressed: onPresed,
      child: Text(
        "$title",
        style: myStyle(14, Colors.black, FontWeight.w700),
      ),
    );
  }
}
