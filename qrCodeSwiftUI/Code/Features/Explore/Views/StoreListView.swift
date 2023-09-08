//
//  StoreList.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.


import SwiftUI

struct StoreListView: View {

	@StateObject public var dataManager = DataManager()
	@State private var showErrorAlert = false

	var body: some View {

			NavigationView{

				if dataManager.errorLoading {
					List{
						Text("Fehler beim Laden der Daten")
							.foregroundColor(.red)
						Text("Nach unten ziehen um es erneut zu versuchen")
					}
					.navigationTitle("Teilnehmende Geschäfte")
					.refreshable {
						print("reload")
						dataManager.loadData(url: DataManager.api_endpints.storeDetail)
							   }
				}else{

					List(dataManager.stores) { store in
						NavigationLink{
							StoreDetailView(dataManager: dataManager, store: store)
						} label: {
							StoreRowView(store: store)
								.accessibilityLabel(store.id)
						}
					}
					.navigationTitle("Teilnehmende Geschäfte")
					.refreshable {
						print("reload")
						dataManager.loadData(url: DataManager.api_endpints.storeDetail)
							   }
				}
			}
			.onAppear(perform: {
				dataManager.loadData(url: DataManager.api_endpints.storeDetail)
			})

		}
	
}

struct StoreList_Previews: PreviewProvider {
	static var previews: some View {
		StoreListView()
	}
}

