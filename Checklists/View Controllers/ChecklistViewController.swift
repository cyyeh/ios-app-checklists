//
//  ViewController.swift
//  Checklists
//
//  Created by ChihYu Yeh on 2019/4/15.
//  Copyright © 2019 cyyeh. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  var checklist: Checklist!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = checklist.name
  }

  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    if item.checked {
      label.text = "✔︎"
    } else {
      label.text = ""
    }
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    let dueDateLabel = cell.viewWithTag(1002) as! UILabel
    label.text = item.text
    dueDateLabel.text = dateToString(date: item.dueDate)
  }
  
  // MARK:- Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checklist.items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    let item = checklist.items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    checklist.items.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  // MARK:- Table View Delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = checklist.items[indexPath.row]
      item.toggleChecked()
      
      configureCheckmark(for: cell, with: item)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK:- Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = checklist.items[indexPath.row]
      }
    }
  }
  
  // MARK:- Add Item ViewController Delegate
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
    checklist.items.append(item)
    checklist.sortChecklistitems()
    tableView.reloadData()
    
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
    checklist.sortChecklistitems()
    tableView.reloadData()

    navigationController?.popViewController(animated: true)
  }
}

