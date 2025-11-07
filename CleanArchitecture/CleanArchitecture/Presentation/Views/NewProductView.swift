//
//  NewProductView.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - SwiftUI View
//

import SwiftUI
import SwiftData

struct NewProductView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var selectedCategoryId: UUID?
    @State private var categories: [Category] = []
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome do produto", text: $name)
                TextField("Preço", text: $price)
                    .keyboardType(.decimalPad)
                
                Picker("Categoria", selection: $selectedCategoryId) {
                    Text("Selecione uma categoria").tag(nil as UUID?)
                    ForEach(categories) { category in
                        Text(category.name).tag(category.id as UUID?)
                    }
                }
            }
            .navigationTitle("Novo Produto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        saveProduct()
                    }
                    .disabled(name.isEmpty || price.isEmpty || selectedCategoryId == nil)
                }
            }
            .task {
                await loadCategories()
            }
        }
    }
    
    private func loadCategories() async {
        do {
            categories = try await viewModel.loadCategories()
            if let firstCategory = categories.first {
                selectedCategoryId = firstCategory.id
            }
        } catch {
            print("Erro ao carregar categorias: \(error)")
        }
    }
    
    private func saveProduct() {
        guard let priceValue = Double(price),
              let categoryId = selectedCategoryId else {
            return
        }
        
        Task {
            await viewModel.addProduct(name: name, price: priceValue, categoryId: categoryId)
            dismiss()
        }
    }
}

//#Preview {
//    let container = try! ModelContainer(for: CategoryModel.self, ProductModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
//    let dependencies = DependencyContainer(modelContext: container.mainContext)
//    let viewModel = ProductViewModel()
//    viewModel.setup(dependencyContainer: dependencies)
//    
//    NewProductView(viewModel: viewModel)
//        .modelContainer(container)
//        .environmentObject(dependencies)
//}
//
