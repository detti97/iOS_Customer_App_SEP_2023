//
//  StoreDetail.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.
//

import SwiftUI

struct StoreDetail: View {

	@EnvironmentObject var dataManager: DataManager
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
                            .font(.title)
                            .padding(.top)
						Spacer()
							.frame(width: 20)
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
						.background()
						.cornerRadius(10)
						.shadow(radius: 6)

                    }

					Spacer()
					.frame(width: 30)
								MapView(coordinate: store.locationCoordinate, storeName: store.name)
									.ignoresSafeArea()
									.frame(width: 400, height: 400)

                }
                .navigationTitle(store.name)
				.refreshable {
								// Daten neu laden
								dataManager.loadData()
							}

            }

        }
    }

struct StoreDetail_Previews: PreviewProvider {
    static var previews: some View {

		let dataManager = DataManager()

		StoreDetail(store: dataManager.stores[0])
    }
}


