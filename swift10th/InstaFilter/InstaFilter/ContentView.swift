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
import StoreKit

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    @Binding var document: InstaFilterDocument
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) private var requestReview
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
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
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("InstaFilter image", image: processedImage))
                    }
                }
                
                Spacer()
            }
        }.padding([.horizontal, .bottom])
            .navigationTitle("InstaLink")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
    }
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1

        if filterCount >= 20 {
            requestReview()
        }
    }
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                return
            }
            
            guard let inputImage = UIImage(data: imageData) else {return}
            
            let beginImage = CIImage(image: inputImage)
            let inputKeys = currentFilter.inputKeys

            if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
            if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
            if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
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



