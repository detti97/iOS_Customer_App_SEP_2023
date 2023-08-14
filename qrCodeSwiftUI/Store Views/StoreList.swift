//
//  StoreList.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.


import SwiftUI

struct StoreList: View {

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
						dataManager.loadData()
							   }
				}else{

					List(dataManager.stores) { store in
						NavigationLink{
							StoreDetail(dataManager: dataManager, store: store)
						} label: {
							StoreRow(store: store)
						}
					}
					.navigationTitle("Teilnehmende Geschäfte")
					.refreshable {
						print("reload")
						dataManager.loadData()
							   }
				}
			}
			.onAppear(perform: {
				dataManager.loadData()
			})

		}
	
}

struct StoreList_Previews: PreviewProvider {
	static var previews: some View {
		StoreList()
	}
}

