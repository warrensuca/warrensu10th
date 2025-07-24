//
//  ContentView.swift
//  InstaFilter
//
//  Created by warren su on 7/23/25.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import PhotosUI


struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @Binding var document: InstaFilterDocument
    
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    var body: some View {
        VStack {
            Spacer()
            PhotosPicker(selection: $selectedItem){
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus")
                }
            }
            .buttonStyle(.plain)
            .onChange(of: selectedItem) {
                loadImage()
            }
            Spacer()
            
            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity, applyProcessing)
            }
            
            HStack {
                Button("Change Filter") {
                    
                }
                
                Spacer()
            }
        }.padding([.horizontal, .bottom])
            .navigationTitle("InstaLink")
    }
    
    func changeFilter() {}
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                return
            }
            
            guard let inputImage = UIImage(data: imageData) else {return}
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
                
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
}

#Preview {
    ContentView(document: .constant(InstaFilterDocument()))
}

//
//  ContentView.swift
//  InstaFilter
//
//  Created by warren su on 7/23/25.
//



