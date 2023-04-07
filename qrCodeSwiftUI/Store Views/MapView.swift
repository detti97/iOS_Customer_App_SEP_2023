//
//  MapView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI
import MapKit

struct MapLocation: Identifiable{
    
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var storeName: String
    @State private var region = MKCoordinateRegion()
    @State private var sName = ""
    
    var body: some View {
        
        let MapLocations = [
            MapLocation(name: sName, coordinate: coordinate)
            
        ]
        Map(coordinateRegion: $region, annotationItems: MapLocations){
            MapMarker(coordinate: $0.coordinate)
        }
        .onAppear{
            setRegion(coordinate)
            setStoreName(storeName)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
        )
    }
    private func setStoreName(_ storeName: String){
        sName = storeName
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 51.5890477, longitude: 7.663509), storeName: "Test")
    }
}

