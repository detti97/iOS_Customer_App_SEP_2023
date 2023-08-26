//
//  qrCodeSwiftUIApp.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 02.04.23.
//

import SwiftUI

@main
struct qrCodeSwiftUIApp: App {

	//@StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            //ContentView()
			//	.environmentObject(DataManager())
			//	.environmentObject(AppState())

			SplashScreenView()
        }
    }
}

