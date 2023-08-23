//
//  testView.swift
//  qrCodeSwiftUI
//
//  Created by Jan Dettler on 21.08.23.
//

import SwiftUI

struct testView: View {
    var body: some View {

		VStack{

			ZStack {
				Image("test2")
					.resizable()
					.ignoresSafeArea()

				Rectangle()
					.fill(.ultraThinMaterial)
					.ignoresSafeArea()

			}

		}
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
