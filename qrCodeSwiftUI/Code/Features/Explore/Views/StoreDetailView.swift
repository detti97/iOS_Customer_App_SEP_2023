//
//  StoreDetail.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.
//

import SwiftUI

import SwiftUI

/// A SwiftUI view for displaying store details.
struct StoreDetailView: View {

	/// The data manager responsible for loading store data.
	@ObservedObject var dataManager: DataManager

	/// The store details to display.
	var store: StoreDetails

	var body: some View {
		ScrollView {
			VStack {
				Spacer().frame(height: 20)

				// Display the store logo
				AsyncImage(url: URL(string: store.logo)) { image in
					image.resizable()
				} placeholder: {
					ProgressView()
				}
				.frame(width: 150, height: 150)
				.clipShape(Circle())
				.overlay {
					Circle().stroke(Color.white, lineWidth: 4)
				}
				.shadow(radius: 6)
				.accessibility(identifier: "storeLogo")

				// Display the store name
				Text(store.name)
					.font(.largeTitle)
					.padding(.top)
					.fontWeight(.heavy)
					.foregroundColor(.white)
					.accessibility(identifier: "storeNameLabel")

				Spacer(minLength: 30)

				// Display store information
				HStack {
					VStack(spacing: 4) {
						Image(systemName: "person")
						Image(systemName: "house")
						Image(systemName: "phone")
						Image(systemName: "envelope")
					}
					.fontWeight(.heavy)

					VStack(alignment: .trailing, spacing: 4) {
						Text(store.owner)
							.accessibility(identifier: "storeOwnerLabel")
						Text("\(store.address.street) \(store.address.houseNumber)")
							.accessibility(identifier: "storeAddressLabel")
						Text(store.telephone)
							.accessibility(identifier: "storePhoneLabel")
						Text(store.email)
							.accessibility(identifier: "storeEmailLabel")
					}
					.fontWeight(.heavy)
				}
				.frame(width: 250, height: 100)
				.font(Font.system(size: 20))
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
				// Display the store background image
				AsyncImage(url: URL(string: store.backgroundImage)) { image in
					image.resizable()
						.aspectRatio(contentMode: .fill)
						.edgesIgnoringSafeArea(.all)
						.opacity(0.7)
				} placeholder: {
					Color.clear
				})

			VStack {
				// Display a map with the store's location
				MapView(coordinate: store.locationCoordinate, storeName: store.name)
					.ignoresSafeArea()
					.frame(width: 400, height: 300)
					.accessibility(identifier: "mapView")
			}
		}
		.navigationTitle(store.name)
		.navigationBarTitleDisplayMode(.inline)
		.refreshable {
			// Refresh data when pulling down the view
			print("reload")
			dataManager.loadData(url: DataManager.api_endpoints.storeDetail)
		}
	}
}



struct StoreDetail_Previews: PreviewProvider {
	static var previews: some View {
		Group{

			let datamanager = DataManager()

			let store = StoreDetails(id: "1", name: "Apple Store", owner: "Steve Jobs", address: Address(street: "Kaiserstraße", houseNumber: "12", zip: "12345", city: ""), telephone: "0123456789", email: "test@osna.de", logo: "https://img.freepik.com/freie-ikonen/mac-os_318-10374.jpg", backgroundImage: "https://wallpapers.com/wp-content/themes/wallpapers.com/src/splash-n.jpg", coordinates: StoreDetails.Coordinates(latitude: 37.7749, longitude: -122.4194))


			StoreDetailView(dataManager: datamanager, store: store)
		}


	}
}




