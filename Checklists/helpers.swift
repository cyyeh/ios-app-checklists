//
//  helpers.swift
//  Checklists
//
//  Created by ChihYu Yeh on 2019/4/16.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import Foundation

public func dateToString(date: Date) -> String {
  let formatter = DateFormatter()
  formatter.dateStyle = .medium
  formatter.timeStyle = .short
  return formatter.string(from: date)
}
