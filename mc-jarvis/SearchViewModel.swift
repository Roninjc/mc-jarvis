//
//  SearchViewModel.swift
//  mc-jarvis
//
//  Created by Jesus Castano Candela on 24/08/2024.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [Suggestion] = []
    
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
                    self.searchResults = searchData.suggestions
                }
            } else {
                DispatchQueue.main.async {
                    self.searchResults = []
                }
            }
        }
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
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Failed to decode JSON: \(jsonString)")
                    }
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

    struct RetrieveResponse: Codable {
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
    
    struct ExternalIDs: Codable {
        let foursquare: String?
    }
    
    struct Metadata: Codable {}
}
