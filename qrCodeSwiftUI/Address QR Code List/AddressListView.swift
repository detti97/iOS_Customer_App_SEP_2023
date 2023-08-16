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
	@State static var returnedBool: Bool?
	@State private var selectedAddress: Address?

	var body: some View {
			NavigationView {
				VStack {
					List {
						ForEach(addressBook.addresses) { address in
							Button(action: {
								selectedAddress = address // Setze die ausgewählte Adresse
							}) {
								AddressRowView(adressString: (address.toString()))
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
					.foregroundColor(.accentColor)
					.cornerRadius(8)
					.padding(.trailing, 10)
					.sheet(isPresented: $showingAddAddressSheet, content: {
						AddressAddView(addressBook: addressBook)
					})
					.sheet(item: $selectedAddress) { address in
						QRCodeView(address: address)
					}
				}
				.navigationBarTitle("Addresses")
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
		addressBook.addAddress(Address(firstName: "Doe", lastName: "John", street: "Main Street", houseNumber: "123", zip: "12345"))
		return AddressListView(addressBook: addressBook)
	}
}
