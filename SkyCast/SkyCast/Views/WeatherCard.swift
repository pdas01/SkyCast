import SwiftUI

struct WeatherCard: View {
    let forecastData: ForecastData
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .zero) {
                Text(forecastData.city)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.skycast.title)
                    .foregroundColor(Color.skycast.black1)
                HStack(alignment: .top) {
                    Text(String(Int(forecastData.tempInCelsius)))
                        .font(.skycast.largeTitle2)
                        .foregroundColor(Color.skycast.black1)
                    Image(.degree)
                        .resizable()
                        .offset(y: DesignConstants.DegreeIcon.yOffset)
                        .frame(width: DesignConstants.DegreeIcon.width, height: DesignConstants.DegreeIcon.height)
                        .foregroundColor(Color.skycast.black1)
                }
            }
            HStack(alignment: .center) {
                if let url = URL(string: forecastData.weatherIcon) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: DesignConstants.WeatherIcon.width, height: DesignConstants.WeatherIcon.height)
                        } else {
                            Image(systemName: SystemImageConstants.placeholderPhotoIcon)
                                .resizable()
                                .frame(width: DesignConstants.WeatherIcon.width, height: DesignConstants.WeatherIcon.height)
                                .foregroundColor(Color.skycast.sunnyYellow)
                        }
                    }
                }
            }
        }
        .padding(.all, DesignConstants.padding16)
        .background(
            RoundedRectangle(cornerRadius: DesignConstants.padding16)
                .fill(Color.skycast.background)
        )
        .frame(height: DesignConstants.height)
    }
}



#Preview("Weather Card") {
    let data = ForecastData(city: "San Fransico", tempInCelsius: 20, humidity: 20, uv: 4, feelsLikeInCelsius: 38, weatherIcon: "//cdn.weatherapi.com/weather/64x64/night/116.png")
    WeatherCard(forecastData: data)
}


fileprivate struct DesignConstants {
    static let padding16: CGFloat = 16.0
    static let cornerRadius: CGFloat = 16.0
    static let height: CGFloat = 117.0

    enum WeatherIcon {
        static let width: CGFloat = 83.0
        static let height: CGFloat = 67.0
    }

    enum DegreeIcon {
        static let width: CGFloat = 5.0
        static let height: CGFloat = 5.0
        static let yOffset: CGFloat = 20.0
    }
}
