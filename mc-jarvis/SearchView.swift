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

struct SearchView: View {
    @State private var mapView: MapView!
    @State private var annotationManager: PointAnnotationManager?
    @ObservedObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            // Search Bar
            TextField("Search for a place...", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(viewModel.searchResults, id: \.mapboxID) { suggestion in
                VStack(alignment: .leading) {
                    Text(suggestion.name)
                        .font(.headline)
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
            }
        }
    }
}

#Preview {
    SearchView()
}
