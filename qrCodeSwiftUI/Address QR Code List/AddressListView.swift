//
//  addressListView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct AddressListView: View {
    
    @ObservedObject var addressBook: AddressBook
    @State private var showingAddAddressSheet = false
    
    var body: some View {
        NavigationView{
            
            VStack {
                
                List {
                    ForEach(addressBook.addresses) { address in
                        NavigationLink(destination: qrCodeView(addressString: address.toStringQrString())) {
                            qrCodeRow(adressString: (address.toString()))
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(InsetListStyle())
                
                Button(action: {
                    showingAddAddressSheet = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                })
                .padding()
                .background(Color.clear)
                .foregroundColor(.blue)
                .cornerRadius(8)
                .padding(.trailing, 10)
                .sheet(isPresented: $showingAddAddressSheet, content: {
                    addressFormView(addressBook: addressBook)
                })
            }
            .navigationBarTitle("Adressen")
            .navigationBarItems(trailing: EditButton())
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        addressBook.addresses.remove(atOffsets: offsets)
    }
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        let book = AddressBook()
        book.addAddress(recipient(lastName: "Test", firstName: "Jan", street: "Teststr.", streetNr: "12", plz: "49809"))
        return AddressListView(addressBook: book)
    }
}
