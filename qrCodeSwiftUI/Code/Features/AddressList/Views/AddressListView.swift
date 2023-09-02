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
	@State private var selectedRecipient: Recipient?
	@State private var isActiveAddressEdit = false

	var body: some View {
			NavigationView {
				VStack {
						List {
							ForEach(addressBook.addressBook) { recipient in
								Button(action: {
									selectedRecipient = recipient
								}) {
									AddressRowView(recipient: recipient, isActiveAddressEdit: $isActiveAddressEdit)
								}
							}
							.onDelete(perform: delete)
						}
						.listStyle(.automatic)

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
					.sheet(item: $selectedRecipient) { address in
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
		addressBook.addAddress(Recipient(firstName: "Doe", lastName: "John", address: Address(street: "Main Street", houseNumber: "123", zip: "12345", city: "")))
		return AddressListView(addressBook: addressBook)
	}
}
