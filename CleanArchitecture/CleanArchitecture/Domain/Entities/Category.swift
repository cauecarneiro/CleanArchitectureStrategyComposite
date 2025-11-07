//
//  Category.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation

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



