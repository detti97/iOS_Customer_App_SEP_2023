//
//  SplashScreenView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 13.07.23.
//

import SwiftUI

struct SplashScreenView: View {

	@State private var isActive = false
	@State private var size = 0.8
	@State private var opacity = 0.5

	var body: some View {

		if isActive{
			ContentView()
				.environmentObject(DataManager())
				.environmentObject(AppState())
		}else{

			ZStack{

				VStack{
					VStack{
						Image("LOGO_LINGENLIEFERT")
							.resizable()
							.frame(width: 245, height: 200)

						Text("LingenLiefert 2.0")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.foregroundColor(.purple.opacity(0.80))


					}
					.scaleEffect(size)
					.opacity(opacity)
					.onAppear{
						withAnimation(.easeIn(duration: 1.2)){
							self.size = 0.9
							self.opacity = 1.0
						}
					}
				}
				.onAppear{
					DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
						withAnimation{

							self.isActive = true
						}

					}
				}

			}



		}

    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
