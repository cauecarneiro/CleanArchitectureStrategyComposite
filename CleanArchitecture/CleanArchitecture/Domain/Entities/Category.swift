//
//  Category.swift
//  CleanArchitecture
//
//  Enterprise Business Rules - Entity
//

import Foundation

/// Entidade de domínio representando uma Categoria
/// Suporta hierarquia (Composite pattern será aplicado na camada de adaptadores)
struct Category: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var parentId: UUID?
    
    init(id: UUID = UUID(), name: String, parentId: UUID? = nil) {
        self.id = id
        self.name = name
        self.parentId = parentId
    }
}


