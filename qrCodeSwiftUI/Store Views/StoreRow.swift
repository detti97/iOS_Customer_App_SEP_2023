//
//  StoreRow.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct StoreRow: View {
    
    var store: StoreInfo
    
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
        Group{
            StoreRow(store: stores[1])
            StoreRow(store: stores[0])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}


