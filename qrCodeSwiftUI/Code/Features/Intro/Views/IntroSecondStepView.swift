//
//  IntroSecondStepView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 10.09.23.
//

import SwiftUI

struct IntroSecondStepView: View {

	@Binding var isActiveSecondStep: Bool
	@Binding var isActiveAddAddress: Bool

	var body: some View {

		VStack{

			Spacer()
				.frame(height: 40)

			Image("undraw_confirmed_re_sef7")
				.resizable()
				.scaledToFit()

			Spacer()
				.frame(height: 60)

			Text("Hinterlegen Sie Ihre Adresse")
				.font(.largeTitle)
				.fontWeight(.heavy)
				.padding()
				.multilineTextAlignment(.center)
				.foregroundColor(.accentColor)

			Spacer()
				.frame(height: 20)

			Text("Der erstellte Code wird nach Ihrem Einkauf gescannt und die Lieferung beauftragt ")
				.font(.body)
				.fontWeight(.heavy)
				.padding()
				.multilineTextAlignment(.center)

			Spacer()
				.frame(height: 100)

			Button(action: {

				isActiveSecondStep = false
				isActiveAddAddress = true

			}) {
				Text("Adresse hinzufügen")
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

struct IntroSceccondStepView_Previews: PreviewProvider {
    static var previews: some View {
		IntroSecondStepView(isActiveSecondStep: Binding.constant(false), isActiveAddAddress: Binding.constant(false))
    }
}
