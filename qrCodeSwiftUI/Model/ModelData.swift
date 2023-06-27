//
//  ModelData.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation
import SwiftUI

var stores: [StoreInfo] = load("http://131.173.65.77:3000/store-details")

func load<T: Decodable>(_ url: String) -> T {
    guard let url = URL(string: url) else {
        fatalError("Invalid URL.")
    }

    let data: Data

    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load data from \(url):\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse data from \(url) as \(T.self):\n\(error)")
    }
}

