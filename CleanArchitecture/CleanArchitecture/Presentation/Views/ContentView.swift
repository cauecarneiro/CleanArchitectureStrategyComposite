//
//  ContentView.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            ProductView()
                .tabItem {
                    Label("Produtos", systemImage: "bag")
                }
            
            CategoryView()
                .tabItem {
                    Label("Categorias", systemImage: "folder")
                }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: CategoryModel.self, ProductModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let dependencies = DependencyContainer(modelContext: container.mainContext)
    
    ContentView()
        .modelContainer(container)
        .environmentObject(dependencies)
}

