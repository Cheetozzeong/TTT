import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import 'package:tickle_tackle_tockle/model/TickleCountNameRes.dart';
import '../../component/common_appbar.dart';
import 'package:tickle_tackle_tockle/const/tockle_list.dart';
import 'package:http/http.dart' as http;


class RewardScreen extends StatelessWidget {
  const RewardScreen({Key? key}) : super(key: key);

  Future<http.Response> sendAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('http://10.0.2.2:8428/tickle/count');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accessToken' :  accessToken,
      },
    );
    return response;
  }

  Future<List<TickleCountNameRes>> checkAccessToken() async {
    final response = await sendAccessToken();
    List<TickleCountNameRes> retList = [];

    if (response.statusCode == 200) {
      retList = parseTickleCountNameResList(utf8.decode(response.bodyBytes));
      print(retList);
    } else {
      print('Login failed with status: ${response.statusCode}');
    }

    return retList;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;


    const double tokleImgSizeWidth = 110;
    const double tokleImgSizeHeight = 110;

    buildTocklesRow() {
      List<Widget> tocklesRowList = [];
      List<Widget> tockleElement = [];

      int testMoney = 0;
      int testExercise = 0;
      int testsStudy = 0;
      int testRelationship = 0;
      int testLife = 0;
      int testEtc = 0;

      for(int i = 1; i < tockleImgList.length; i++) {
        TockleCondition tockleCondition = tockleConditionList[i - 1];
        bool isClearTockle = true;

        if(testMoney < tockleCondition.moneyCnt) isClearTockle = false;
        if(testExercise < tockleCondition.exerciseCnt) isClearTockle = false;
        if(testsStudy < tockleCondition.studyCnt) isClearTockle = false;
        if(testRelationship < tockleCondition.relationshipCnt) isClearTockle = false;
        if(testLife < tockleCondition.lifeCnt) isClearTockle = false;
        if(testEtc < tockleCondition.etcCnt) isClearTockle = false;

        Widget widgetTockle = isClearTockle ? tockleImgList[i] : tockleImgList[0];
        int tockleNumber = i - 1;
        String strTockleNumber = tockleNumber.toString().padLeft(2, '0');
        String tockleName = isClearTockle ? tockleInfoList[tockleNumber].name : '???';

        String strCondition = '최초 가입 시 획득';
        String strMoneyCondition = '';
        String strExerciseCondition = '';
        String strStudyCondition = '';
        String strRelationshipCondition = '';
        String strLifeCondition = '';
        String strEtcCondition = '';

        bool isZero = true;
        if(tockleCondition.moneyCnt > 0) {
          strMoneyCondition = '금전 ${tockleCondition.moneyCnt}티끌';
          isZero = false;
        }

        if(tockleCondition.exerciseCnt > 0) {
          if(!isZero) {
            strExerciseCondition = ' & 운동 ${tockleCondition.exerciseCnt}티끌';
          } else {
            strExerciseCondition = '운동 ${tockleCondition.exerciseCnt}티끌';
          }
          isZero = false;
        }

        if(tockleCondition.studyCnt > 0) {
          if(!isZero) {
            strStudyCondition = ' & 학습 ${tockleCondition.studyCnt}티끌';
          } else {
            strStudyCondition = '학습 ${tockleCondition.studyCnt}티끌';
          }
          isZero = false;
        }

        if(tockleCondition.relationshipCnt > 0) {
          if(!isZero) {
            strRelationshipCondition = ' & 관계 ${tockleCondition.relationshipCnt}티끌';
          } else {
            strRelationshipCondition = '관계 ${tockleCondition.relationshipCnt}티끌';
          }
          isZero = false;
        }

        if(tockleCondition.lifeCnt > 0) {
          if(!isZero) {
            strLifeCondition = ' & 생활 ${tockleCondition.lifeCnt}티끌';
          } else {
            strLifeCondition = '생활 ${tockleCondition.lifeCnt}티끌';
          }
          isZero = false;
        }

        if(tockleCondition.etcCnt > 0) {
          if(!isZero) {
            strEtcCondition = ' & 기타 ${tockleCondition.etcCnt}티끌';
          } else {
            strEtcCondition = '기타 ${tockleCondition.etcCnt}티끌';
          }
          isZero = false;
        }

        if(!isZero) {
          strCondition = strMoneyCondition + strExerciseCondition + strStudyCondition + strRelationshipCondition + strLifeCondition + strEtcCondition;
        }

        String description = isClearTockle ? tockleInfoList[tockleNumber].description : '???';

        tockleElement.add(InkWell(
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
                              Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text(strTockleNumber + ' ' + tockleName, textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),],),
                              SizedBox(height: 5,),
                              SizedBox(width: 200, height: 200, child: widgetTockle,),
                              SizedBox(height: 5,),
                              Text(strCondition, overflow: TextOverflow.visible, textAlign: TextAlign.center,),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(description, overflow: TextOverflow.visible),
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
          child: SizedBox(
            width: tokleImgSizeWidth,
            height: tokleImgSizeHeight,
            child: widgetTockle,
          ),
        ));
      }

      for(int i = 0; i < tockleElement.length; i += 3) {
        tocklesRowList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            i < tockleElement.length ? tockleElement[i] : SizedBox(width: tokleImgSizeWidth, height: tokleImgSizeHeight,),
            i + 1 < tockleElement.length ? tockleElement[i + 1] : SizedBox(width: tokleImgSizeWidth, height: tokleImgSizeHeight,),
            i + 2 < tockleElement.length ? tockleElement[i + 2] : SizedBox(width: tokleImgSizeWidth, height: tokleImgSizeHeight,),
          ],
        ));
      }

      return tocklesRowList;
    }

    Future<String> _fetch() async {
      return 'Call';
    }

    buildTocklesColumn() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder(
            future: checkAccessToken(),
            builder: (context, snaoshot) {
              if(snaoshot.hasData == false) {

              } else if(snaoshot.hasError) {

              } else {

              }
              return Text('data');
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '나의 토끌이들'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '금전',
                      style: TextStyle(
                        color: TTTPrimary4,
                      ),
                    ),
                    Image.asset(
                      'assets/images/money_cnt.png',
                      width: deviceWidth * 0.1,
                    ),
                    Text(
                      '100',
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '운동',
                      style: TextStyle(
                        color: TTTSecondary1,
                      ),
                    ),
                    Image.asset(
                      'assets/images/exercise_cnt.png',
                      width: deviceWidth * 0.1,
                    ),
                    Text(
                      '100',
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '학습',
                      style: TextStyle(
                        color: TTTPrimary5,
                      ),
                    ),
                    Image.asset(
                      'assets/images/study_cnt.png',
                      width: deviceWidth * 0.1,
                    ),
                    Text(
                      '100',
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '관계',
                      style: TextStyle(
                        color: TTTPrimary2,
                      ),
                    ),
                    Image.asset(
                      'assets/images/relationship_cnt.png',
                      width: deviceWidth * 0.1,
                    ),
                    Text(
                      '100',
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '생활',
                      style: TextStyle(
                        color: TTTTeritary1,
                      ),
                    ),
                    Image.asset(
                      'assets/images/life_cnt.png',
                      width: deviceWidth * 0.1,
                    ),
                    Text(
                      '100',
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '기타',
                      style: TextStyle(
                        color: TTTBrown,
                      ),
                    ),
                    Image.asset(
                      'assets/images/etcetera_cnt.png',
                      width: deviceWidth * 0.1,
                    ),
                    Text(
                      '100',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            buildTocklesColumn(),
          ],
        ),
      ),
    );
  }
}