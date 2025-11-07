//
//  ProductRepositoryProtocol.swift
//  CleanArchitecture
//
//  Application Business Rules - Protocol
//

import Foundation

/// Protocolo que define o contrato para repositórios de produtos
/// As implementações concretas ficam na camada de Interface Adapters
protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
    func fetchProducts(by categoryId: UUID) async throws -> [Product]
    func addProduct(_ product: Product) async throws
    func deleteProduct(_ product: Product) async throws
}


