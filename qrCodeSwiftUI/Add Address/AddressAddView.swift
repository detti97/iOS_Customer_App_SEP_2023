//
//  addressFormView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI


struct AddressAddView: View {


	@ObservedObject var addressBook: AddressBook
	@State private var success = false

	@Environment(\.dismiss) var dismiss
	@Environment(\.presentationMode) private var presentationMode

	var body: some View {

		NavigationView {

			VStack {

				Image("delivery_green")
					.resizable()
					.frame(width: 220, height: 180)

				VStack{

					addressFormView(addressBook: addressBook, success: $success)

				}
			}
			.navigationBarTitle("Neue Adresse hinzufügen")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarItems(leading: cancelButton)
			.padding(20)
		}

	}

	private var cancelButton: some View {
		Button(action: {
			presentationMode.wrappedValue.dismiss()
		}) {
			Text("Zurück")
		}
	}

}


struct addressFormView_Previews: PreviewProvider {

	static var previews: some View {
		AddressAddView(addressBook: AddressBook())
	}
}
