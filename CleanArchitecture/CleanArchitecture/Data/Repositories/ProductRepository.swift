//
//  ProductRepository.swift
//  CleanArchitecture
//
//  Interface Adapters - Repository Implementation
//

import Foundation
import SwiftData

/// Implementação concreta do repositório de produtos
/// Integra SwiftData e JSON, aplica Strategy pattern para ordenação
class ProductRepository: ProductRepositoryProtocol {
    private let modelContext: ModelContext
    private var sortStrategy: SortStrategy = SortByNameStrategy()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// Define a estratégia de ordenação (Strategy Pattern)
    func setSortStrategy(_ strategy: SortStrategy) {
        self.sortStrategy = strategy
    }
    
    func fetchProducts() async throws -> [Product] {
        // Primeiro, tenta carregar do SwiftData
        let descriptor = FetchDescriptor<ProductModel>()
        let models = try modelContext.fetch(descriptor)
        
        if models.isEmpty {
            // Se não houver dados, carrega do JSON e salva no SwiftData
            let products = try JSONDataLoader.loadProducts()
            for product in products {
                let model = ProductModel(from: product)
                modelContext.insert(model)
            }
            try modelContext.save()
            return sortStrategy.sort(products)
        }
        
        // Converte modelos SwiftData para entidades de domínio
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

// MARK: - Helper Extensions
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


