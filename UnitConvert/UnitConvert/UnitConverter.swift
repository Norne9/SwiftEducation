//
//  UnitConverter.swift
//  UnitConvert
//
//  Created by Aleksey Pestov on 13.08.2021.
//

import Foundation

enum Unit: CaseIterable, CustomStringConvertible {
    case celsius
    case fahrenheit
    case kelvin
    
    var description: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
}

class UnitConverter {
    static private let toCelsius: [Unit: (Double) -> Double] = [
        .celsius: { $0 },
        .fahrenheit: {fah in
            (fah - 32.0) * 5.0 / 9.0
        },
        .kelvin: {kel in
            kel - 273.15
        }
    ]
    static private let fromCelsius: [Unit: (Double) -> Double] = [
        .celsius: { $0 },
        .fahrenheit: {cel in
            cel * 9.0 / 5.0 + 32.0
        },
        .kelvin: {cel in
            cel + 273.15
        }
    ]
    
    static public func convert(_ val: Double, from: Unit, to: Unit) -> Double? {
        guard let fromFunc = toCelsius[from] else {return nil}
        guard let toFunc = fromCelsius[to] else {return nil}
        return toFunc(fromFunc(val))
    }
}
