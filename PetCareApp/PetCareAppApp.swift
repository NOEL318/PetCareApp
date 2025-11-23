//
//  PetCareAppApp.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

import SwiftUI

@main
struct PetCareApp: App {

    @StateObject var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            WelcomeView().withAccessibility().environmentObject(themeManager)
        }
    }
}
