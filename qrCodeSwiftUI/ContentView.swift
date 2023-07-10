//
//  ContentView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var addressBook = AddressBook()
    @State private var showAddressAlert = false
    
    var body: some View {
        VStack {
            TabView {
                AddressListView(addressBook: addressBook)
                    .tabItem {
                        Label("Lingen Code", systemImage: "qrcode")
                    }
                StoreList()
                    .tabItem {
                        Label("Erkunden", systemImage: "location")
                    }
                SettingsView()
                    .tabItem {
                        Label("Einstellungen", systemImage: "gear")
                    }
            }
            .onAppear {
                if addressBook.addresses.isEmpty {
                    showAddressAlert = true
                }
            }
        }
        .alert(isPresented: $showAddressAlert) {
            Alert(
                title: Text("Herzlich Willkommen in der Lingen-Liefert App"),
                message: Text("Bitte geben Sie eine Adresse ein, indem Sie auf den + Button unten drücken"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
