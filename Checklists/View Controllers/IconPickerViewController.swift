//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by ChihYu Yeh on 2019/4/15.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
  func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

class IconPickerViewController: UITableViewController {
  weak var delegate: IconPickerViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK:- Table View Delegate
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataModel.icons.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
    let iconName = DataModel.icons[indexPath.row]
    cell.textLabel!.text = iconName
    cell.imageView!.image = UIImage(named: iconName)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let delegate = delegate {
      let iconName = DataModel.icons[indexPath.row]
      delegate.iconPicker(self, didPick: iconName)
    }
  }
}
