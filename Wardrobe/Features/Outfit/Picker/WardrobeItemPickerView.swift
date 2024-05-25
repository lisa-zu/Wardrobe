//
//  WardrobeItemPickerView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 18.05.24.
//

import SwiftUI
import PhotosUI
import Vision
import CoreImage.CIFilterBuiltins
import SwiftData

struct WardrobeItemPickerView: View {
    @Environment (\.dismiss) var dismiss
    @State private var wardrobeItemTitle: String = ""
    @State private var wardrobeItemCategory: WardrobeItemCategory = .top
    @State private var wardrobeItemSeason: WardrobeItemSeason = .spring
    @State private var wardrobeItemImage: PhotosPickerItem?
    @State private var wardrobeImage: Image?
    @State private var isFavorite: Bool = false
    @State private var imageToEncode: UIImage?
    @State private var isLoading: Bool = false
    private var processingQueue = DispatchQueue(label: "ProcessingQueue")
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Group {
                if wardrobeItemImage == nil {
                    PhotosPicker("PICK_ITEM", selection: $wardrobeItemImage, matching: .images)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .foregroundStyle(.primary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
                } else {
                    GeometryReader { proxy in
                        if isLoading {
                            HStack {
                                Spacer()
                                ProgressView().progressViewStyle(.circular)
                                Spacer()
                            }
                            .padding(.top, 120)
                        } else {
                            VStack {
                                wardrobeImage?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: proxy.size.width - 32)
                                Form {
                                    TextField("PICK_TITLE", text: $wardrobeItemTitle)
                                    Picker("PICK_CATEGORY", selection: $wardrobeItemCategory) {
                                        ForEach(WardrobeItemCategory.allCases) { category in
                                            Text(LocalizedStringKey(stringLiteral: category.rawValue))
                                        }
                                    }
                                    .pickerStyle(.navigationLink)
                                    Picker("PICK_SEASON", selection: $wardrobeItemSeason) {
                                        ForEach(WardrobeItemSeason.allCases) { season in
                                            Text(LocalizedStringKey(stringLiteral: season.rawValue))
                                        }
                                    }
                                    .pickerStyle(.navigationLink)
                                    Toggle("IS_FAVORITE", isOn: $isFavorite)
                                }
                                .scrollContentBackground(.hidden)
                                Button {
                                    self.saveNewItem { error in
                                        if let error = error {
                                            debugPrint(error.localizedDescription)
                                        }
                                        dismiss()
                                    }
                                } label: {
                                    Text("CREATE")
                                }
                                .buttonStyle(.primaryConfirmFullWidth)
                                .disabled(wardrobeItemTitle == "")
                            }
                        }
                    }
                }
            }
            .navigationTitle("NEW_ITEM")
            .onChange(of: wardrobeItemImage) { oldValue, newValue in
                Task {
                    isLoading = true
                    if let loaded = try? await wardrobeItemImage?.loadTransferable(type: Data.self) {
                        processingQueue.async {
                            guard let decodedImage = UIImage(data: loaded) else { return }
                            guard let inputImage = CIImage(data: loaded) else { return }
                            if let maskedImage = subjectMaskImage(from: inputImage) {
                                let outputImage = apply(mask: maskedImage, to: inputImage)
                                let renderedImage = render(ciImage: outputImage)
                                DispatchQueue.main.async {
                                    isLoading = false
                                    self.imageToEncode = renderedImage
                                    wardrobeImage = Image(uiImage: renderedImage)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    isLoading = false
                                    self.imageToEncode = decodedImage
                                    wardrobeImage = Image(uiImage: decodedImage)
                                }
                            }
                        }
                    } else {
                        print("Failed")
                    }
                }
            }
        }
    }
    
    private func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler: VNImageRequestHandler = VNImageRequestHandler(ciImage: inputImage)
        let request: VNGenerateForegroundInstanceMaskRequest = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
        guard let result = request.results?.first else {
            debugPrint("No observations found.")
            return nil
        }
        do {
            let maskPixelBuffer: CVPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: maskPixelBuffer)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    private func apply(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }
    
    private func render(ciImage: CIImage) -> UIImage {
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        return UIImage(cgImage: cgImage)
    }
    
    private func saveNewItem(handler: @escaping((WardrobeError?) -> Void)) {
        if let image = imageToEncode, let imageData = image.pngData() {
            let newItem: WardrobeItem = WardrobeItem(
                name: self.wardrobeItemTitle,
                category: self.wardrobeItemCategory,
                season: self.wardrobeItemSeason,
                image: imageData,
                isFavorite: isFavorite
            )
            modelContext.insert(newItem)
            handler(nil)
        } else {
            handler(.storage)
        }
    }
    
}

#Preview {
    WardrobeItemPickerView()
        .modelContainer(for: WardrobeItem.self)
}
