//
//  IntroView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 11.07.23.
//

import SwiftUI

struct IntroView: View {

	@Binding var introState: Bool
	@ObservedObject var addressBook: AddressBook

	@State private var isActiveFirstStep = true
	@State private var isActiveSeccondStep = false
	@State private var isActiveThirdStep = false
	@State private var isActiveAddAddress = false
	@State private var success = false

	var body: some View {

			VStack{
				
				if isActiveFirstStep{
					
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
							isActiveSeccondStep = true

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

				if isActiveSeccondStep{

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

							isActiveSeccondStep = false
							isActiveAddAddress = true

						}) {
							Text("Adresse hinzufügen")
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
				if isActiveAddAddress{

					VStack {

						Image("delivery_green")
							.resizable()
							.frame(width: 220, height: 200)



						Text("Geben Sie hier\nIhre Adresse ein")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.padding()
							.multilineTextAlignment(.center)

						Spacer()
							.frame(height: 10)

						VStack{

							addressFormView(addressBook: addressBook, success: $success)
						}
						.onChange(of: success) { newValue in
							isActiveThirdStep = true
							isActiveAddAddress = false
						}

					}
					.padding(20)

				}

				if isActiveThirdStep {

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
		}

	func saveIntroState(_ introState: Bool) {
		UserDefaults.standard.set(introState, forKey: "IntroState")
		
	}

		struct IntroView_Previews: PreviewProvider {



			static var previews: some View {
				IntroView(introState: .constant(false), addressBook: AddressBook())
			}
		}
	}

