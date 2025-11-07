//
//  CategoryNode.swift
//  CleanArchitecture
//
//  Interface Adapters - Composite Pattern
//

import Foundation

/// Componente do padrão Composite para representar hierarquia de categorias
protocol CategoryComponent {
    var id: UUID { get }
    var name: String { get }
    func display(indent: Int) -> String
}

/// Nó folha: representa uma categoria simples
struct CategoryLeaf: CategoryComponent {
    let id: UUID
    let name: String
    
    func display(indent: Int) -> String {
        return String(repeating: "  ", count: indent) + "📁 \(name)"
    }
}

/// Nó composto: representa uma categoria com subcategorias
class CategoryComposite: CategoryComponent {
    let id: UUID
    let name: String
    private var children: [CategoryComponent] = []
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    func add(_ component: CategoryComponent) {
        children.append(component)
    }
    
    func remove(_ component: CategoryComponent) {
        children.removeAll { $0.id == component.id }
    }
    
    func getChildren() -> [CategoryComponent] {
        return children
    }
    
    func display(indent: Int) -> String {
        var result = String(repeating: "  ", count: indent) + "📂 \(name)"
        for child in children {
            result += "\n" + child.display(indent: indent + 1)
        }
        return result
    }
}

/// Helper para construir árvore de categorias a partir de lista plana
class CategoryTreeBuilder {
    static func buildTree(from categories: [Category]) -> [CategoryComponent] {
        var categoryMap: [UUID: CategoryComposite] = [:]
        var rootCategories: [CategoryComponent] = []
        
        // Primeiro, criar todos os nós
        for category in categories {
            if category.parentId == nil {
                let composite = CategoryComposite(id: category.id, name: category.name)
                categoryMap[category.id] = composite
                rootCategories.append(composite)
            } else {
                let composite = CategoryComposite(id: category.id, name: category.name)
                categoryMap[category.id] = composite
            }
        }
        
        // Depois, construir a hierarquia
        for category in categories {
            if let parentId = category.parentId,
               let parent = categoryMap[parentId],
               let child = categoryMap[category.id] {
                parent.add(child)
            }
        }
        
        return rootCategories
    }
}


