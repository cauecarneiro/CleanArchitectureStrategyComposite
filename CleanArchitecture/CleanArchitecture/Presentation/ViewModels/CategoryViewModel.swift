//
//  CategoryViewModel.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - ViewModel
//

import Foundation
import SwiftUI
import SwiftData
import Combine

@MainActor
class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var categoryTree: [CategoryComponent] = []
    @Published var showAddCategory = false
    
    private var categoryUseCases: CategoryUseCases?
    private var categoryRepository: CategoryRepository?
    
    init() {
        // A injeção de dependência será feita via environment
    }
    
    func setup(dependencyContainer: DependencyContainer) {
        self.categoryUseCases = dependencyContainer.categoryUseCases
        self.categoryRepository = dependencyContainer.categoryRepository
    }
    
    func loadCategories() async {
        guard let useCases = categoryUseCases else { return }
        do {
            categories = try await useCases.getAllCategories()
            
            // Converte para árvore usando Composite pattern
            categoryTree = CategoryTreeBuilder.buildTree(from: categories)
        } catch {
            print("Erro ao carregar categorias: \(error)")
        }
    }
    
    func addCategory(name: String, parentId: UUID?) async {
        guard let useCases = categoryUseCases else { return }
        do {
            try await useCases.addCategory(name: name, parentId: parentId)
            await loadCategories()
        } catch {
            print("Erro ao adicionar categoria: \(error)")
        }
    }
}

