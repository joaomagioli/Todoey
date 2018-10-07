//
//  Category.swift
//  Todoey
//
//  Created by Joao Guilherme Magioli on 30/09/2018.
//  Copyright © 2018 Joao Guilherme Magioli. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
