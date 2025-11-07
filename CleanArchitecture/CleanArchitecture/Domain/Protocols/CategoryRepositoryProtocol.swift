//
//  CategoryRepositoryProtocol.swift
//  CleanArchitecture
//
//  Created by Cauê Carneiro on 06/11/25.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func fetchCategories() async throws -> [Category]
    func addCategory(_ category: Category) async throws
    func deleteCategory(_ category: Category) async throws
}



