//
//  CategoryView.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - SwiftUI View
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    @EnvironmentObject private var dependencies: DependencyContainer
    @StateObject private var viewModel = CategoryViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                // Mostra a árvore de categorias usando Composite pattern
                ForEach(viewModel.categoryTree, id: \.id) { component in
                    CategoryRowView(component: component, level: 0)
                }
            }
            .navigationTitle("Categorias")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Adicionar") {
                        viewModel.showAddCategory = true
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddCategory) {
                NewCategoryView(viewModel: viewModel)
            }
            .task {
                viewModel.setup(dependencyContainer: dependencies)
                await viewModel.loadCategories()
            }
        }
    }
}

struct CategoryRowView: View {
    let component: CategoryComponent
    let level: Int
    
    var body: some View {
        HStack {
            Text(String(repeating: "  ", count: level))
            Text(component.name)
                .font(.system(size: 16))
            Spacer()
        }
        .padding(.leading, CGFloat(level * 16))
        
        // Se for um composite, mostra os filhos recursivamente
        if let composite = component as? CategoryComposite {
            ForEach(composite.getChildren(), id: \.id) { child in
                CategoryRowView(component: child, level: level + 1)
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: CategoryModel.self, ProductModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let dependencies = DependencyContainer(modelContext: container.mainContext)
    
    CategoryView()
        .modelContainer(container)
        .environmentObject(dependencies)
}

