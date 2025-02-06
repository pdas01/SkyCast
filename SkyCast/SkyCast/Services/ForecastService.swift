import Foundation

/**
 Forecast is a service that calls networkmanager
 */
final class ForecastService {
    private let networkManager = NetworkManager()

    func searchCity(city: String) async throws -> ForecastData? {
        do {
            let responseData = try await networkManager.searchCity(city: city)
            guard let responseData = responseData else { return nil }
            return ForecastData(weatherDataResponse: responseData)
        } catch {
            throw error
        }
    }
}
