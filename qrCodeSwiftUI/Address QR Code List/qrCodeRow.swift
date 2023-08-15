//
//  qrCodeRow.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 06.04.23.
//

import SwiftUI

struct qrCodeRow: View {
    
    var adressString: String
        
        init(adressString: String) { 
            self.adressString = adressString
        }
    
    var body: some View{
        HStack{
            
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            Spacer()
            Text(adressString)
                .font(.headline)
        }
		.contextMenu {
						Button("Option 1") {
							// Perform action for option 1
						}
					}
    }
}
struct qrCodeRow_Previews: PreviewProvider {
    static var previews: some View {
        qrCodeRow(adressString: "hallo")
    }
}
