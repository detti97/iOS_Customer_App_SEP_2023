//
//  StoreDetail.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.
//

import SwiftUI

struct StoreDetail: View {

	//@StateObject public var dataManager = DataManager()
	var store : StoreInfo
	var body: some View {

		ScrollView{

			VStack{

				VStack(alignment: .center) {

					Spacer()
						.frame(height: 20)

					AsyncImage(url: URL(string: store.logo)) { image in
						image.resizable()
					} placeholder: {
						ProgressView()
					}
					.frame(width: 150, height: 150)
					.clipShape(Circle())
					.overlay {
						Circle().stroke(.white, lineWidth: 4)
					}
					.shadow(radius: 6)

					Text(store.name)
						.font(.largeTitle)

						.padding(.top)
						.fontWeight(.heavy)
						.foregroundColor(.white)

					Spacer(minLength: 30)

					HStack{

						VStack{
							Image(systemName: "person")
								.font(.headline)
							Image(systemName: "house")
								.font(.headline)
							Image(systemName: "phone")
								.font(.headline)
							Image(systemName: "envelope")
								.font(.headline)

						}

						VStack{
							Text(store.owner)
							Text("\(store.street) \(store.houseNumber)")
							Text(store.telephone)
								.onTapGesture {
									guard let url = URL(string: "tel:\(store.telephone)") else { return }
									UIApplication.shared.open(url)
								}
							Text(store.email)
						}


					}
					.padding()
					.background(
						Color.white
							.opacity(0.6)
							.cornerRadius(15)
							.shadow(radius: 6)

					)


					Spacer(minLength: 25)

				}
				.background(
					AsyncImage(url: URL(string: "https://wallpapers.com/wp-content/themes/wallpapers.com/src/splash-n.jpg")) { image in
						image.resizable()
							.aspectRatio(contentMode: .fill)
							.edgesIgnoringSafeArea(.all)
							.opacity(0.6)
					} placeholder: {
						Color.clear
					})
				//Spacer(minLength: 40)

				VStack{

					MapView(coordinate: store.locationCoordinate, storeName: store.name)
						.ignoresSafeArea()
						.frame(width: 400, height: 300)

				}



			}
			.navigationTitle(store.name)
			.navigationBarTitleDisplayMode(.inline)



		}


	}
}

struct StoreDetail_Previews: PreviewProvider {
	static var previews: some View {
		Group{

			let store = StoreInfo(id: "1", name: "Apple Store", owner: "Steve Jobs", street: "Kaiserstraße", houseNumber: "12", zip: "12345", city: "Lingen", telephone: "0123456789", email: "test@osna.de", logo: "https://img.freepik.com/freie-ikonen/mac-os_318-10374.jpg", coordinates: StoreInfo.Coordinates(latitude: 37.7749, longitude: -122.4194))


			StoreDetail(store: store)
		}


	}
}




