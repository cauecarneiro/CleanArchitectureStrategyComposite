//
//  CategoryRepositoryProtocol.swift
//  CleanArchitecture
//
//  Application Business Rules - Protocol
//

import Foundation

/// Protocolo que define o contrato para repositórios de categorias
/// As implementações concretas ficam na camada de Interface Adapters
protocol CategoryRepositoryProtocol {
    func fetchCategories() async throws -> [Category]
    func addCategory(_ category: Category) async throws
    func deleteCategory(_ category: Category) async throws
}


