//
//  HomeView.swift
//  Trashify
//
//  Created by Marek Gerszendorf on 09/09/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = true
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            HomeContent()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(AppColors.darkerGreen)
    }

    func HomeContent() -> some View {
        ZStack(alignment: .top) {
            MapViewRepresentable(locationManager: locationManager)
                .ignoresSafeArea()
                .onAppear {
                    locationManager.startLocationUpdates()
                }
            
            VStack(alignment: .leading) {
                if !showLocationSearchView {
                    LocationSearchView(showLocationSearchView: $showLocationSearchView)
                } else {
                    LocationSearchActivationView().padding(.vertical, 50).onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
