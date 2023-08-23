//
//  qrCodeView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage

struct QRCodeView: View {

	@State var address: Recipient
	@State private var secret = 0

	@Environment(\.presentationMode) private var presentationMode

	let width : CGFloat = 350
	let height : CGFloat = 500

	var body: some View {

		NavigationView{

			ZStack{

				VStack{

					VStack{

						Image("Logo_klein")
							.resizable()
							.scaledToFit()
							.frame(width: 150)

					}
					.position(x: 310, y: 30)

					ZStack {
						RoundedRectangle(cornerRadius: 20)
							.stroke(Color.gray.opacity(0.7), lineWidth: 3)
							.frame(width: width, height: height)

						RoundedRectangle(cornerRadius: 20)
							.fill(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255).opacity(0.45))
							.frame(width: width, height: height)
							.shadow(color: .gray, radius: 2, x: 0, y: 0)


						VStack{

							HStack{
								Image(systemName: "qrcode")
									.font(.system(size: 44))
									.foregroundColor(.black)
								Text("Vorzeigen zum scannen")

							}
							.foregroundColor(.accentColor)
							.font(.system(size: 24))
							.fontWeight(.heavy)
							.position(x: 170, y: 40)

							VStack (alignment: .trailing, spacing: 10){

								Image(uiImage: generateQRCode(from: address.toStringQrString()))
									.resizable()
									.interpolation(.none)
									.frame(width: 200, height: 200)
									.cornerRadius(24)
									.overlay(
										RoundedRectangle(cornerRadius: 28)
											.stroke(Color.accentColor, lineWidth: 8)
									)
									.background(.clear)
									.shadow(radius: 5)
									.zIndex(80)
									.contextMenu {
										Button(action: {

										}) {
											HStack {
												Text("Edit")
												Image(systemName: "pencil")
											}
										}
									}
							}
							.position(x:170, y: 30)

							VStack{

								HStack{
									Image(systemName: "house")
									Text("Lieferadresse")
								}
								.foregroundColor(.accentColor)
								.font(.system(size: 24))
								.fontWeight(.heavy)
								.position(x:170, y: 50)

								HStack{

									VStack(alignment: .center, spacing: 10){

										Text("\(address.lastName) \(address.firstName)")
										Text("\(address.address.street) \(address.address.houseNumber)")
										Text("\(address.address.zip) Lingen")
									}
									.fontWeight(.heavy)

								}
							}
							.position(x:170, y: 65)
						}
						.frame(width: width, height: height)


					}
					.navigationBarItems(leading: cancelButton)
					.position(x: 195, y: -30)

				}

			}
			.background(
				ZStack {
					Image("test2")
						.resizable()
						.ignoresSafeArea()

					Rectangle()
						.fill(.ultraThinMaterial)
						.ignoresSafeArea()

				}
			)
		}


	}

	private var cancelButton: some View {
		Button(action: {
			presentationMode.wrappedValue.dismiss()
		}) {
			Text("Zurück")
		}
	}




	func generateQRCode(from string: String) -> UIImage {

		let context = CIContext()
		let filter = CIFilter.qrCodeGenerator()


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

		QRCodeView(address:Recipient(firstName: "Dettler", lastName: "Jan", address: Address(street: "kaiser", houseNumber: "39", zip: "49809", city: "")))
	}
}
