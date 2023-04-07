//
//  StoreList.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.


import SwiftUI

struct StoreList: View {
    var body: some View {
        NavigationView{
            List(stores) { store in
                NavigationLink{
                    StoreDetail(store: store)
                } label: {
                    StoreRow(store: store)
                }
            }
            .navigationTitle("Teilnehmende Geschäfte")
        }
    }
}

struct StoreList_Previews: PreviewProvider {
    static var previews: some View {
        StoreList()
    }
}

