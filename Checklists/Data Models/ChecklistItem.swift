//
//  ChecklistItem.swift
//  Checklists
//
//  Created by ChihYu Yeh on 2019/4/15.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
  var text: String
  var checked: Bool
  var dueDate: Date
  var shouldRemind: Bool
  var itemID = -1
  
  init(text: String = "to do item", checked: Bool = false, shouldRemind: Bool = false, dueDate: Date = Date()) {
    self.text = text
    self.checked = checked
    self.itemID = DataModel.nextChecklistItemID()
    self.shouldRemind = shouldRemind
    self.dueDate = dueDate
    super.init()
  }
  
  deinit {
    removeNotification()
  }
  
  func toggleChecked() {
    checked = !checked
  }
  
  func scheduleNotification() {
    removeNotification()
    if shouldRemind && dueDate > Date() {
      let content = UNMutableNotificationContent()
      content.title = "Reminder:"
      content.body = text
      content.sound = .default
      
      let calender = Calendar(identifier: .gregorian)
      let components = calender.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
      
      let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
      
      let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
      
      let center = UNUserNotificationCenter.current()
      center.add(request)
      
      print("Scheduled: \(request) for itemID: \(itemID)")
    }
  }
  
  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
  }
}
