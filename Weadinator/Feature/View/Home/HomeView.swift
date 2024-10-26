//
//  HomeView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import SwiftData
import CoreLocation

struct HomeView: View {
    @StateObject private var weatherManager = WeatherManager()
    @StateObject private var locationManager = LocationManager()
    @Query var clothingList: [Clothing]
    
    
    var body: some View {
        VStack{
            // WeatherShowingView()
            HStack{
                WeatherIconView(iconUrl: "https://openweathermap.org/img/wn/\(weatherManager.weather?.iconCode ?? "01d")@2x.png", size: 100)
                VStack{
                    Text("Location")
                        .font(.headline)
                        .foregroundColor(.white)
                    HStack {
                        Text("\(Int(weatherManager.weather?.currentTemp ?? 0))°")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        VStack{
                            Text(weatherManager.weather?.description ?? "Unknown")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            HStack{
                                Text("L: \(Int(weatherManager.weather?.temperatureLow ?? 0))°C")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                Text("H: \(Int(weatherManager.weather?.temperatureHigh ?? 0))°C")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(width: 403, height: (160))
            .background(Color(UIColor.lightGray))
            .padding(.vertical)
            Spacer()
            //            if clothingList.isEmpty {
            //                EmptyClothingView()
            //            } else {
            RecommendationClothingView()
            //            }
            Spacer()
        }
        .onAppear {
            Task {
                let location = locationManager.location ?? CLLocation(latitude: -33.876295, longitude: 151.1985883)
                await weatherManager.fetchWeather(for: location)
            }
        }
    }
    
//    private func fetchWeather() async {
//        let location = locationManager.location ?? CLLocation(latitude: -33.876295, longitude: 151.1985883)
//        do {
//            let fetchedWeather = try await weatherManager.fetchWeather(for: location)
//            weather = fetchedWeather
//        } catch {
//            print("Failed to fetch weather: \(error)")
//        }
//    }
}


//MARK: WeatherShowingView
private struct WeatherShowingView: View {
    var weather: Weather?
    
    fileprivate var body: some View {
        HStack{
            Image(systemName: weather?.condition.iconName ?? "cloud")
                .font(.system(size: 80))
                .foregroundColor(.white)
                .padding(.horizontal)
            VStack{
                Text("Location")
                    .font(.headline)
                    .foregroundColor(.white)
                HStack {
                    Text("\(Int(weather?.currentTemp ?? 0))°")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    VStack{
                        Text(weather?.condition.description ?? "Unknown")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        HStack{
                            Text("L: \(Int(weather?.temperatureLow ?? 0))°C")
                                .font(.caption)
                                .foregroundColor(.white)
                            Text("H: \(Int(weather?.temperatureHigh ?? 0))°C")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 403, height: (160))
        .background(Color(UIColor.lightGray))
        .padding(.vertical)
    }
}

//MARK: EmptyClothingView
private struct EmptyClothingView: View {
    fileprivate var body: some View {
        VStack {
            Image(systemName: "plus.app")
                .font(.system(size: 100))
                .foregroundColor(.gray)
            VStack{
                Text("Add your clothes")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}

//MARK: RecommendationClothingView
private struct RecommendationClothingView: View {
    fileprivate var body: some View {
        TabView {
            RecommedationClothingListView()
            Text("Recommendation Clothing View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(CustomColor.color3)
                .cornerRadius(10)
                .padding()
            Text("Recommendation Clothing View2")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(CustomColor.color3)
                .cornerRadius(10)
                .padding()
            Text("Recommendation Clothing View3")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(CustomColor.color3)
                .cornerRadius(10)
                .padding()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

//MARK: RecommedationClothingListView
private struct RecommedationClothingListView: View {
    fileprivate var body: some View {
        HStack {
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Image(systemName:"jacket")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    )
            }
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Image(systemName:"tshirt")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    )
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Image(systemName:"hanger")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    )
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 70)
                    .background(
                        Image(systemName:"shoe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    )
            }
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Image(systemName:"bag")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(CustomColor.color3)
        .cornerRadius(10)
        .padding()
    }
}

//MARK: WeatherIconView
private struct WeatherIconView: View {
    var iconUrl: String
    var size: CGFloat
    
    fileprivate var body: some View {
        AsyncImage(url: URL(string: iconUrl)) { phase in
            switch phase {
            case .empty:
                // Placeholder while loading
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                // Display the fetched image
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            case .failure:
                // Display an error image or icon
                ProgressView()
                    .frame(width: size, height: size)
                //                Image(systemName: "exclamationmark.triangle")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: size, height: size)
                //                    .foregroundColor(.red)
            @unknown default:
                // Fallback case
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundColor(.gray)
            }
        }
    }
}



#Preview {
    HomeView()
}

