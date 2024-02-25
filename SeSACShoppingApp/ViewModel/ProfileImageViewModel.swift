//
//  ProfileImageViewModel.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/25/24.
//

import Foundation

// MARK: - 프로필 이미지 선택 뷰모델
class ProfileImageSelectViewModel {
    
    var selectedImage = Observable("profile1")
    
    func saveSelectedImage() {
        UserDefaultsManager.shared.selectedImage = selectedImage.value
    }
    
    func loadSavedImage() {
        selectedImage.value = UserDefaultsManager.shared.selectedImage
    }
}
