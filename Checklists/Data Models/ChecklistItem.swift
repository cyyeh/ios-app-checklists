//
//  ChecklistItem.swift
//  Checklists
//
//  Created by ChihYu Yeh on 2019/4/15.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
  var text: String
  var checked: Bool
  
  init(text: String = "to do item", checked: Bool = false) {
    self.text = text
    self.checked = checked
    super.init()
  }
  
  func toggleChecked() {
    checked = !checked
  }
}
