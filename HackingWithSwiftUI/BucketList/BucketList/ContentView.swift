//
//  ContentView.swift
//  BucketList
//
//  Created by Warren Su on 7/25/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    ))
    
    @State private var viewModel = ViewModel()
    @State private var changeMapStyle = false
    @State private var mapType = 0
    var selectedMapStyle: MapStyle {
            switch mapType {
            case 0: .standard
            case 1: .hybrid
            case 2: .imagery
            default: .standard
            }
        }
    var body: some View {
        NavigationStack{
            ZStack{
                if viewModel.isUnlocked {
                    MapReader{ proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 40)
                                        .clipShape(.circle)
                                        .onLongPressGesture {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                            }
                        }
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        .confirmationDialog("Change Map Style", isPresented: $changeMapStyle) {
                            Button("Standard") {
                                mapType = 0
                            }
                            Button("Hybrid") {
                                mapType = 1
                            }
                            Button("Imagery") {
                                mapType = 2
                            }
                        }
                    }
                } else {
                    Button("Unlock Places", action: viewModel.authenticate)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }.toolbar {
                Button("Change Map Style"){
                    changeMapStyle = true
                }
            }
            .alert("Error with authentication", isPresented: $viewModel.errorAuthentication) {
                Button("Ok") {}
            } message: {Text("Try Again")}
        }
    }
}

#Preview {
    ContentView()
}
