//
//  StoreRow.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct StoreRowView: View {
    
    var store: StoreDetails
    
    var body: some View {
        
        HStack{
            AsyncImage(url: URL(string: store.logo)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            Text(store.name)
                .font(.headline)
            
            
            Spacer()
        }
    }
}

struct StoreRow_Previews: PreviewProvider {
	static var previews: some View {
		let dataManager = DataManager() // DataManager-Instanz erstellen
		let store = dataManager.stores[1] // Beispielhafter Store

		return Group {
			StoreRowView(store: store)
		}
		.previewLayout(.fixed(width: 300, height: 70))
		.environmentObject(dataManager) // dataManager als Environment-Objekt setzen
	}
}



