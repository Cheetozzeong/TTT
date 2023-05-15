package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.common.CommonEnum;
import com.a804.tictactoc.ttt.db.entity.PushLogs;
import com.a804.tictactoc.ttt.db.repository.PushLogsRepo;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Dictionary;

@Service
@AllArgsConstructor
public class PushServiceImpl implements PushService {

    private FirebaseMessaging firebaseMessaging;
    private FirebaseAuth firebaseAuth;
    private final RedisTemplate redisTemplate;

    PushLogsRepo pushLogsRepo;

//    public PushServiceImpl(FirebaseMessaging firebaseMessaging,FirebaseAuth firebaseAuth) {
//        this.firebaseMessaging = firebaseMessaging;
//        this.firebaseAuth = firebaseAuth;
//    }


    @Override
    public boolean SendPush(String title, String sendMessage, String deviceToken, CommonEnum.PushType type, long userId, String uid){
        boolean result = true;

        try{

            Notification notification = Notification
                    .builder()
                    .setTitle(title)
                    .setBody(sendMessage)
                    .build();

            Message message = null;

            if(type == CommonEnum.PushType.WATCH){  // watch는 토큰값이 필요하다!

//                User user = userRepository.findByUid(uid);
                String rT = "";
                String aT = "";
                try {
                    rT = (String)redisTemplate.opsForValue().get("RT:" + uid);
                    aT = (String)redisTemplate.opsForValue().get("AT:" + uid);
                    System.out.println("리프레시 : " + rT);
                    System.out.println("엑세스 : " + aT);

                    message = Message
                            .builder()
                            .putData("score","이치헌머하삼?ㅋㅋㅋㅋㅋ푸하하하")
                            .putData("accessToken",aT)
                            .putData("refreshToken",rT)
                            .putData("happy","✨✨✨✨✨")
                            .setNotification(notification)
                            .setToken(deviceToken)
                            .build();

                } catch (Exception ex) { // 로그아웃해서 레디스에 리프레시 토큰이 없으면
                    System.out.println("레디스에서 토큰 가져오기 실패 ㅠㅠ : " + ex.toString());
//                    response.put("message", "Refresh Token이 유효하지 않습니다.");
//                    return response;
                }
            }
            else{

                message = Message
                        .builder()
                        .putData("happy","✨✨✨✨✨")
                        .setNotification(notification)
                        .setToken(deviceToken)
                        .build();
            }

            if(message != null ){

                String response = firebaseMessaging.send(message);

                pushLogsRepo.save(new PushLogs(0,userId, title, sendMessage, deviceToken, type.toString(), response ));

                System.out.println(response);
            }
        }
        catch (Exception ex){
            result = false;
            System.out.println(ex.toString());
        }

        return result;
    }
}
