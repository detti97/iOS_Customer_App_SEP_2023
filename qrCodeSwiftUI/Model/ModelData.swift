//
//  ModelData.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import Foundation
import SwiftUI

var stores: [StoreInfo] = load("https://raw.githubusercontent.com/detti97/SEP_2023_iOS_Customer/main/store.json")

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

