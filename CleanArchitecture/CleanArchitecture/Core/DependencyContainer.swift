//
//  DependencyContainer.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 05/11/25.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class DependencyContainer: ObservableObject {
    let productUseCases: ProductUseCases
    let categoryUseCases: CategoryUseCases
    let productRepository: ProductRepository
    let categoryRepository: CategoryRepository
    
    init(modelContext: ModelContext) {
        
        productRepository = ProductRepository(modelContext: modelContext)
        categoryRepository = CategoryRepository(modelContext: modelContext)
        
        
        productUseCases = ProductUseCases(repository: productRepository)
        categoryUseCases = CategoryUseCases(repository: categoryRepository)
    }
    
    
    func setProductSortStrategy(_ strategy: SortStrategy) {
        productRepository.setSortStrategy(strategy)
    }
}

