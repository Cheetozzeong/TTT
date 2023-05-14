import 'package:flutter/material.dart';

List<Widget> tockleImgList = [
  Image.asset('assets/images/tockles/toc_unknown.png'),
  Image.asset('assets/images/tockles/toc_00.png'),
  Image.asset('assets/images/tockles/toc_01.png'),
  Image.asset('assets/images/tockles/toc_02.png'),
  Image.asset('assets/images/tockles/toc_03.png'),
  Image.asset('assets/images/tockles/toc_04.png'),
  Image.asset('assets/images/tockles/toc_05.png'),
  Image.asset('assets/images/tockles/toc_06.png'),
  Image.asset('assets/images/tockles/toc_07.png'),
  Image.asset('assets/images/tockles/toc_08.png'),
  Image.asset('assets/images/tockles/toc_09.png'),
  Image.asset('assets/images/tockles/toc_10.png'),
  Image.asset('assets/images/tockles/toc_11.png'),
  Image.asset('assets/images/tockles/toc_12.png'),
  Image.asset('assets/images/tockles/toc_13.png'),
  Image.asset('assets/images/tockles/toc_14.png'),
  Image.asset('assets/images/tockles/toc_15.png'),
  Image.asset('assets/images/tockles/toc_16.png'),
  Image.asset('assets/images/tockles/toc_17.png'),
  Image.asset('assets/images/tockles/toc_18.png'),
  Image.asset('assets/images/tockles/toc_19.png'),
  Image.asset('assets/images/tockles/toc_20.png'),
  Image.asset('assets/images/tockles/toc_21.png'),
  Image.asset('assets/images/tockles/toc_22.png'),
  Image.asset('assets/images/tockles/toc_23.png'),
  Image.asset('assets/images/tockles/toc_24.png'),
  Image.asset('assets/images/tockles/toc_25.png'),
  Image.asset('assets/images/tockles/toc_26.png'),
  Image.asset('assets/images/tockles/toc_27.png'),
  Image.asset('assets/images/tockles/toc_28.png'),
  Image.asset('assets/images/tockles/toc_29.png'),
  Image.asset('assets/images/tockles/toc_30.png'),
  Image.asset('assets/images/tockles/toc_31.png'),
  Image.asset('assets/images/tockles/toc_32.png'),
  Image.asset('assets/images/tockles/toc_33.png'),
  Image.asset('assets/images/tockles/toc_34.png'),
  Image.asset('assets/images/tockles/toc_35.png'),
  Image.asset('assets/images/tockles/toc_36.png'),
];

class TockleInfo {
  int index = 0;            // 번호
  String name = '';         // 이름
  String description = '';  // 설명

  TockleInfo(this.index, this.name, this.description);
}

