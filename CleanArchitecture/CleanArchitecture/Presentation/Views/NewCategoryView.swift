//
//  NewCategoryView.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
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
