//
//  SettingViewModel.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/25/24.
//

import Foundation

class SettingViewModel {
    
    var selectedImage = Observable<String>(UserDefaultsManager.shared.selectedImage)
    
    init() {
        selectedImage.bind { newValue in
            UserDefaultsManager.shared.selectedImage = newValue
        }
    }
    
    func updateSelectedImage(to imageName: String) {
        selectedImage.value = imageName
    }
}

