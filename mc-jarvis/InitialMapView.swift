//
//  MapView.swift
//  smart mc
//
//  Created by Jesus Castano Candela on 19/08/2024.
//

import SwiftUI
@_spi(Experimental) import MapboxMaps

struct InitialMapView: View {
    @StateObject private var locationManager = LocationManager()
    @State var viewport: Viewport = .styleDefault
    @State private var mapLoaded = false
//    @State private var mapView: MapView?
    @State private var centerCoordinate: CLLocationCoordinate2D?

    var body: some View {
        
        Map(viewport: $viewport) {
            Puck2D()
        }
        .onStyleLoaded { _ in
            mapLoaded = true
            animateToUserLocation()
        }
        .onAppear {
            // Triggered when the view appears, just in case.
            if mapLoaded {
                animateToUserLocation()
            }
        }
        .onChange(of: centerCoordinate) {
            guard let newCoordinate = centerCoordinate else { return }

            withViewportAnimation(.fly(duration: 3)) {
                viewport = .camera(
                    center: newCoordinate,
                    zoom: 15,
                    pitch: 0
                )
            }
//            TODO: Hay que añadir un marcador al mapa con la nueva ubicacion
//            MapViewAnnotation(coordinate: newCoordinate) {
//               Text("🚀")
//                  .background(Circle().fill(.red))
//            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottom, content: {
            VStack {
                SearchView(centerCoordinate: $centerCoordinate)
            }
        })
    }

    private func animateToUserLocation() {
        // Ensure that locationManager has valid location data
        guard locationManager.lastKnownLocation != nil else { return }
        
        // Sets viewport to follow the user location.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withViewportAnimation(.fly(duration: 3)) {
                viewport = .followPuck(
                    zoom: 15,
                    pitch: 60
                )
            }
        }
    }
}



#Preview {
    InitialMapView()
}
