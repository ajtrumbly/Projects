//
//  GenerateBarcodeView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/4/24.
//

import SwiftUI
import CoreImage

struct GenerateBarcodeView: View {
    let giftCard: GiftCard
    
    var body: some View {
        if let barcodeImage = generateBarcode(from: giftCard.barcodeValue, type: giftCard.barcodeType) {
            Image(uiImage: barcodeImage)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
        } else {
            Text("Gift card data is not present")
        }
    }
    
    func generateBarcode(from string: String, type: String) -> UIImage? {
        let data = string.data(using: .ascii)
        var filterName: String
        
        switch type {
        case "EAN8":
            filterName = "CICode128BarcodeGenerator"
        case "EAN13", "UPC-A":
            filterName = "CIEAN13BarcodeGenerator"
        case "QR":
            filterName = "CIQRCodeGenerator"
        default:
            filterName = "CICode128BarcodeGenerator"
        }
        
        guard let filter = CIFilter(name: filterName) else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        
        if filterName == "CIQRCodeGenerator" {
            filter.setValue("H", forKey: "inputCorrectionLevel")
        }
        
        guard let ciImage = filter.outputImage else { return nil }
        
        let transform = CGAffineTransform(scaleX: 30, y: 60)
        let scaledCIImage = ciImage.transformed(by: transform)
        
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledCIImage, from: scaledCIImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    GenerateBarcodeView(giftCard: .example)
}
