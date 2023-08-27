//
//  qrCodeRow.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct AddressRowView: View {
    
    var recipient: Recipient

    var body: some View{
        HStack{
            
            Image(systemName: "qrcode")
                .font(.system(size: 70))
                .foregroundColor(.accentColor)
            Spacer()
			Text(recipient.toString())
                .font(.headline)
			Spacer()
			ZStack {
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(Color.accentColor)
					.frame(width: 50, height: 50)

				Image(systemName: "plus.magnifyingglass")
					.font(.system(size: 30))
					.foregroundColor(.black)
			}
        }
		.contextMenu {
			VStack {
				Text("Vorschau Option")
					.font(.headline)
				QRCodeView(address: recipient)
			}
		}
    }
}
struct AddressRowView_Previews: PreviewProvider {
    static var previews: some View {

		let recipient = Recipient(firstName: "ja", lastName: "de", address: Address(street: "Kai", houseNumber: "12", zip: "49809", city: "Lingen"))

        AddressRowView(recipient: recipient)
    }
}
