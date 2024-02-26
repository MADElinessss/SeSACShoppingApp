//
//  SearchResultViewModel.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/26/24.
//

import Foundation

class SearchResultViewModel {

    var inputKeyword: Observable<String> = Observable("")
    var inputPage: Observable<Int> = Observable(1)
    
    var outputItems: Observable<[Item]> = Observable([])
    var outputTotalCountLabel: Observable<String> = Observable("")
    
    // MARK: fetchItems - API 호출 및 데이터 가져오기
    func fetchItems(sort: String) {
        
        APISessionManager.shared.callRequest(type: Search.self, keyword: inputKeyword.value, sort: sort, page: 1) { item, error in
 
            guard let item = item else { return }
            
            if self.inputPage.value == 1 {
                self.outputItems.value = item.items ?? []
            } else {
                self.outputItems.value.append(contentsOf: item.items ?? [])
            }
            
            if let totalNumber = item.total {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                let formattedCount = formatter.string(from: NSNumber(value: totalNumber)) ?? "\(totalNumber)"
                self.outputTotalCountLabel.value = "\(formattedCount)개의 검색 결과"
            }
        }
    }
    
}
