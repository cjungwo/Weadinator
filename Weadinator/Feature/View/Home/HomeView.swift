//
//  HomeView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @ObservedObject private var weatherManager = WeatherManager()
    @State private var weather: Weather?
    @Query var clothingList: [Clothing]
    
    
    var body: some View {
        VStack{
            WeatherShowingView()
            Spacer()
//            if clothingList.isEmpty {
//                EmptyClothingView()
//            } else {
            RecommendationClothingView()
//            }
            Spacer()
        }
    }
}


//MARK: WeatherShowingView
private struct WeatherShowingView: View {
    fileprivate var body: some View {
        HStack{
            Image(systemName: "cloud")
                .font(.system(size: 80))
                .foregroundColor(.white)
                .padding(.horizontal)
            VStack{
                Text("Location")
                    .font(.headline)
                    .foregroundColor(.white)
                HStack {
                    Text("20°")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    VStack{
                        Text("Condition")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        HStack{
                            Text("L: 10°C")
                                .font(.caption)
                                .foregroundColor(.white)
                            Text("H: 23°C")
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

#Preview {
    HomeView()
}

