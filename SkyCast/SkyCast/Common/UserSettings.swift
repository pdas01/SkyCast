import Foundation

class UserSettings {
    static var selectedCity: String? {
        let selected_city = UserDefaults.standard.string(forKey: "selected_city")
        return selected_city
    }
    
    static var selectedCityTemp: Double? {
        let selected_city_temp = UserDefaults.standard.double(forKey: "selected_city_temp")
        return selected_city_temp
    }
    
    static var selectedCityWeatherIcon: String? {
        let selected_city_weather_icon = UserDefaults.standard.string(forKey: "selected_city_weather_icon")
        return selected_city_weather_icon
    }
    
    static var selectedCityUV: Double? {
        let selected_city_uv = UserDefaults.standard.double(forKey: "selected_city_uv")
        return selected_city_uv
    }
    
    static var selectedCityHumidity: Int? {
        let selected_city_humidity = UserDefaults.standard.integer(forKey: "selected_city_humidity")
        return selected_city_humidity
    }
    
    static var selectedCityFeelsLike: Double? {
        UserDefaults.standard.double(forKey: "selected_city_feels_like")
    }
}
