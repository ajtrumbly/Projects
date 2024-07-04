//
//  BarcodeScanningView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI
import AVFoundation
import Vision

struct BarcodeScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var barcodeType: String
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: BarcodeScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, BarcodeScannerViewControllerDelegate {
        var parent: BarcodeScannerView

        init(_ parent: BarcodeScannerView) {
            self.parent = parent
        }

        func didFindCode(_ code: String, type: String) {
            var adjustedType = type
            var adjustedCode = code
            
            // Remove the "org.gs1." prefix if present
            if adjustedType.hasPrefix("org.gs1.") {
                adjustedType = String(adjustedType.dropFirst(8))
            }
            
            // Check for UPC-A
            if adjustedType == "EAN13" && code.count == 12 {
                adjustedType = "UPC-A"
                adjustedCode = String(adjustedCode.dropFirst(1))
                print("Scanned UPCA")
            }
            
            DispatchQueue.main.async {
                self.parent.scannedCode = code
                self.parent.barcodeType = adjustedType
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    BarcodeScannerView(scannedCode: .constant(""), barcodeType: .constant(""))
}
