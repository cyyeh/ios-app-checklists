//
//  Checklist.swift
//  Checklists
//
//  Created by ChihYu Yeh on 2019/4/15.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
  static let icons = [ "No Icon", "Appointments", "Birthdays", "Chores",
                       "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips" ]
  var iconName: String
  var name: String
  var items = [ChecklistItem]()
  
  init(name: String, iconName: String = "No Icon") {
    self.name = name
    self.iconName = iconName
    super.init()
  }
  
  func countUncheckedItems() -> Int {
    // functional programming way
    // return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    
    var count = 0
    for item in items where !item.checked {
      count += 1
    }
    return count
  }
}
