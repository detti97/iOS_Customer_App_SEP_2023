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

	@State var address: Address
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
										Text("\(address.street) \(address.houseNumber)")
										Text("\(address.zip) Lingen")
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

		QRCodeView(address:Address(firstName: "Dettler", lastName: "Jan", street: "kaiser", houseNumber: "39", zip: "49809"))
	}
}


struct CardFront : View {
	let width : CGFloat
	let height : CGFloat
	@Binding var degree : Double
	@ObservedObject var addressBook: AddressBook
	@State var address = Address(firstName: "", lastName: "", street: "", houseNumber: "", zip: "")

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.accentColor.opacity(0.7), lineWidth: 3)
				.frame(width: width, height: height)

			RoundedRectangle(cornerRadius: 20)
				.fill(Color.accentColor.opacity(0.2))
				.frame(width: width, height: height)
				.shadow(color: .gray, radius: 2, x: 0, y: 0)

			VStack{

				//AddressFormView(addressBook: addressBook, address: addres,)

			}
			.frame(width: width-60, height: height)

		}
		.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

	}

	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {

			let width : CGFloat = 350
			let height : CGFloat = 500
			@State var frontDegree = 0.0

			CardFront(width: width, height: height, degree: $frontDegree, addressBook: AddressBook())
		}
	}
}

struct CardBack : View {
	let width : CGFloat
	let height : CGFloat
	@Binding var degree : Double

	@State var address: Address

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


	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.accentColor.opacity(0.7), lineWidth: 3)
				.frame(width: width, height: height)

			RoundedRectangle(cornerRadius: 20)
				.fill(Color.accentColor.opacity(0.2))
				.frame(width: width, height: height)
				.shadow(color: .gray, radius: 2, x: 0, y: 0)


			VStack{

				HStack{
					Image(systemName: "qrcode")
						.font(.system(size: 44))
					Text("Vorzeigen zum scannen")

				}
				.foregroundColor(.teal)
				.font(.system(size: 24))
				.fontWeight(.heavy)
				.position(x: 170, y: 40)

				VStack (alignment: .trailing, spacing: 10){

					Image(uiImage: generateQRCode(from: address.toStringQrString()))
						.resizable()
						.interpolation(.none)
						.frame(width: 200, height: 200 )
						.cornerRadius(24)
						.overlay(
							RoundedRectangle(cornerRadius: 24)
								.stroke(Color.teal, lineWidth: 10)
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
					.foregroundColor(.teal)
					.font(.system(size: 24))
					.fontWeight(.heavy)
					.position(x:170, y: 50)

					HStack{

						VStack(alignment: .center, spacing: 10){

							Text("\(address.lastName) \(address.firstName)")
							Text("\(address.street) \(address.houseNumber)")
							Text("\(address.zip) Lingen")
						}
						.fontWeight(.heavy)

					}
				}
				.position(x:170, y: 65)
			}
			.frame(width: width, height: height)
		}
		.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

	}
}

struct Card: View {
	//MARK: Variables
	@State var backDegree = 0.0
	@State var frontDegree = -90.0
	@State var isFlipped = false

	@State var address: Address

	let width : CGFloat = 350
	let height : CGFloat = 500
	let durationAndDelay : CGFloat = 0.4

	

	//MARK: Flip Card Function
	func flipCard () {
		isFlipped = !isFlipped
		if isFlipped {
			withAnimation(.linear(duration: durationAndDelay)) {
				backDegree = 90
			}
			withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
				frontDegree = 0
			}
		} else {
			withAnimation(.linear(duration: durationAndDelay)) {
				frontDegree = -90
			}
			withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
				backDegree = 0
			}
		}
	}
	//MARK: View Body
	var body: some View {

		VStack{
			ZStack {
				CardFront(width: width, height: height, degree: $frontDegree, addressBook: AddressBook(), address: address)
				CardBack(width: width, height: height, degree: $backDegree, address: address)

			}.onTapGesture {
				flipCard ()
			}

			Button(action: {
				flipCard()
			}) {
				HStack {
					Text("Edit")
					Image(systemName: "pencil")
				}
			}
		}

	}
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			let address = Address(firstName: "jan", lastName: "de", street: "Ba", houseNumber: "12", zip: "49809")
			Card(address: address)
		}
	}
}
