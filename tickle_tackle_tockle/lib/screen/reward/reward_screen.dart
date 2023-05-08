import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import '../../component/common_appbar.dart';
import 'package:tickle_tackle_tockle/const/tockle_list.dart';


class RewardScreen extends StatelessWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;


    const double tokleImgSizeWidth = 110;
    const double tokleImgSizeHeight = 110;

    List<Widget> buildTocklesRow() {
      List<Widget> tocklesRowList = [];
      List<Widget> tockleElement = [];

      int testMoney = 10;
      int testExercise = 10;
      int testsStudy = 10;
      int testRelationship = 10;
      int testLife = 10;
      int testEtc = 10;

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

        if(tockleCondition.exerciseCnt > 0) {
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

    buildTocklesColumn() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buildTocklesRow(),
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