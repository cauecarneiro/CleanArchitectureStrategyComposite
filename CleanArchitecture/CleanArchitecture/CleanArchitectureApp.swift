//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 05/11/25.
//

import SwiftUI
import SwiftData

@main
struct CleanArchitectureApp: App {
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
    
    private func createDependencyContainer() -> DependencyContainer {
        let context = container.mainContext
        let dependencies = DependencyContainer(modelContext: context)
        
        dependencies.setProductSortStrategy(SortByNameStrategy())
        
        return dependencies
    }
}
