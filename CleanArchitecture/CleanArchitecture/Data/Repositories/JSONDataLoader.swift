//
//  JSONDataLoader.swift
//  CleanArchitecture
//
//  Frameworks & Drivers - JSON Data Source
//

import Foundation

/// Carregador de dados JSON
/// Responsável por ler e decodificar dados JSON
class JSONDataLoader {
    static func loadProducts() throws -> [Product] {
        // Dados de exemplo em JSON
        let jsonString = """
        [
            {
                "id": "550e8400-e29b-41d4-a716-446655440000",
                "name": "iPhone 15",
                "price": 5999.99,
                "categoryId": "550e8400-e29b-41d4-a716-446655440001"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440002",
                "name": "MacBook Pro",
                "price": 12999.99,
                "categoryId": "550e8400-e29b-41d4-a716-446655440001"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440003",
                "name": "AirPods Pro",
                "price": 1999.99,
                "categoryId": "550e8400-e29b-41d4-a716-446655440001"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440004",
                "name": "Notebook Dell",
                "price": 3999.99,
                "categoryId": "550e8400-e29b-41d4-a716-446655440002"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440005",
                "name": "Mouse Logitech",
                "price": 299.99,
                "categoryId": "550e8400-e29b-41d4-a716-446655440002"
            }
        ]
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            throw NSError(domain: "JSONDataLoader", code: 1, userInfo: [NSLocalizedDescriptionKey: "Erro ao converter JSON para Data"])
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([Product].self, from: data)
    }
    
    static func loadCategories() throws -> [Category] {
        // Dados de exemplo em JSON com hierarquia
        let jsonString = """
        [
            {
                "id": "550e8400-e29b-41d4-a716-446655440001",
                "name": "Apple",
                "parentId": null
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440002",
                "name": "Computadores",
                "parentId": null
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440003",
                "name": "Acessórios",
                "parentId": "550e8400-e29b-41d4-a716-446655440002"
            }
        ]
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            throw NSError(domain: "JSONDataLoader", code: 1, userInfo: [NSLocalizedDescriptionKey: "Erro ao converter JSON para Data"])
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([Category].self, from: data)
    }
}


