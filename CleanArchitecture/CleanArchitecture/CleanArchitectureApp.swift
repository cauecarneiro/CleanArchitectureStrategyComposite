//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 07/11/25.
//

import SwiftUI
import SwiftData

@main
struct CleanArchitectureApp: App {
    // Configura o container SwiftData
    let container: ModelContainer
    
    init() {
        let schema = Schema([ProductModel.self, CategoryModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Erro ao configurar ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .environmentObject(createDependencyContainer())
        }
    }
    
    /// Cria e configura o container de dependências
    private func createDependencyContainer() -> DependencyContainer {
        let context = container.mainContext
        let dependencies = DependencyContainer(modelContext: context)
        
        // Configura estratégia padrão de ordenação
        dependencies.setProductSortStrategy(SortByNameStrategy())
        
        return dependencies
    }
}
