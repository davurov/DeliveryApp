//
//  ProductsModel.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 03/04/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productModel = try? JSONDecoder().decode(ProductModel.self, from: jsonData)

import Foundation


// MARK: - ProductModelElement
struct ProductModelElement: Codable {
    let id: Int?
    let name: String?
    let veg: Bool?
    let price: Int?
    let description: String?
    let quantity: Int?
    let img: String?
    let sizeandcrust: [Sizeandcrust]?
}

// MARK: - Sizeandcrust
struct Sizeandcrust: Codable {
    let mediumPan, mediumstuffedcrustcheesemax, mediumstuffedcrustvegkebab, mediumStuffedCrustVegKebab: [Medium]?
    let mediumstuffedcrustchickenseekhkebab, mediumStuffedCrustKebab: [Medium]?

    enum CodingKeys: String, CodingKey {
        case mediumPan, mediumstuffedcrustcheesemax, mediumstuffedcrustvegkebab
        case mediumStuffedCrustVegKebab = "medium stuffed crust-veg kebab"
        case mediumstuffedcrustchickenseekhkebab
        case mediumStuffedCrustKebab = "medium stuffed crust kebab"
    }
}

// MARK: - Medium
struct Medium: Codable {
    let price: Int?
}

typealias ProductModel = [ProductModelElement]
