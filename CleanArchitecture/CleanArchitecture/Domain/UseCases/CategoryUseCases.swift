//
//  CategoryUseCases.swift
//  CleanArchitecture
//
//  Application Business Rules - Use Cases
//

import Foundation

/// Casos de uso relacionados a categorias
/// Define O QUE fazer, não COMO fazer
class CategoryUseCases {
    private let repository: CategoryRepositoryProtocol
    
    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Busca todas as categorias
    func getAllCategories() async throws -> [Category] {
        return try await repository.fetchCategories()
    }
    
    /// Adiciona uma nova categoria
    func addCategory(name: String, parentId: UUID? = nil) async throws {
        let category = Category(name: name, parentId: parentId)
        try await repository.addCategory(category)
    }
    
    /// Remove uma categoria
    func removeCategory(_ category: Category) async throws {
        try await repository.deleteCategory(category)
    }
}


