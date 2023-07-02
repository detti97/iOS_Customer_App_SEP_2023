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
		NavigationView {
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
		.onAppear {
			addressBook.loadData()
		}
		.onDisappear {
			addressBook.saveData()
		}
	}

	func delete(at offsets: IndexSet) {
		addressBook.deleteAddress(at: offsets)
	}
}

struct AddressListView_Previews: PreviewProvider {
	static var previews: some View {
		let addressBook = AddressBook()
		addressBook.addAddress(recipient(lastName: "Doe", firstName: "John", street: "Main Street", streetNr: "123", plz: "12345"))
		return AddressListView(addressBook: addressBook)
	}
}
