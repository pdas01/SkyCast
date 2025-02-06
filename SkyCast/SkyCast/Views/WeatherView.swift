import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: .zero) {
                    SearchBar(
                        searchText: $viewModel.currentSearchedCity,
                        errorMessage: $viewModel.errorMessage,
                        onSubmit: {
                            // Search
                            viewModel.searchTapped()
                        }
                    )
                    switch viewModel.viewState {
                    case .savedCity:
                        Spacer()
                            .frame(height: DesignConstants.spacing32)
                        CityWeatherView(forecastData: viewModel.savedForecastData)
                    case .empty:
                        EmptyStateView(
                            title: viewModel.noCitySelectedText,
                            subtitle: viewModel.searchCityText
                        )
                        .padding(.top, proxy.size.height * 0.3) // To almost center to screen
                    case .someContent:
                        Spacer()
                            .frame(height: DesignConstants.spacing48)
                            .frame(maxWidth: .infinity)
                        if let forecastData = viewModel.forecastData, !viewModel.currentSearchedCity.isEmpty {
                            WeatherCard(forecastData: forecastData)
                                .onTapGesture {
                                    viewModel.onWeatherCardTapped()
                                }
                        }
                    case .unknown:
                        EmptyView()
                    }
                    Spacer()
                }
                .frame(minHeight: proxy.size.height)
                .onAppear {
                    viewModel.viewOnAppear()
                }
                .padding(.horizontal, DesignConstants.padding16)
            }
            .scrollDismissesKeyboard(.immediately) // Dismiss keyboard on scroll
        }
    }
}

extension WeatherView {
    struct CityWeatherView: View {
        let forecastData: ForecastData?
        var body: some View {
            VStack(alignment: .center) {
                if let forecastData = forecastData {
                    if let url = URL(string: forecastData.weatherIcon) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: DesignConstants.WeatherIcon.width, height: DesignConstants.WeatherIcon.height)
                            }
                        }
                    }
                    HStack(alignment: .center) {
                        Text(forecastData.city)
                            .font(.skycast.title)
                            .foregroundColor(Color.skycast.black1)
                        Image(.vector)
                            .resizable()
                            .frame(width: DesignConstants.NavigationIcon.width, height: DesignConstants.NavigationIcon.height)
                    }
                    HStack(alignment: .top, spacing: .zero) {
                        Text(String(Int(forecastData.tempInCelsius)))
                            .font(.skycast.title)
                            .foregroundColor(Color.skycast.black1)
                        Image(.degree)
                            .resizable()
                            .frame(width: DesignConstants.DegreeIcon.mediumWidth, height: DesignConstants.DegreeIcon.mediumHeight)
                            .foregroundColor(Color.skycast.black1)
                    }
                    MetadataCard(
                        humidityPercent: forecastData.humidity,
                        uvIndex: forecastData.uv,
                        feelsLikeInCelsius: forecastData.feelsLikeInCelsius
                    ).padding(.horizontal, DesignConstants.padding32)
                }
            }
        }
    }
}

extension WeatherView {
    struct MetadataCard: View {
        let humidityPercent: Int
        let uvIndex: Double
        let feelsLikeInCelsius: Double
        var body: some View {
            Grid {
                GridRow {
                    Text(AppStrings.Common.humidity.value)
                        .frame(maxWidth: .infinity)
                        .font(.skycast.caption2)
                        .foregroundColor(Color.skycast.gray)
                    Text(AppStrings.Common.uv.value)
                        .frame(maxWidth: .infinity)
                        .font(.skycast.caption2)
                        .foregroundColor(Color.skycast.gray)
                    Text(AppStrings.Common.feelsLike.value)
                        .frame(maxWidth: .infinity)
                        .font(.skycast.footnote)
                        .foregroundColor(Color.skycast.gray)
                }
                GridRow {
                    Text(String(humidityPercent) + "%")
                        .multilineTextAlignment(.center)
                        .font(.skycast.caption3)
                        .foregroundColor(Color.skycast.darkgray)
                    Text(String(uvIndex))
                        .font(.skycast.caption3)
                        .foregroundColor(Color.skycast.darkgray)
                    HStack(alignment: .top, spacing: .zero) {
                        Text(String(Int(feelsLikeInCelsius)))
                            .font(.skycast.caption3)
                            .foregroundColor(Color.skycast.darkgray)
                        Image(.degree)
                            .resizable()
                            .offset(y: DesignConstants.DegreeIcon.yOffset)
                            .frame(width:DesignConstants.DegreeIcon.smallWidth , height: DesignConstants.DegreeIcon.smallHeight)
                            .foregroundColor(Color.skycast.darkgray)
                    }
                }
            }
            .padding(.all, DesignConstants.padding16)
            .background(
                RoundedRectangle(cornerRadius: DesignConstants.cornerRadius)
                    .fill(Color.skycast.background)
            )
        }
    }
}

extension WeatherView {
    struct EmptyStateView: View {
        let title: String
        let subtitle: String
        var body: some View {
            VStack(alignment: .center) {
                Text(title)
                    .font(.skycast.title)
                    .foregroundColor(Color.skycast.black1)
                Text(subtitle)
                    .font(.skycast.caption3)
                    .foregroundColor(Color.skycast.black1)
                Spacer()
            }
            .padding(.bottom, DesignConstants.padding32)
        }
    }
}

#Preview("Empty State") {
    WeatherView.EmptyStateView(title: AppStrings.Common.noCitySelected.value, subtitle: AppStrings.Common.searchCity.value)
        .border(.red)
}

#Preview("Weather View") {
    WeatherView()
}

#Preview("MetaData") {
    WeatherView.MetadataCard(humidityPercent: 60, uvIndex: 3.2, feelsLikeInCelsius: 12)
        .padding(.horizontal, 32)
}


fileprivate struct DesignConstants {
    static let spacing32: CGFloat = 32.0
    static let spacing48: CGFloat = 48.0
    static let padding16: CGFloat = 16.0
    static let padding32: CGFloat = 32.0
    static let cornerRadius: CGFloat = 16.0

    enum SearchIcon {
        static let width: CGFloat = 18.0
        static let height: CGFloat = 18.0
    }

    enum SearchBar {
        static let height: CGFloat = 46.0
    }

    enum WeatherIcon {
        static let width: CGFloat = 83.0
        static let height: CGFloat = 67.0
    }

    enum DegreeIcon {
        static let smallWidth: CGFloat = 5.0
        static let smallHeight: CGFloat = 5.0
        static let mediumWidth: CGFloat = 8.0
        static let mediumHeight: CGFloat = 8.0
        static let yOffset: CGFloat = 4.0
    }

    enum NavigationIcon {
        static let width: CGFloat = 21.0
        static let height: CGFloat = 21.0
        static let yOffset: CGFloat = 20.0
    }
}
