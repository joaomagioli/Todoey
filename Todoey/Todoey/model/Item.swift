//
//  Item.swift
//  Todoey
//
//  Created by Joao Guilherme Magioli on 30/09/2018.
//  Copyright © 2018 Joao Guilherme Magioli. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentingCategory = LinkingObjects(fromType: Category.self, property: "items")
}
