import 'package:cted/Controller/programsDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProgramPage extends StatefulWidget {
  const SearchProgramPage({super.key});

  @override
  State<SearchProgramPage> createState() => _SearchProgramPageState();
}

class _SearchProgramPageState extends State<SearchProgramPage> {
  String keyword = '';
  String tmpText = '';
  final keywordTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<ProgramsDataController>()
            .getProgramInformation(keyword: keyword),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //프로그램 이름들을 리스트에 초기화한다.
            List<String> programNames = snapshot.data!['programNames']!;
            List<String> programAuthors = snapshot.data!['programAuthors']!;
            List<String> programDays = snapshot.data!['programDays']!;
            List<String> programFollowers = snapshot.data!['programFollowers']!;

            return Column(
              children: [
                //검색창 부분
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 55),
                      width: 250,
                      child: TextField(
                        controller: keywordTextFieldController,
                        onChanged: (value) {
                          tmpText = value;
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            keyword = tmpText.trim();
                          });
                          tmpText = '';
                          keywordTextFieldController.clear();
                        },
                        icon: Icon(Icons.search)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: programNames.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              print('${programNames[index]}');
                              await Get.find<ProgramsDataController>()
                                  .minusProgramFollowers(
                                      programName: programNames[index]);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                        right: 20,
                                        bottom: 0),
                                    height: 60,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // 프로그램 이름 있는 부분
                                        Text(
                                          programNames[index],
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //Author, Days, Followers 있는 부분
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                'Author: ${programAuthors[index]}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              width: 120,
                                            ),
                                            Container(
                                              child: Text(
                                                'Days: ${programDays[index]}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              width: 90,
                                            ),
                                            Container(
                                              child: Text(
                                                'Followers: ${programFollowers[index]}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              width: 120,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
