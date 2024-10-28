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
            RecommendationClothingView(styleList: styleList)
            //            }
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

////MARK: RecommendationClothingView
//private struct RecommendationClothingView: View {
//    fileprivate var body: some View {
//        TabView {
//            ForEach(0..<4) { _ in
//                RecommedationClothingListView()
//            }
//        }
//        .tabViewStyle(PageTabViewStyle())
//        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//    }
//}
//
////MARK: RecommedationClothingListView
//private struct RecommedationClothingListView: View {
//    fileprivate var body: some View {
//        HStack {
//            VStack{
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 160)
//                    .background(
//                        Image(systemName:"jacket")
//                        //                        Image(uiImage: UIImage(data: style[0].clothingImage))
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipped()
//                    )
//            }
//            VStack{
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 160)
//                    .background(
//                        Image(systemName:"tshirt")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipped()
//                    )
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 160)
//                    .background(
//                        Image(systemName:"hanger")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipped()
//                    )
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 70)
//                    .background(
//                        Image(systemName:"shoe")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipped()
//                    )
//            }
//            VStack{
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 160)
//                    .background(
//                        Image(systemName:"bag")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .clipped()
//                    )
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(CustomColor.color3)
//        .cornerRadius(10)
//        .padding()
//    }
//}

struct RecommendationClothingView: View {
    let styleList: [[Clothing?]]
    
    var body: some View {
        TabView {
            ForEach(0..<styleList.count, id: \.self) { index in
                RecommendationClothingListView(style: styleList[index])
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


struct RecommendationClothingListView: View {
    let style: [Clothing?]  // One Style from clothing type
    
    var body: some View {
        HStack {
            // Left: jacket
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Group {
                            if let clothing = style[safe: 0] {
                                clothingImage(for: clothing)
                            } else {
                                Image(systemName: "jacket")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
            }
            // Middle: shirts, trousers, shoes
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Group {
                            if let clothing = style[safe: 1] {
                                clothingImage(for: clothing)
                            } else {
                                Image(systemName: "tshirt")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Group {
                            if let clothing = style[safe: 2] {
                                clothingImage(for: clothing)
                            } else {
                                Image(systemName: "hanger")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 70)
                    .background(
                        Group {
                            if let clothing = style[safe: 3] {
                                clothingImage(for: clothing)
                            } else {
                                Image(systemName: "shoe")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
            }
            // Right: bag
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 160)
                    .background(
                        Group {
                            if let clothing = style[safe: 4] {
                                clothingImage(for: clothing)
                            } else {
                                Image(systemName: "bag")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(CustomColor.color3)
        .cornerRadius(10)
        .padding()
    }
    
    // MARK: - Helper Method
    @ViewBuilder
    private func clothingImage(for clothing: Clothing?) -> some View {
        if let clothing = clothing, let imageData = clothing.clothingImage, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
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

