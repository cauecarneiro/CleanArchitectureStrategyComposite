//
//  ProductView.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - SwiftUI View
//

import SwiftUI
import SwiftData

struct ProductView: View {
    @EnvironmentObject private var dependencies: DependencyContainer
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Controles de ordenação usando Strategy pattern
                Picker("Ordenar por", selection: $viewModel.selectedSortStrategy) {
                    Text("Nome").tag(0)
                    Text("Preço (menor)").tag(1)
                    Text("Preço (maior)").tag(2)
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: viewModel.selectedSortStrategy) { _, newValue in
                    viewModel.changeSortStrategy(newValue)
                }
                
                List {
                    ForEach(viewModel.products) { product in
                        ProductRowView(product: product)
                    }
                    .onDelete(perform: viewModel.deleteProducts)
                }
            }
            .navigationTitle("Produtos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Adicionar") {
                        viewModel.showAddProduct = true
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddProduct) {
                NewProductView(viewModel: viewModel)
            }
            .task {
                viewModel.setup(dependencyContainer: dependencies)
                await viewModel.loadProducts()
            }
        }
    }
}

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("R$ \(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let container = try! ModelContainer(for: CategoryModel.self, ProductModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let dependencies = DependencyContainer(modelContext: container.mainContext)
    
    ProductView()
        .modelContainer(container)
        .environmentObject(dependencies)
}

