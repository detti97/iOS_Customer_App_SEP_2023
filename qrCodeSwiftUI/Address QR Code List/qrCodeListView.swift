//
//  qrCodeListView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//  Alternative zu AddressListView
//

import SwiftUI

struct qrCodeListView: View {
    
    @State var adressString: String = ""
    @State var showFormView = false
    
    var body: some View {
        NavigationView{
            List{
                qrCodeRow(adressString: adressString)
                NavigationLink(destination: qrCodeView(addressString: adressString)) { // addressString an qrCodeView übergeben
                    Text("QR Code anzeigen")
                }
            }
            .navigationTitle("Adressen")
            .navigationBarItems(trailing:
                Button(action: {
                    showFormView = true
                }) {
                    Image(systemName: "person.fill.badge.plus")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                    
                }
            )
            .sheet(isPresented: $showFormView){
                addressFormView(addressBook: AddressBook())
            }
            
        }
    }
}

    
    struct qrCodeListView_Previews: PreviewProvider {
        static var previews: some View {
            qrCodeListView(adressString: "hallo")
        }
    }
