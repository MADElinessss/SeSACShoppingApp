//
//  LoginViewModel.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/22/24.
//

import Foundation

class LoginViewModel {
    
    var inputText = Observable("🐢")
    
    var email = Observable("")
    var password = Observable("")
    var nickname = Observable("")
    var location = Observable("")
    var code = Observable("")
    var result = Observable("")
    
    init() {
        email.bind { value in
            self.validateEmail(value)
        }
        password.bind { value in
            self.validatePassword(value)
        }
        code.bind { value in
            self.validateCode(value)
        }
    }
    
    private func validateEmail(_ email: String) {
        if email.isEmpty {
            result.text = "이메일을 입력해주세요."
        }
    }
    
    private func validatePassword(_ password: String) {
        if password.isEmpty {
            result.text = "비밀번호를 입력해주세요."
        }
    }
    
    private func validateCode(_ code: String) {
        guard let num = Int(code) else {
            result.text = "숫자만 입력해주세요."
            return
        }
        
        if num > 0, num <= 10000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal // 숫자 쉼표 처리
            if format.string(for: num) != nil {
                result.text = "유효한 코드입니다."
            }
        } else {
            result.text = "유효하지 않는 코드입니다."
        }
    }
    
}
