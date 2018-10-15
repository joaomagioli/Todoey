//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Joao Guilherme Magioli on 06/10/2018.
//  Copyright © 2018 Joao Guilherme Magioli. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier:Constants.cellIdentificer)
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none

    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentificer, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: Constants.delete) { action, indexPath in
            self.updateModel(at: indexPath)
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
        
    }
    
    func updateModel(at indexPath: IndexPath) {
        // Update model
    }

}
