//
//  qrCodeView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage

struct qrCodeView: View {
    
    var addressString: String
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        
        
        VStack{

            Image("Logo_klein")
                .resizable()
                .frame(width: 210, height: 120)
                .position(x: 142, y: 110)
                .zIndex(5)
                .colorInvert()
            
            Image("background")
                .resizable()
                .frame(width: 500, height: 500)
                .ignoresSafeArea()
            
            if addressString != "" {
                
                Image(uiImage: generateQRCode(from: addressString))
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 350, height: 350 )
                    .border(Color.white, width: 5)
                    .cornerRadius(10)
                    .shadow(radius: 50)
                    .background(.ultraThinMaterial)
                    .offset(y: -260)
            }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

struct qrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        qrCodeView(addressString: "jan")
    }
}