List<TockleInfo> tockleInfoList = [
  TockleInfo(0, '주니어 토끌이', '유년기의 토끌이 입니다. 팔과 다리는 짧아서 보이지 않습니다.'),
  TockleInfo(1, '헬린이 토끌이', '아직 헬스에 초보인 토끌이 입니다.\n이두근에 집착을 보이고 있습니다.'),
  TockleInfo(2, '러너 토끌이', '"유산소 운동 중입니다.\n숨차니까 말걸지 마세요"'),
  TockleInfo(3, '테니스 토끌이', '영국 주니어 테니스 대회 출신 토끌이입니다.'),
  TockleInfo(4, '3번 타자 토끌이', '"아이콩"'),
  TockleInfo(5, '헬창 토끌이', '"프로틴!!!"'),
  TockleInfo(6, '만원 토끌이', '"나랏말싸미 듕귁에 달아.."'),
  TockleInfo(7, '플렉스 토끌이', '"플렉스! 롤렉스! 엑스박스! 비트박스! Yo!"'),
  TockleInfo(8, '독서왕 토끌이', '"책은 마음의 양식.."'),
  TockleInfo(9, '졸업식 토끌이', '"공부가 제일 쉬웠어요 ㅋ"'),
  TockleInfo(10, '생일 파티 토끌이', '생일 축하해요~~ 맞을 준비는 됐죠?'),
  TockleInfo(11, '토끌즈', '"와글와글"'),
  TockleInfo(12, '물 마시는 토끌이', '매 식사 전 물을 500mL씩 마시면 다이어트 효과를 볼 수 있대요.'),
  TockleInfo(13, '키다리 토끌이', '"높은 곳은 산소가 희박하군."'),
  TockleInfo(14, '화관 토끌이', '"저 예쁘죠?"'),
  TockleInfo(15, '뽀송뽀송 토끌이', '표백제를 바디워시로 착각했어요.'),
  TockleInfo(16, '노래하는 토끌이', '이 토끌이의 18번은 "먼지가 되어"입니다.'),
  TockleInfo(17, '초롱초롱 토끌이', '"반짝반짝"'),
  TockleInfo(18, '통화하는 토끌이', '여보세요~ 나야~ 거기 잘 지내니~'),
  TockleInfo(19, '카페인 중독 토끌이', '"쪼오오오옵"'),
  TockleInfo(20, '트라이앵글 토끌이', '이 토끌이는 트라이앵글로 왕벌의 비행을 연주할 수 있습니다.'),
  TockleInfo(21, '기타리스트 토끌이', '링딩동~ 링딩동~ 링디기디기딩딩딩'),
  TockleInfo(22, '드러머 토끌이', '"두둥 탁!"'),
  TockleInfo(23, '킹왕짱 토끌이', '"짐이 곧 국가니라..."'),
  TockleInfo(24, '영화 관람 토끌이', '"두근 두근"\n"와작 와작"'),
  TockleInfo(25, '게이머 토끌이', '"히히 신상겜 사러 가야겠당"'),
  TockleInfo(26, '크리스마스 토끌이', '"사실 내 코는 빨간 콩이다."'),
  TockleInfo(27, '베투반 토끌이', '자신의 연주에 취해있는 토끌이입니다. 페달에 발이 못닿는 건 모른 척해주세요.'),
  TockleInfo(28, '돌로 만든 토끌이', '"내 인생 이제 시작이고 난!!!!!!\n으아아 떨어진다~~"'),
  TockleInfo(29, '덕후 토끌이', '"오레와 와타시다...오레가 마모루!"'),
  TockleInfo(30, '토끌이 아부지', '토끌이는 토끌이의 붓 끝에서 탄생합니다.'),
  TockleInfo(31, '뻬이커 토끌이', '"불 좀 꺼줄래..? 아 꺼져있네;"'),
  TockleInfo(32, '화학자 토끌이', '오마에와 모 신데이루.... Na Ni !!!'),
  TockleInfo(33, '최끌', '"당신 왜이렇게 안착해?\n내 마음 속에 안착♥"'),
  TockleInfo(34, '마법사 토끌이', '"윙가르디옹 레비오~우사"'),
  TockleInfo(35, '라이더 토끌이', '"난 바람보다 빠르다.. 헥헥"'),
  TockleInfo(36, '무지개 토끌이', '비오는 다음 날 모습을 드러냅니다. 누군가의 토가 아닙니다..!'),
];

class TockleCondition {
  int index = 0;
  int moneyCnt = 0;
  int exerciseCnt = 0;
  int studyCnt = 0;
  int relationshipCnt = 0;
  int lifeCnt = 0;
  int etcCnt = 0;

  TockleCondition({required this.index, required this.moneyCnt, required this.exerciseCnt, required this.studyCnt, required this.relationshipCnt, required this.lifeCnt, required this.etcCnt});
}

List<TockleCondition> tockleConditionList = [
  TockleCondition(index: 0, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 1, moneyCnt: 0, exerciseCnt: 1, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 2, moneyCnt: 0, exerciseCnt: 1, studyCnt: 0, relationshipCnt: 0, lifeCnt: 1, etcCnt: 0,),
  TockleCondition(index: 3, moneyCnt: 0, exerciseCnt: 3, studyCnt: 0, relationshipCnt: 3, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 4, moneyCnt: 0, exerciseCnt: 5, studyCnt: 0, relationshipCnt: 5, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 5, moneyCnt: 0, exerciseCnt: 5, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 6, moneyCnt: 1, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 7, moneyCnt: 5, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 8, moneyCnt: 0, exerciseCnt: 0, studyCnt: 1, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 9, moneyCnt: 0, exerciseCnt: 0, studyCnt: 5, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 10, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 1, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 11, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 5, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 12, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 3, etcCnt: 3,),
  TockleCondition(index: 13, moneyCnt: 0, exerciseCnt: 3, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 3,),
  TockleCondition(index: 14, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 5, lifeCnt: 5, etcCnt: 5,),
  TockleCondition(index: 15, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 10, etcCnt: 0,),
  TockleCondition(index: 16, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 8, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 17, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 18, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 19, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 20, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 21, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 1,),
  TockleCondition(index: 22, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 23, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 24, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 25, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 26, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 27, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 28, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 29, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 30, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 31, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 32, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 33, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 34, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 35, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
  TockleCondition(index: 36, moneyCnt: 0, exerciseCnt: 0, studyCnt: 0, relationshipCnt: 0, lifeCnt: 0, etcCnt: 0,),
];