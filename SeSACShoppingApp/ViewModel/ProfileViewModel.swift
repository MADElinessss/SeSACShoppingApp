//
//  ProfileViewModel.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/25/24.
//

import Foundation

class ProfileViewModel {
    
    var savedProfileImage = Observable("")
    var fetchedProfileImage = Observable("")
    
    init() {
        savedProfileImage.bind { value in
            self.fetchSavedProfileImage()
        }
    }
    
    private func fetchSavedProfileImage() {
        fetchedProfileImage.value = UserDefaultsManager.shared.selectedImage
    }
}
