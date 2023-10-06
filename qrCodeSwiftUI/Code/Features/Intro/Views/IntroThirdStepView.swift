//
//  IntroThirdStepView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 10.09.23.
//

import SwiftUI

struct IntroThirdStepView: View {

	@Binding var introState: Bool

	var body: some View {

		VStack{

			Spacer()
				.frame(height: 40)

			Image("undraw_completed_03xt")
				.resizable()
				.scaledToFit()

			Spacer()
				.frame(height: 60)

			Text("App ist bereit")
				.font(.largeTitle)
				.fontWeight(.heavy)
				.padding()
				.multilineTextAlignment(.center)
				.foregroundColor(.accentColor)

			Spacer()
				.frame(height: 20)

			Text("Die Einrichtung ist fertig und Sie können nun die App benutzen")
				.font(.body)
				.fontWeight(.heavy)
				.padding()
				.multilineTextAlignment(.center)

			Spacer()
				.frame(height: 100)

			Button(action: {

				saveIntroState(true)
				introState = true


			}) {
				Text("Weiter")
					.font(.headline)
					.padding()
					.frame(maxWidth: .infinity)
					.background(Color.accentColor)
					.foregroundColor(.white)
					.cornerRadius(18)
					.padding()

			}
		}
	}
}

func saveIntroState(_ introState: Bool) {
	UserDefaults.standard.set(introState, forKey: "IntroState")

}

struct IntroThirdStepView_Previews: PreviewProvider {
	static var previews: some View {
		IntroThirdStepView(introState: Binding.constant(false))
	}
}

