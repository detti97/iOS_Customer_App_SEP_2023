//
//  IntroView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 11.07.23.
//

import SwiftUI

import SwiftUI

/// A SwiftUI view for guiding the user through an introductory setup process.
struct IntroView: View {

	/// A binding to control the introductory state.
	@Binding var introState: Bool

	/// The address book to manage user addresses.
	@ObservedObject var addressBook: AddressBook

	/// Flag to track the activation of the first step.
	@State private var isActiveFirstStep = true

	/// Flag to track the activation of the second step.
	@State private var isActiveSecondStep = false

	/// Flag to track the activation of the third step.
	@State private var isActiveThirdStep = false

	/// Flag to track the activation of the address addition step.
	@State private var isActiveAddAddress = false

	/// Flag to track the success state of the address form.
	@State private var success = false

	var body: some View {

		VStack {

			if isActiveFirstStep {

				IntroFirstStepView(isActiveFirstStep: $isActiveFirstStep, isActiveSecondStep: $isActiveSecondStep)
			}

			if isActiveSecondStep {

				IntroSecondStepView(isActiveSecondStep: $isActiveSecondStep, isActiveAddAddress: $isActiveAddAddress)
			}

			if isActiveAddAddress {

				VStack {

					Image("delivery_green")
						.resizable()
						.frame(width: 220, height: 200)

					Text("Geben Sie hier\nIhre Adresse ein")
						.font(.title)
						.fontWeight(.heavy)
						.multilineTextAlignment(.center)

					Spacer()
						.frame(height: 10)

					VStack {
						AddressFormView(addressBook: addressBook, success: $success)
					}
					.onChange(of: success) { newValue in
						isActiveThirdStep = true
						isActiveAddAddress = false
					}
				}
				.padding(20)
			}

			if isActiveThirdStep {

				IntroThirdStepView(introState: $introState)
			}
		}
		.onAppear {
			if getIntroState() != nil {
				introState = getIntroState()!
			}
		}
	}

	/// Get the introductory state from user defaults.
	/// - Returns: The introductory state.
	func getIntroState() -> Bool? {
		return UserDefaults.standard.bool(forKey: "IntroState")
	}

	struct IntroView_Previews: PreviewProvider {
		static var previews: some View {
			IntroView(introState: .constant(false), addressBook: AddressBook())
		}
	}
}


