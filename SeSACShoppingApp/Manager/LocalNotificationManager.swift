//
//  LocalNotificationManager.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/23/24.
//

import UIKit

struct LocalNotificationManager {
    
    func setNotification() {
        // MARK: Notification 1. Content
        let content = UNMutableNotificationContent()
        let body = "찜한 상품을 구매해보세여!"
        
        // MARK: Notification 2. Trigger
        // 📅 Calendar Trigger
        let currentDate = Date()
        
        var component = DateComponents()
        component.hour = 19
        component.minute = 26
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        let weekdayString = dateFormatter.string(from: currentDate)
        
        content.title = "(광고) 🛒 \(weekdayString)은 쇼핑의 날!"
        content.body = body
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        // MARK: Notification 3. Request
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: calendarTrigger)
        
        // MARK: Notification 4. iOS System에게 전달
        UNUserNotificationCenter.current().add(request)
    }
}
