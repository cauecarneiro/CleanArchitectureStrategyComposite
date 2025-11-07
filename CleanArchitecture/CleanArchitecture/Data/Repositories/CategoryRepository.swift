//
//  CategoryRepository.swift
//  CleanArchitecture
//
//  Interface Adapters - Repository Implementation
//

import Foundation
import SwiftData

/// Implementação concreta do repositório de categorias
/// Integra SwiftData e JSON, aplica Composite pattern para hierarquia
class CategoryRepository: CategoryRepositoryProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchCategories() async throws -> [Category] {
        // Primeiro, tenta carregar do SwiftData
        let descriptor = FetchDescriptor<CategoryModel>()
        let models = try modelContext.fetch(descriptor)
        
        if models.isEmpty {
            // Se não houver dados, carrega do JSON e salva no SwiftData
            let categories = try JSONDataLoader.loadCategories()
            for category in categories {
                let model = CategoryModel(from: category)
                modelContext.insert(model)
            }
            try modelContext.save()
            return categories
        }
        
        // Converte modelos SwiftData para entidades de domínio
        return models.map { Category(from: $0) }
    }
    
    /// Retorna a árvore de categorias usando Composite pattern
    func fetchCategoryTree() async throws -> [CategoryComponent] {
        let categories = try await fetchCategories()
        return CategoryTreeBuilder.buildTree(from: categories)
    }
    
    func addCategory(_ category: Category) async throws {
        let model = CategoryModel(from: category)
        modelContext.insert(model)
        try modelContext.save()
    }
    
    func deleteCategory(_ category: Category) async throws {
        let descriptor = FetchDescriptor<CategoryModel>(
            predicate: #Predicate { $0.id == category.id }
        )
        let models = try modelContext.fetch(descriptor)
        for model in models {
            modelContext.delete(model)
        }
        try modelContext.save()
    }
}

// MARK: - Helper Extensions
extension Category {
    init(from model: CategoryModel) {
        self.init(
            id: model.id,
            name: model.name,
            parentId: model.parentId
        )
    }
}


