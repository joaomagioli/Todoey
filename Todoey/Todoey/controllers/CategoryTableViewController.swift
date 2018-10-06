//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Joao Guilherme Magioli on 22/09/2018.
//  Copyright © 2018 Joao Guilherme Magioli. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier:"CategoryCell")
        self.tableView.rowHeight = 60.0
        
        loadCategories()
    }
    
    // MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added"
        
        cell.delegate = self
        
        return cell

    }
    
    // MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // MARK: - Tableview data manipulation methods
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
       
    }
    
    func saveCategories(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving categories: \(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Add category items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
        let newCategory = Category()
            
        guard let textField = alert.textFields?.first,
            let newItemTitle = textField.text else {
                return
        }
            
        newCategory.name = newItemTitle
        self.saveCategories(category: newCategory)
        
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}

// MARK: - Swipe delegate methods
extension CategoryTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let categoryForDeletion = self.categories?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(categoryForDeletion)
                    }
                } catch {
                    print("Sorry, it was not possible to delete item: \(error)")
                }
            }
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }

}
