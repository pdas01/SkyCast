import SwiftUI

struct ForecastData: Codable {
    let city: String
    let tempInCelsius: Double
    let humidity: Int
    let uv: Double
    let feelsLikeInCelsius: Double
    let weatherIcon: String
    
    init(city: String, tempInCelsius: Double, humidity: Int, uv: Double, feelsLikeInCelsius: Double, weatherIcon: String) {
        self.city = city
        self.tempInCelsius = tempInCelsius
        self.humidity = humidity
        self.uv = uv
        self.feelsLikeInCelsius = feelsLikeInCelsius
        self.weatherIcon = weatherIcon
    }
    
    init(weatherDataResponse: WeatherDataResponse) {
        self.city = weatherDataResponse.location.name
        self.tempInCelsius = weatherDataResponse.current.tempC
        self.humidity = weatherDataResponse.current.humidity
        self.uv = weatherDataResponse.current.uv
        self.feelsLikeInCelsius = weatherDataResponse.current.feelslikeC
        self.weatherIcon = "https:" + weatherDataResponse.current.condition.icon
    }
}

struct CityData: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}
