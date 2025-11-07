//
//  ProductViewModel.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 07/11/25.
//

import Foundation
import SwiftUI
import SwiftData
import Combine

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var showAddProduct = false
    @Published var selectedSortStrategy: Int = 0
    
    private var productUseCases: ProductUseCases?
    private var categoryUseCases: CategoryUseCases?
    private var dependencyContainer: DependencyContainer?
    
    init() {
    }
    
    func setup(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
        self.productUseCases = dependencyContainer.productUseCases
        self.categoryUseCases = dependencyContainer.categoryUseCases
    }
    
    func loadProducts() async {
        guard let useCases = productUseCases else { return }
        do {
            products = try await useCases.getAllProducts()
        } catch {
            print("Erro ao carregar produtos: \(error)")
        }
    }
    
    func loadCategories() async throws -> [Category] {
        guard let useCases = categoryUseCases else { return [] }
        return try await useCases.getAllCategories()
    }
    
    func addProduct(name: String, price: Double, categoryId: UUID) async {
        guard let useCases = productUseCases else { return }
        do {
            try await useCases.addProduct(name: name, price: price, categoryId: categoryId)
            await loadProducts()
        } catch {
            print("Erro ao adicionar produto: \(error)")
        }
    }
    
    func deleteProducts(at offsets: IndexSet) {
        Task {
            guard let useCases = productUseCases else { return }
            for index in offsets {
                let product = products[index]
                do {
                    try await useCases.removeProduct(product)
                } catch {
                    print("Erro ao remover produto: \(error)")
                }
            }
            await loadProducts()
        }
    }
    
    func changeSortStrategy(_ index: Int) {
        guard let container = dependencyContainer else { return }
        
        // Aplica Strategy pattern baseado na seleção
        let strategy: SortStrategy
        switch index {
        case 0:
            strategy = SortByNameStrategy()
        case 1:
            strategy = SortByPriceStrategy()
        case 2:
            strategy = SortByPriceDescendingStrategy()
        default:
            strategy = SortByNameStrategy()
        }
        
        container.setProductSortStrategy(strategy)
        
        Task {
            await loadProducts()
        }
    }
}

