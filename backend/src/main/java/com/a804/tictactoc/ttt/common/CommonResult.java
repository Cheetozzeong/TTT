package com.a804.tictactoc.ttt.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class CommonResult {
    // 결과값
    public CommonEnum.Result code;
    // 결과 텍스트
    public String value;
    // 사용자에게 보여줄 메세지
    public String Message;
    public CommonResult(CommonEnum.Result code,String Message ){
        this.setCode(code);
        this.setMessage(Message);
    }

    public String getValue() {
        return code.name();
    }
}
