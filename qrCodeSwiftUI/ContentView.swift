//
//  ContentView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var addressBook = AddressBook()
    
    
    var body: some View {
        TabView { //
            AddressListView(addressBook: addressBook)
                .tabItem {
                    Label("Lingen Code", systemImage: "qrcode")
                }
            
            StoreList()
                .tabItem {
                    Label("Erkunden", systemImage: "location")
                }
            addressFormView(addressBook: addressBook)
                .tabItem {
                    Label("Einstellungen", systemImage: "gear")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
