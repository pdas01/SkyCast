import SwiftUI

struct WeatherDataResponse: Codable {
    let location: LocationData
    let current: CurrentData

    struct LocationData: Codable {
        let name: String
    }

    struct CurrentData: Codable {
        let tempC: Double
        let condition: WeatherCondition
        let humidity: Int
        let feelslikeC: Double
        let uv: Double

        struct WeatherCondition: Codable {
            let text: String
            let icon: String
        }
    }
}
