//
//  CategoryRepository.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation
import SwiftData


class CategoryRepository: CategoryRepositoryProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchCategories() async throws -> [Category] {
        let descriptor = FetchDescriptor<CategoryModel>()
        let models = try modelContext.fetch(descriptor)
        
        if models.isEmpty {
            let categories = try JSONDataLoader.loadCategories()
            for category in categories {
                let model = CategoryModel(from: category)
                modelContext.insert(model)
            }
            try modelContext.save()
            return categories
        }
        
        return models.map { Category(from: $0) }
    }
    
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

extension Category {
    init(from model: CategoryModel) {
        self.init(
            id: model.id,
            name: model.name,
            parentId: model.parentId
        )
    }
}



