//
//  IntroFirstStepView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 10.09.23.
//

import SwiftUI

struct IntroFirstStepView: View {

	@Binding var isActiveFirstStep: Bool
	@Binding var isActiveSecondStep: Bool

    var body: some View {

		VStack{

			Spacer()
				.frame(height: 40)

			Image("undraw_shopping_bags_iafb")
				.resizable()
				.scaledToFit()

			Spacer()
				.frame(height: 60)

			Text("Welcome to LingenLiefert 2.0")
				.font(.largeTitle)
				.fontWeight(.heavy)
				.padding()
				.multilineTextAlignment(.center)

			Spacer()
				.frame(height: 20)

			Text("Kaufen Sie in teilnehmenden lokalen Geschäften ein und lassen Sie sich Ihre Einkäufe nach Hause liefern")
				.font(.body)
				.fontWeight(.heavy)
				.padding()
				.multilineTextAlignment(.center)
				.foregroundColor(.purple)

			Spacer()
				.frame(height: 100)

			Button(action: {

				isActiveFirstStep = false
				isActiveSecondStep = true

			}) {
				Text("Next")
					.font(.headline)
					.padding()
					.frame(maxWidth: .infinity)
					.background(Color.purple)
					.foregroundColor(.white)
					.cornerRadius(18)
					.padding()
			}

		}
    }
}

struct IntroFirstStepView_Previews: PreviewProvider {
    static var previews: some View {
		IntroFirstStepView(isActiveFirstStep: Binding.constant(false), isActiveSecondStep: Binding.constant(false))
    }
}
