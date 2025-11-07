//
//  ProductRepositoryProtocol.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
    func fetchProducts(by categoryId: UUID) async throws -> [Product]
    func addProduct(_ product: Product) async throws
    func deleteProduct(_ product: Product) async throws
}



