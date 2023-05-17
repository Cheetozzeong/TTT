import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';

class A804Screen extends StatelessWidget {
  const A804Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    List<String> imagePaths = [
      'assets/images/tockles/toc_26.png',
      'assets/images/tockles/toc_30.png',
      'assets/images/tockles/toc_31.png',
      'assets/images/tockles/toc_29.png',
      'assets/images/tockles/toc_27.png',
      'assets/images/tockles/toc_28.png',
    ];

    List<String> titles = [
      '토끌이들 주인 박홍빈',
      '토끌이 아버지 이해은',
      'API의 학살자 이승진',
      'KB카드 신입사원 손정훈',
      'ChatGpt의 노예 박한샘',
      'E팀장과 I들의 이치헌(팀장)',
    ];

    List<String> bodies = [
      'BE TechLeader',
      'Android Leader',
      'BE',
      'BE',
      'BE & Android',
      'Wear & Android',
    ];

    List<String> details = [
      '개발자들이랑만 함께하는 프로젝트는 신선하고 즐겁습니다!🎄🎄',
      '어 시간 남네 토끌이 그려야지~🎶',
      '⚔잡았... 잡혔죠?⚔',
      '遠心したい…🌪',
      'git좀 잘하고 싶다... git같은 소리🚀',
      '프로젝트 진행 될수록 다들 몰두하는 모습 보니까 더욱 책임감을 가지고 열심히 할 수 있었던 것 같습니다! I들 너무 고생많았고 틱택톡 수상 가즈아..!!',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(appBarType: AppBarType.normalAppBar, title: 'E팀장과 I들'),
        body: Center(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            padding: const EdgeInsets.all(20.0),
            children: List.generate(imagePaths.length, (index) {
              final String imagePath = imagePaths[index];
              final String title = titles[index];
              final String body = bodies[index];
              final String detail = details[index];

              return SizedBox(
                width: deviceHeight * 0.2,
                height: deviceHeight * 0.2,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) {
                        return Center(
                          child: Container(
                            width: deviceWidth * 0.8,
                            height: deviceHeight * 0.5,
                            child: Card(
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            title,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: Image.asset(imagePath),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        body,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          detail,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(imagePath),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
