import SwiftUI

/**
 NetworkManager deals with fetching network calls and decoding to desired format
 */
final class NetworkManager {
    let forecastURL = "https://api.weatherapi.com/v1/current.json"
    
    func searchCity(city: String) async throws -> WeatherDataResponse? {
        var urlComponents = URLComponents(string: forecastURL)
        let queryItem = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "key", value: Secrets.APIKey)
        ]
        urlComponents?.queryItems = queryItem
        
        guard let url = urlComponents?.url else { return nil }
        do {
            let (data, response)  = try await URLSession.shared.data(from: url)
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Error here", response.statusCode)
                throw NetworkError.serverError(response.statusCode)
            }
            return try data.decode()
        } catch DecodingError.keyNotFound(_, let context),
                DecodingError.valueNotFound(_, let context),
                DecodingError.typeMismatch(_, let context),
                DecodingError.dataCorrupted(let context) {
            throw NetworkError.decodingError(context.debugDescription)
        } catch {
            print("Error here blah actual", error.localizedDescription)
            throw NetworkError.error(error.localizedDescription)
        }
    }
}
