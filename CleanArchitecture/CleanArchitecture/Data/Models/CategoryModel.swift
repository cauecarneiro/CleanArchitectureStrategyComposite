//
//  CategoryModel.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - SwiftData Model
//

import Foundation
import SwiftData

/// Modelo SwiftData para persistência de categorias
/// Esta é a representação técnica, não a entidade de domínio
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


