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
            VStack {
                Image(uiImage: barcodeImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: .infinity)
                    .padding()
                
                Text("Gift card code: \(giftCard.barcodeValue)")
            }
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
        
        // Trim white space
        let extent = ciImage.extent.insetBy(dx: 10, dy: 10)
        let format = CIFormat.RGBA8
        guard let cgImage = CIContext().createCGImage(ciImage, from: extent, format: format, colorSpace: CGColorSpaceCreateDeviceRGB()) else { return nil }
        
        // Scale the image
        let scale: CGFloat = 10.0
        let size = CGSize(width: extent.width * scale, height: extent.height * scale)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.draw(cgImage, in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

#Preview {
    GenerateBarcodeView(giftCard: .example)
}
