//
//  ImpressumView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 16.08.23.
//

import SwiftUI

struct ImpressumView: View {
    var body: some View {

		VStack{

			Image("lieferlogo")


			VStack(alignment: .center, spacing: 20) {

				HStack{
					Image(systemName: "shippingbox")
					Text("Impressum")
				}
				.foregroundColor(.teal)
				.font(.largeTitle)
				.fontWeight(.heavy)

				VStack (alignment: .center, spacing: 5){

					Text("Diese App wurde von Studierenden")
					Text("der Hochschule Osnabrück, im Rahmen des Sofwareentwicklungsprojekts, entwickelt.")

					Text("Alaa Chraih\nSadik Bajrami\nJan Dettler\nAmirali Haghighatkhah\nRania Mohammad\nChristian Minich ")

				}
				.fontWeight(.heavy)
				.multilineTextAlignment(.center)
				.background(
					RoundedRectangle(cornerRadius: 10) // Radius für die abgerundeten Ecken
						.fill(Color.white) // Hintergrundfarbe des Rechtecks
						.shadow(radius: 5) // Schatten für das Rechteck
				)

			}

			VStack{

				Image("hs")
					.resizable()
					.scaledToFit()
					.frame(width: 300)

			}


		}

    }
}

struct ImpressumView_Previews: PreviewProvider {
    static var previews: some View {
        ImpressumView()
    }
}
