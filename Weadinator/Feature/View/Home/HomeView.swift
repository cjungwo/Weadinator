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
    @State private var coordinator : Coordinator?
    @State private var styleList: [[Clothing?]] = []
    
    @Query var clothingList: [Clothing]
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    WeatherIconView(iconUrl: "https://openweathermap.org/img/wn/\(weatherManager.weather?.iconCode ?? "01d")@2x.png", size: 100)
                    Text("\(Int(weatherManager.weather?.currentTemp ?? 0))°")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading){
                        Text(locationManager.locationName)
                            .font(.headline)
                            .foregroundColor(.white)
                        HStack {
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
                if clothingList.isEmpty {
                    NavigationLink {
                        AddClothingView()
                    } label: {
                        EmptyClothingListView()
                    }
                } else {
                    RecommendationStyleListView(styleList: styleList)
                }
                Spacer()
            }
            .onAppear {
                Task {
                    let location = locationManager.location ?? CLLocation(latitude: -33.876295, longitude: 151.1985883)
                    await weatherManager.fetchWeather(for: location)
                    
                    let tempHigh = weatherManager.weather?.temperatureHigh ?? 25
                    let tempLow = weatherManager.weather?.temperatureLow ?? 15
                    
                    let newCoordinator = Coordinator(tempHigh: tempHigh, tempLow: tempLow, clothingList: clothingList)
                    coordinator = newCoordinator
                    styleList = newCoordinator.generateStyleList()
                }
            }
        }
    }
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

struct RecommendationStyleListView: View {
    let styleList: [[Clothing?]]
    
    var body: some View {
        TabView {
            ForEach(0..<styleList.count, id: \.self) { index in
                RecommendationStyleView(style: styleList[index])
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


struct RecommendationStyleView: View {
    let style: [Clothing?]  // One Style from clothing type
    
    var body: some View {
        HStack {
            // Left: jacket
            VStack {
                recommandClothingView(width: 100, height: 160, index: 0, alter: "jacket")
            }
            // Middle: shirts, trousers, shoes
            VStack {
                recommandClothingView(width: 100, height: 160, index: 1, alter: "tshirt")
                recommandClothingView(width: 100, height: 160, index: 2, alter: "hanger")
                recommandClothingView(width: 100, height: 70, index: 3, alter: "shoe")
            }
            // Right: bag
            VStack {
                recommandClothingView(width: 100, height: 160, index: 4, alter: "bag")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(CustomColor.color3)
        .cornerRadius(10)
        .padding()
    }
    
    // MARK: - RecommandClothingView
      @ViewBuilder
      private func recommandClothingView(width: Double, height: Double, index: Int, alter: String?) -> some View {
        let clothing = clothingByIndex(index)

          if clothing != nil {
            NavigationLink {
                ClothingDetailView(clothing: clothing!)
            } label: {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: width, height: height)
                .background(
                  Group {
                      clothingImage(for: clothing, alter: alter ?? "photo")
                  }
                )
            }
          } else {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: width, height: height)
                .background(
                  Group {
                      clothingImage(for: clothing, alter: alter ?? "photo")
                  }
                )
          }
      }

      private func clothingByIndex(_ index: Int) -> Clothing? {
        guard let clothing = style[safe: index] else { return nil }

        return clothing
      }

    
    
    // MARK: - Helper Method
    @ViewBuilder
    private func clothingImage(for clothing: Clothing?, alter: String = "photo") -> some View {
        if let clothing = clothing, let imageData = clothing.clothingImage, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        } else {
            Image(systemName: alter)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
        }
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

