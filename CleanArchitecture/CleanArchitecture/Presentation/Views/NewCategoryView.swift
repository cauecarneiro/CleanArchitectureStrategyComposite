//
//  NewCategoryView.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - SwiftUI View
//

import SwiftUI
import SwiftData

struct NewCategoryView: View {
    @ObservedObject var viewModel: CategoryViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedParentId: UUID?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome da categoria", text: $name)
                
                Picker("Categoria pai (opcional)", selection: $selectedParentId) {
                    Text("Nenhuma (categoria raiz)").tag(nil as UUID?)
                    ForEach(viewModel.categories) { category in
                        Text(category.name).tag(category.id as UUID?)
                    }
                }
            }
            .navigationTitle("Nova Categoria")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        saveCategory()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .task {
                await viewModel.loadCategories()
            }
        }
    }
    
    private func saveCategory() {
        Task {
            await viewModel.addCategory(name: name, parentId: selectedParentId)
            dismiss()
        }
    }
}

//#Preview {
//    let container = try! ModelContainer(for: CategoryModel.self, ProductModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
//    let dependencies = DependencyContainer(modelContext: container.mainContext)
//    let viewModel = CategoryViewModel()
//    viewModel.setup(dependencyContainer: dependencies)
//    
//    NewCategoryView(viewModel: viewModel)
//        .modelContainer(container)
//        .environmentObject(dependencies)
//}

