//
//  CategoryModel.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 05/11/25.
//

import Foundation
import SwiftData

@Model
final class CategoryModel {
    var id: UUID
    var name: String
    var parentId: UUID?
    
    init(id: UUID, name: String, parentId: UUID? = nil) {
        self.id = id
        self.name = name
        self.parentId = parentId
    }
    
    convenience init(from category: Category) {
        self.init(
            id: category.id,
            name: category.name,
            parentId: category.parentId
        )
    }
}



