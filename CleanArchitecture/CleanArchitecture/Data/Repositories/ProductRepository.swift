//
//  ProductRepository.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation
import SwiftData

class ProductRepository: ProductRepositoryProtocol {
    private let modelContext: ModelContext
    private var sortStrategy: SortStrategy = SortByNameStrategy()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func setSortStrategy(_ strategy: SortStrategy) {
        self.sortStrategy = strategy
    }
    
    func fetchProducts() async throws -> [Product] {
        let descriptor = FetchDescriptor<ProductModel>()
        let models = try modelContext.fetch(descriptor)
        
        if models.isEmpty {
            let products = try JSONDataLoader.loadProducts()
            for product in products {
                let model = ProductModel(from: product)
                modelContext.insert(model)
            }
            try modelContext.save()
            return sortStrategy.sort(products)
        }
        
        let products = models.map { Product(from: $0) }
        return sortStrategy.sort(products)
    }
    
    func fetchProducts(by categoryId: UUID) async throws -> [Product] {
        let allProducts = try await fetchProducts()
        return allProducts.filter { $0.categoryId == categoryId }
    }
    
    func addProduct(_ product: Product) async throws {
        let model = ProductModel(from: product)
        modelContext.insert(model)
        try modelContext.save()
    }
    
    func deleteProduct(_ product: Product) async throws {
        let descriptor = FetchDescriptor<ProductModel>(
            predicate: #Predicate { $0.id == product.id }
        )
        let models = try modelContext.fetch(descriptor)
        for model in models {
            modelContext.delete(model)
        }
        try modelContext.save()
    }
}

extension Product {
    init(from model: ProductModel) {
        self.init(
            id: model.id,
            name: model.name,
            price: model.price,
            categoryId: model.categoryId
        )
    }
}



