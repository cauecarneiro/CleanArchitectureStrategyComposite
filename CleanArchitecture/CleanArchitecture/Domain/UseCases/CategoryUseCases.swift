//
//  CategoryUseCases.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation

class CategoryUseCases {
    private let repository: CategoryRepositoryProtocol
    
    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllCategories() async throws -> [Category] {
        return try await repository.fetchCategories()
    }
    
    func addCategory(name: String, parentId: UUID? = nil) async throws {
        let category = Category(name: name, parentId: parentId)
        try await repository.addCategory(category)
    }
    
    func removeCategory(_ category: Category) async throws {
        try await repository.deleteCategory(category)
    }
}



