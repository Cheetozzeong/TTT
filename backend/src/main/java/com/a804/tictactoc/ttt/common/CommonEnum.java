package com.a804.tictactoc.ttt.common;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

public class CommonEnum {
    public enum Config {
        push_alarm
    }

    @AllArgsConstructor
    public enum Result{
        SUCCESS(0,"SUCCESS"),
        FAIL(100,"FAIL");

        private final int code;
        private final String name;
    }

//    @AllArgsConstructor
//    @Getter
//    @JsonFormat(shape = JsonFormat.Shape.OBJECT) // api 호출시 Enum 전체 반환
//    public enum SearchType{
//        NAME(0,"성공"),
//        SUBJECT(1,"실패"),
//        CONTENTS("CONTENTS","내용"),
//        ID("ID","아이디");
//
//        private final int code;
//        private final String value;
//
//        public static boolean IsSearchTypeByCode(String code){
//            for(SearchType value : values()){
//                if(value.getCode().equals(code)){
//                    return true;
//                }
//            }
//            return false;
//        }
//
//    }
}
