import SwiftUI

extension WeatherView {
    class ViewModel: ObservableObject {
        @Published var currentSearchedCity: String = ""
        @Published var savedForecastData: ForecastData? = nil
        @Published var forecastData: ForecastData? = nil
        @Published var errorMessage: String? = nil

        private let forecastService = ForecastService()

        var noCitySelectedText: String {
            AppStrings.Common.noCitySelected.value
//            currentSearchedCity.isEmpty ? AppStrings.Common.noCitySelected.value : ""
        }
        var searchCityText: String {
            AppStrings.Common.searchCity.value
//            currentSearchedCity.isEmpty ? AppStrings.Common.searchCity.value : ""
        }
        
        var viewState: ViewState {
            if savedForecastData != nil && currentSearchedCity.isEmpty {
                return .savedCity
            } else if currentSearchedCity.isEmpty {
                return .empty
            } else if forecastData != nil && errorMessage == nil {
                return .someContent
            } else {
                return .unknown
            }
        }
        
        enum ViewState {
            case savedCity
            case empty
            case someContent
            case unknown
        }
        
        func viewOnAppear() {
            // Fetch saved city if persists in UserDefaults 
            guard let city = UserSettings.selectedCity,
            let temp = UserSettings.selectedCityTemp,
                    let weatherIcon = UserSettings.selectedCityWeatherIcon,
                  let uv = UserSettings.selectedCityUV,
                  let humidity = UserSettings.selectedCityHumidity,
                  let feelsLike = UserSettings.selectedCityFeelsLike
            else {
                return
            }
            
            self.savedForecastData = ForecastData(
                city: city,
                tempInCelsius: temp,
                humidity: humidity,
                uv: uv,
                feelsLikeInCelsius: feelsLike,
                weatherIcon: weatherIcon
            )
        }
        
        func onWeatherCardTapped()  {
            // Save the selection
            savedForecastData = forecastData
            saveInUserDefaults()
            reset()
        }
        
        func reset() {
            currentSearchedCity = ""
            forecastData = nil
        }
        
        func searchTapped() {
            guard !currentSearchedCity.isEmpty else { return }
            Task {
                await onSearch()
            }
        }
        
        @MainActor
        func onSearch() async {
            self.errorMessage = nil
            do {
                let response = try await forecastService.searchCity(city: currentSearchedCity)
                await MainActor.run {
                    self.forecastData = response
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        func saveInUserDefaults() {
            guard let savedForecastData = savedForecastData else { return }
            UserDefaults.standard.set(savedForecastData.city, forKey: "selected_city")
            UserDefaults.standard.set(savedForecastData.tempInCelsius, forKey: "selected_city_temp")
            UserDefaults.standard.set(savedForecastData.weatherIcon, forKey: "selected_city_weather_icon")
            UserDefaults.standard.set(savedForecastData.humidity, forKey: "selected_city_humidity")
            UserDefaults.standard.set(savedForecastData.feelsLikeInCelsius, forKey: "selected_city_feels_like")
            UserDefaults.standard.set(savedForecastData.uv, forKey: "selected_city_uv")
        }
    }
}
