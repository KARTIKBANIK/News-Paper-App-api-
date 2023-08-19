import 'package:flutter/material.dart';
import 'package:newz_app/model/news_model.dart';
import 'package:newz_app/service/newz_api_service.dart';
import 'package:newz_app/widgets/const.dart';

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

    newsList = await NewsApiService().fetchNewsData();
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
              ListView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: newsList.length,
                itemBuilder: (_, index) {
                  return Container(
                    height: 350,
                    width: double.infinity,
                    // child: Image.network("${newsList[index].urlToImage}"),
                    child: Text("${newsList[index].content}"),
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
