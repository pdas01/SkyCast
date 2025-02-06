import Foundation

enum AppStrings {
    enum Error {
        case genericError
        var value: String {
            switch self {
            case .genericError:
                LocalizedString.Error.generic_error
            }
        }
    }

    enum Common {
        case searchLocation
        case noCitySelected
        case searchCity
        case humidity
        case uv
        case feelsLike
        var value: String {
            switch self {
            case .searchLocation:
                LocalizedString.Common.search_location
            case .noCitySelected:
                LocalizedString.Common.no_city_selected
            case .searchCity:
                LocalizedString.Common.search_city
            case .humidity:
                LocalizedString.Common.humidity
            case .uv:
                LocalizedString.Common.uv
            case .feelsLike:
                LocalizedString.Common.feels_like
            }
        }
    }
}

enum LocalizedString {
    enum Error {
        static let generic_error = NSLocalizedString("generic_error", value: "Something went wrong. Please try again later.", comment: "Generic decoding/server error")
    }
    enum Common {
        static let search_location = NSLocalizedString("search_location", value: "Search Location", comment: "Search location")
        static let no_city_selected = NSLocalizedString("no_city_selected", value: "No City Selected", comment: "No city selected")
        static let search_city = NSLocalizedString("search_city", value: "Please Search For a City", comment: "Search for a city")
        static let humidity = NSLocalizedString("humidity", value: "Humidity", comment: "Humidity")
        static let uv = NSLocalizedString("uv", value: "UV", comment: "UV")
        static let feels_like = NSLocalizedString("feels_like", value: "Feels Like", comment: "Feels Like")
    }
    
}
