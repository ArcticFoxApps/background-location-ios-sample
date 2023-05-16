//
//  ContentView.swift
//  LocationSample
//
//  Created by Hank Wang on 2023/05/15.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("\(location.coordinate.latitude), \(location.coordinate.longitude)")
                Map(coordinateRegion: .constant(getCoordinateRegion()), showsUserLocation: true)
                            .edgesIgnoringSafeArea(.all)
            } else {
                Text("No location")
            }
        }
        .padding()
    }
    
    private func getCoordinateRegion() -> MKCoordinateRegion {
        var region = CLLocationCoordinate2D()
        if let location = locationManager.location {
            region = location.coordinate
        }
//        return MKCoordinateRegion(center: region, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        return MKCoordinateRegion(center: region, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
