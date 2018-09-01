//
//  ViewController.swift
//  Todoey
//
//  Created by Joao Guilherme Magioli on 31/08/2018.
//  Copyright © 2018 Joao Guilherme Magioli. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"ToDoItemCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) 
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }

    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var addNewItemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) {
            (action) in
            
            self.itemArray.append(addNewItemTextField.text ?? "")
            
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

