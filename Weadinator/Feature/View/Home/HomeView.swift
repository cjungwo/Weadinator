//
//  HomeView.swift
//  Weadinator
//
//  Created by JungWoo Choi on 18/10/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
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
            Spacer()
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
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
