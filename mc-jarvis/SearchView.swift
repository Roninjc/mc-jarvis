//
//  SearchView.swift
//  mc-jarvis
//
//  Created by Jesus Castano Candela on 23/08/2024.
//

import SwiftUI
import MapboxMaps
import MapboxSearch
import MapboxSearchUI
import CoreLocation

struct SearchView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D? 
    @State private var mapView: MapView!
    @State private var annotationManager: PointAnnotationManager?
    @ObservedObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        Group {
            if (searchViewModel.searchResults.count > 0) {
                VStack {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading) {
                            ForEach(searchViewModel.searchResults, id: \.mapboxID) { suggestion in
                                Button(action: {
                                    searchViewModel.selectSuggestion(locationId: suggestion.mapboxID) { coordinate in
                                        if let coordinate = coordinate {
                                            centerCoordinate = coordinate  // Actualiza la coordenada central del mapa
                                        }
                                    }
                                }) {
                                    VStack(alignment: .leading) {
                                        Text(suggestion.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        if (suggestion.fullAddress != nil) {
                                            Text(suggestion.fullAddress!)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        } else {
                                            Text(suggestion.placeFormatted)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.horizontal ,15)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                }
                                .padding(4)
                            }
                        }
                    }
                    .defaultScrollAnchor(.bottom)
                    .frame(maxHeight: 200)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(10)
            }
            
            TextField("Search for a place...", text: $searchViewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(.regularMaterial)
        }
    }
}

#Preview {
    InitialMapView()
}
