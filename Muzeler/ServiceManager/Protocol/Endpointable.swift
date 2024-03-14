//
//  Endpointable.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
protocol Endpointable {
    var baseURL: String { get }
    var rawValue: String { get }
    var fullPath: String { get }
}
