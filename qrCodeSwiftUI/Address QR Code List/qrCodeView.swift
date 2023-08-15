//
//  qrCodeView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage

struct qrCodeView: View {

	@State var address: recipient
	@State private var addressQRString = false

	let context = CIContext()
	let filter = CIFilter.qrCodeGenerator()

	var body: some View {

			VStack(alignment: .center, spacing: 20) {

				HStack{
					Image(systemName: "qrcode")
					Text("Vorzeigen zum scannen")
					
				}
				.foregroundColor(.accentColor)
				.font(.system(size: 24))
				.fontWeight(.heavy)


				HStack{

					VStack (alignment: .trailing, spacing: 10){

						Image("Logo_klein")
							.resizable()
							.frame(width: 210, height: 120)
							.shadow(radius: 15)
							.contextMenu {
								Button("Option 1") {
									// Perform action for option 1
								}
							}

						Image(uiImage: generateQRCode(from: address.toStringQrString()))
							.resizable()
							.interpolation(.none)
							.frame(width: 200, height: 200 )
							.cornerRadius(24)
							.overlay(
								RoundedRectangle(cornerRadius: 24)
									.stroke(Color.accentColor, lineWidth: 10)
							)
							.background(.clear)
							.shadow(radius: 5)
					}

				}

				HStack{
					Image(systemName: "house")
					Text("Lieferadresse")
				}
				.foregroundColor(.accentColor)
				.font(.system(size: 24))
				.fontWeight(.heavy)

				HStack{

					VStack (alignment: .leading, spacing: 10){

						Text("Empfänger: ")
						Text("Straße: ")
						Text("Stadt: ")

					}
					.fontWeight(.heavy)

					VStack(alignment: .trailing, spacing: 10){

						Text("\(address.firstName) \(address.lastName)")
						Text("\(address.street) \(address.streetNr)")
						Text("\(address.plz) Lingen")


					}

				}
			}
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 24)
					.fill(Color.white)
					.shadow(radius: 5)
			)

	}

	func generateQRCode(from string: String) -> UIImage {


		filter.message = Data(string.utf8)

		if let outputImage = filter.outputImage {
			if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
				return UIImage(cgImage: cgimg)
			}
		}

		return UIImage(systemName: "xmark.circle") ?? UIImage()
	}

}

struct qrCodeView_Previews: PreviewProvider {
	static var previews: some View {

		qrCodeView(address:recipient(lastName: "Dettler", firstName: "Jan", street: "kaiser", streetNr: "39", plz: "49809"))
	}
}
