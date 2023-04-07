//
//  StoreDetail.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 07.04.23.
//

import SwiftUI

struct StoreDetail: View {
    
    var store : StoreInfo
    
    
    var body: some View {
        
        NavigationView{
        
            ScrollView{
                
                VStack{
                    
                    VStack(alignment: .center) {
                        
                        AsyncImage(url: URL(string: store.logo)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 6)
                        
                        Text(store.name)
                            .font(.title)
                            .padding(.top)
                        
                        HStack {
                            Text("Inhaber:")
                                .font(.headline)
                            Spacer()
                            Text(store.owner)
                        }
                        
                        HStack {
                            Text("Adresse:")
                                .font(.headline)
                            Spacer()
                            Text("\(store.street) \(store.houseNumber), \(store.zip) \(store.city)")
                        }
                        
                        HStack {
                            Text("Telefon:")
                                .font(.headline)
                            Spacer()
                            Text(store.telephone)
                        }
                        
                        HStack {
                            Text("E-Mail:")
                                .font(.headline)
                            Spacer()
                            Text(store.email)
                        }
                        .padding(.bottom)
                        
                    }
                    
                    Spacer()
                    
                    MapView(coordinate: store.locationCoordinate, storeName: store.name)
                        .ignoresSafeArea()
                        .frame(width: 400, height: 300)
                    
                }
                .navigationBarTitle(store.name)
            }
            .padding()
        }
    }
}
struct StoreDetail_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetail(store: stores[0])
    }
}


