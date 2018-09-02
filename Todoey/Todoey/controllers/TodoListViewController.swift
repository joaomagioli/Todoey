//
//  ViewController.swift
//  Todoey
//
//  Created by Joao Guilherme Magioli on 31/08/2018.
//  Copyright © 2018 Joao Guilherme Magioli. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"ToDoItemCell")
        
        let newItem1 = ItemModel()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = ItemModel()
        newItem2.title = "Eat Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = ItemModel()
        newItem3.title = "Destroy demogorgon"
        itemArray.append(newItem3)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done =  !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var addNewItemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) {
            (action) in
            
            let addedItem = ItemModel()
            addedItem.title = addNewItemTextField.text ?? ""
            
            self.itemArray.append(addedItem)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            addNewItemTextField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

