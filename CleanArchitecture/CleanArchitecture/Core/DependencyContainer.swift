//
//  DependencyContainer.swift
//  CleanArchitecture
//
//  Core - Dependency Injection
//

import Foundation
import SwiftData
import SwiftUI
import Combine

/// Container de dependências para injeção
/// Conecta todas as camadas da arquitetura
class DependencyContainer: ObservableObject {
    let productUseCases: ProductUseCases
    let categoryUseCases: CategoryUseCases
    let productRepository: ProductRepository
    let categoryRepository: CategoryRepository
    
    init(modelContext: ModelContext) {
        // Cria repositórios (Interface Adapters)
        productRepository = ProductRepository(modelContext: modelContext)
        categoryRepository = CategoryRepository(modelContext: modelContext)
        
        // Cria use cases (Application Business Rules)
        // Eles recebem os protocolos, não as implementações concretas
        productUseCases = ProductUseCases(repository: productRepository)
        categoryUseCases = CategoryUseCases(repository: categoryRepository)
    }
    
    /// Configura a estratégia de ordenação no repositório
    func setProductSortStrategy(_ strategy: SortStrategy) {
        productRepository.setSortStrategy(strategy)
    }
}

