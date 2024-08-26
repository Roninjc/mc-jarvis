//
//  SearchViewModel.swift
//  mc-jarvis
//
//  Created by Jesus Castano Candela on 24/08/2024.
//

import SwiftUI
import Combine
import CoreLocation

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [Suggestion] = []
//    @Published var searchResults: [Suggestion] = [mc_jarvis.SearchViewModel.Suggestion(name: "Oslo Bilia Insignia", namePreferred: nil, mapboxID: "dXJuOm1ieHBvaToxZTE3ZjczZi1lZDk0LTQzNzctOGFjMC01OTc2ZTYwNWFhMzU", featureType: "poi", address: Optional("Konows Gate 67B"), fullAddress: Optional("Konows Gate 67B, 0196 Oslo, Norway"), placeFormatted: "0196 Oslo, Norway", context: mc_jarvis.SearchViewModel.Context(country: Optional(mc_jarvis.SearchViewModel.Context.Country(id: nil, name: "Norway", countryCode: Optional("NO"), countryCodeAlpha3: Optional("NOR"))), region: nil, postcode: Optional(mc_jarvis.SearchViewModel.Context.Postcode(id: Optional("dXJuOm1ieHBsYzpCazZw"), name: "0196")), district: nil, place: Optional(mc_jarvis.SearchViewModel.Context.Place(id: Optional("dXJuOm1ieHBsYzpBU1Nw"), name: "Oslo")), locality: nil, neighborhood: nil, address: Optional(mc_jarvis.SearchViewModel.Context.Address(id: nil, name: Optional("Konows Gate 67B"), addressNumber: Optional("67b"), streetName: Optional("konows gate"))), street: Optional(mc_jarvis.SearchViewModel.Context.Street(id: nil, name: "konows gate"))), language: "en", maki: Optional("car"), poiCategory: Optional(["car dealership", "shopping"]), poiCategoryIDs: Optional(["car_dealership", "shopping"]), brand: Optional(["Jaguar", "Jaguar Dealer"]), brandID: Optional(["jaguar"]), externalIDs: Optional(mc_jarvis.SearchViewModel.ExternalIDs(foursquare: Optional("541b1a7f498e989575479d0b"))), metadata: Optional(mc_jarvis.SearchViewModel.Metadata()), distance: nil, eta: nil, addedDistance: nil, addedTime: nil), mc_jarvis.SearchViewModel.Suggestion(name: "Oslo", namePreferred: nil, mapboxID: "dXJuOm1ieHBvaTowNjQ5MTBkYy01YjNhLTQwOTYtOGZiMi0xOWQ1OTk1NWUyMGI", featureType: "poi", address: Optional("0488 Norway"), fullAddress: Optional("0488 Norway, 0488 Norway"), placeFormatted: "0488 Norway", context: mc_jarvis.SearchViewModel.Context(country: Optional(mc_jarvis.SearchViewModel.Context.Country(id: nil, name: "Norway", countryCode: Optional("NO"), countryCodeAlpha3: Optional("NOR"))), region: nil, postcode: Optional(mc_jarvis.SearchViewModel.Context.Postcode(id: Optional("dXJuOm1ieHBsYzpFKzZw"), name: "0488")), district: nil, place: Optional(mc_jarvis.SearchViewModel.Context.Place(id: Optional("dXJuOm1ieHBsYzpBU1Nw"), name: "Oslo")), locality: nil, neighborhood: nil, address: nil, street: nil), language: "en", maki: Optional("monument"), poiCategory: Optional(["historic site", "monument", "tourist attraction"]), poiCategoryIDs: Optional(["historic_site", "monument", "tourist_attraction"]), brand: nil, brandID: nil, externalIDs: Optional(mc_jarvis.SearchViewModel.ExternalIDs(foursquare: Optional("55621c08498e157f8977c9fc"))), metadata: Optional(mc_jarvis.SearchViewModel.Metadata()), distance: nil, eta: nil, addedDistance: nil, addedTime: nil), mc_jarvis.SearchViewModel.Suggestion(name: "Oslo", namePreferred: nil, mapboxID: "dXJuOm1ieHBvaTpmOTA2OGE0YS1lNjJjLTQ4NTYtYTlhYy0zMDMzMGQ0YWZiZTU", featureType: "poi", address: Optional("0556 Norway"), fullAddress: Optional("0556 Norway, 0556 Norway"), placeFormatted: "0556 Norway", context: mc_jarvis.SearchViewModel.Context(country: Optional(mc_jarvis.SearchViewModel.Context.Country(id: nil, name: "Norway", countryCode: Optional("NO"), countryCodeAlpha3: Optional("NOR"))), region: nil, postcode: Optional(mc_jarvis.SearchViewModel.Context.Postcode(id: Optional("dXJuOm1ieHBsYzpGYzZw"), name: "0556")), district: nil, place: Optional(mc_jarvis.SearchViewModel.Context.Place(id: Optional("dXJuOm1ieHBsYzpBU1Nw"), name: "Oslo")), locality: nil, neighborhood: nil, address: nil, street: nil), language: "en", maki: Optional("home"), poiCategory: Optional(["home"]), poiCategoryIDs: Optional(["home"]), brand: nil, brandID: nil, externalIDs: Optional(mc_jarvis.SearchViewModel.ExternalIDs(foursquare: Optional("55ed5250498e45100b86be48"))), metadata: Optional(mc_jarvis.SearchViewModel.Metadata()), distance: nil, eta: nil, addedDistance: nil, addedTime: nil), mc_jarvis.SearchViewModel.Suggestion(name: "Oslo", namePreferred: nil, mapboxID: "dXJuOm1ieHBvaTo2MWQ0MmY3My0xMTMzLTQwYWEtODRlMy05MGZiYmI0M2JkMzI", featureType: "poi", address: Optional("0150 Norway"), fullAddress: Optional("0150 Norway, 0150 Norway"), placeFormatted: "0150 Norway", context: mc_jarvis.SearchViewModel.Context(country: Optional(mc_jarvis.SearchViewModel.Context.Country(id: nil, name: "Norway", countryCode: Optional("NO"), countryCodeAlpha3: Optional("NOR"))), region: nil, postcode: Optional(mc_jarvis.SearchViewModel.Context.Postcode(id: Optional("dXJuOm1ieHBsYzo3cWs"), name: "0150")), district: nil, place: Optional(mc_jarvis.SearchViewModel.Context.Place(id: Optional("dXJuOm1ieHBsYzpBU1Nw"), name: "Oslo")), locality: nil, neighborhood: nil, address: nil, street: nil), language: "en", maki: Optional("racetrack"), poiCategory: Optional(["go kart racing", "sports"]), poiCategoryIDs: Optional(["go_kart_racing", "sports"]), brand: nil, brandID: nil, externalIDs: Optional(mc_jarvis.SearchViewModel.ExternalIDs(foursquare: Optional("55e06c6b498e164ef32b3a6f"))), metadata: Optional(mc_jarvis.SearchViewModel.Metadata()), distance: nil, eta: nil, addedDistance: nil, addedTime: nil), mc_jarvis.SearchViewModel.Suggestion(name: "Oslo", namePreferred: nil, mapboxID: "dXJuOm1ieHBsYzpBU1Nw", featureType: "region", address: nil, fullAddress: nil, placeFormatted: "Norway", context: mc_jarvis.SearchViewModel.Context(country: Optional(mc_jarvis.SearchViewModel.Context.Country(id: Optional("dXJuOm1ieHBsYzpJcWs"), name: "Norway", countryCode: Optional("NO"), countryCodeAlpha3: Optional("NOR"))), region: nil, postcode: nil, district: nil, place: nil, locality: nil, neighborhood: nil, address: nil, street: nil), language: "en", maki: Optional("marker"), poiCategory: nil, poiCategoryIDs: nil, brand: nil, brandID: nil, externalIDs: nil, metadata: Optional(mc_jarvis.SearchViewModel.Metadata()), distance: nil, eta: nil, addedDistance: nil, addedTime: nil)]
    @Published var suggestionRetrievedFeatures: [Feature] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let debounceInterval: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(500)
    
    private let accessToken = "pk.eyJ1Ijoicm9uaW5qYyIsImEiOiJjbHpqbm80NGwwc3NsMmpyMW9wZW40NG4yIn0.ilqiKyHTVVau1ZadjGtAEA"
    private var sessionToken = UUID().uuidString
    
    init() {
        $searchText
            .debounce(for: debounceInterval, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        guard !query.isEmpty else {
            self.searchResults = []
            return
        }
        
        Task {
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
            let urlString = "https://api.mapbox.com/search/searchbox/v1/suggest?q=\(encodedQuery)&access_token=\(accessToken)&session_token=\(sessionToken)"
            
            if let searchData: SearchSuggestions = await WebService().downloadData(fromURL: urlString) {
                DispatchQueue.main.async {
                    self.searchResults = searchData.suggestions.reversed()
                    print(self.searchResults)
                }
            } else {
                DispatchQueue.main.async {
                    self.searchResults = []
                }
            }
        }
    }
    
    func selectSuggestion(locationId: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        guard !locationId.isEmpty else {
            completion(nil)
            return
        }
        
        Task {
            let urlString = "https://api.mapbox.com/search/searchbox/v1/retrieve/\(locationId)?access_token=\(accessToken)&session_token=\(sessionToken)"
            
            if let retrievedSuggestionData: RetrievedSuggestion = await WebService().downloadData(fromURL: urlString) {
                DispatchQueue.main.async {
                    self.suggestionRetrievedFeatures = retrievedSuggestionData.features
                    
                    if let firstFeature = self.suggestionRetrievedFeatures.first {
                        let coordinate = CLLocationCoordinate2D(
                            latitude: Double(firstFeature.properties.coordinates.latitude),
                            longitude: Double(firstFeature.properties.coordinates.longitude)
                        )
                        completion(coordinate)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.suggestionRetrievedFeatures = []
                }
            }
        }
        
        print("click: \(locationId)")
    }
    
    // In case we want to regenerate the session token.
    func regenerateSessionToken() {
        sessionToken = UUID().uuidString
    }
    
    enum NetworkError: Error {
        case badUrl
        case invalidRequest
        case badResponse
        case badStatus
        case failedToDecodeResponse
    }
    
    class WebService: Codable {
        func downloadData<T: Codable>(fromURL: String) async -> T? {
            do {
                guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
                guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    print("data: \(T.self), \(String(describing: String(data: data, encoding: .utf8)))")
                    throw NetworkError.failedToDecodeResponse
                }
                
                return decodedResponse
            } catch NetworkError.badUrl {
                print("There was an error creating the URL")
            } catch NetworkError.badResponse {
                print("Did not get a valid response")
            } catch NetworkError.badStatus {
                print("Did not get a 2xx status code from the response")
            } catch NetworkError.failedToDecodeResponse {
                print("Failed to decode response into the given type")
            } catch {
                print("An error occured downloading the data")
            }
            
            return nil
        }
    }
    
    struct SearchSuggestions: Codable {
        let suggestions: [Suggestion]
        let attribution: String
        let responseID: String

        enum CodingKeys: String, CodingKey {
            case suggestions
            case attribution
            case responseID = "response_id"
        }
    }
    
    struct Suggestion: Codable {
        let name: String
        let namePreferred: String?
        let mapboxID: String
        let featureType: String
        let address: String?
        let fullAddress: String?
        let placeFormatted: String
        var context: Context
        let language: String
        let maki: String?
        let poiCategory: [String]?
        let poiCategoryIDs: [String]?
        let brand: [String]?
        let brandID: [String]?
        let externalIDs: ExternalIDs?
        let metadata: Metadata?
        let distance: Int?
        let eta: Int?
        let addedDistance: Int?
        let addedTime: Int?
        
        enum CodingKeys: String, CodingKey {
            case name
            case namePreferred = "name_preferred"
            case mapboxID = "mapbox_id"
            case featureType = "feature_type"
            case address
            case fullAddress = "full_address"
            case placeFormatted = "place_formatted"
            case context
            case language
            case maki
            case poiCategory = "poi_category"
            case poiCategoryIDs = "poi_category_ids"
            case brand
            case brandID = "brand_id"
            case externalIDs = "external_ids"
            case metadata
            case distance
            case eta
            case addedDistance = "added_distance"
            case addedTime = "added_time"
        }
    }
    
    struct RetrievedSuggestion: Codable {
        let type: String
        let features: [Feature]
        let attribution: String
    }
    
    struct Feature: Codable {
        let type: String
        let geometry: Geometry
        let properties: Properties
    }

    struct Geometry: Codable {
        let type: String
        let coordinates: [Double]
    }

    struct Properties: Codable {
        let name: String
        let namePreferred: String?
        let mapboxID: String
        let featureType: String
        let address: String?
        let fullAddress: String?
        let placeFormatted: String?
        let context: Context
        let coordinates: Coordinates
        let bbox: [Double]?
        let language: String?
        let maki: String?
        let poiCategory: [String]?
        let poiCategoryIDs: [String]?
        let brand: [String]?
        let brandID: [String]?
        let externalIDs: ExternalIDs?
        let metadata: Metadata?
        let distance: Int?
        let eta: Int?
        let addedDistance: Int?
        let addedTime: Int?
        let operationalStatus: String?

        enum CodingKeys: String, CodingKey {
            case name
            case namePreferred = "name_preferred"
            case mapboxID = "mapbox_id"
            case featureType = "feature_type"
            case address
            case fullAddress = "full_address"
            case placeFormatted = "place_formatted"
            case context
            case coordinates
            case bbox
            case language
            case maki
            case poiCategory = "poi_category"
            case poiCategoryIDs = "poi_category_ids"
            case brand
            case brandID = "brand_id"
            case externalIDs = "external_ids"
            case metadata
            case distance
            case eta
            case addedDistance = "added_distance"
            case addedTime = "added_time"
            case operationalStatus = "operational_status"
        }
    }

    struct Context: Codable {
        let country: Country?
        let region: Region?
        let postcode: Postcode?
        let district: District?
        let place: Place?
        let locality: Locality?
        let neighborhood: Neighborhood?
        let address: Address?
        let street: Street?
        
        struct Country: Codable {
            let id: String?
            let name: String
            let countryCode: String?
            let countryCodeAlpha3: String?

            enum CodingKeys: String, CodingKey {
                case id
                case name
                case countryCode = "country_code"
                case countryCodeAlpha3 = "country_code_alpha_3"
            }
        }

        struct Region: Codable {
            let id: String?
            let name: String
            let regionCode: String?
            let regionCodeFull: String?

            enum CodingKeys: String, CodingKey {
                case id
                case name
                case regionCode = "region_code"
                case regionCodeFull = "region_code_full"
            }
        }
        
        struct Postcode: Codable {
            let id: String?
            let name: String
        }
        
        struct District: Codable {
            let id: String?
            let name: String
        }
        
        struct Place: Codable {
            let id: String?
            let name: String
        }
        
        struct Locality: Codable {
            let id: String?
            let name: String
        }
        
        struct Neighborhood: Codable {
            let id: String?
            let name: String
        }
        
        struct Address: Codable {
            let id: String?
            let name: String?
            let addressNumber: String?
            let streetName: String?

            enum CodingKeys: String, CodingKey {
                case id
                case name
                case addressNumber = "address_number"
                case streetName = "street_name"
            }
        }
        
        struct Street: Codable {
            let id: String?
            let name: String
        }
    }
    
    struct Coordinates: Codable {
        let latitude: Double
        let longitude: Double
        let accuracy: String?
        let routablePoints: [routablePoint]?
        
        enum CodingKeys: String, CodingKey {
            case latitude
            case longitude
            case accuracy
            case routablePoints = "routable_points"
        }
        
        struct routablePoint: Codable {
            let name: String
            let latitude: Double
            let longitude: Double
            let note: String?
        }
    }
    
    struct ExternalIDs: Codable {
        let foursquare: String?
    }
    
    struct Metadata: Codable {}
}
