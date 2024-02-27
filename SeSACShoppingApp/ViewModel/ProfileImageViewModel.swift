//
//  ProfileImageViewModel.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/25/24.
//

import Foundation

// MARK: - 프로필 이미지 선택 뷰모델
final class ProfileImageSelectViewModel {
    
    let selectedImage = Observable("\(UserDefaultsManager.shared.selectedImage)")
    var profileButtonTapped: Observable<String> = Observable("")
    
    init() {
        profileButtonTapped.bind { value in
            self.saveSelectedImage(value)
        }
    }
    
    /*
     MARK: 🦅 Refactoring point:
     초기 output.value = loadSaveIamge()
     input: buttonTapped<Int> ---> output: prfile + "index"
                               ㄴ saveImag
     */
    
    
    private func saveSelectedImage(_ value: String) {
        selectedImage.value = value
        UserDefaultsManager.shared.selectedImage = selectedImage.value
    }
}
