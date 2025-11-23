//
//  AccessibilityType.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI
import Combine

// 1. Tipos de Accesibilidad Visual
enum AccessibilityType: String, CaseIterable, Identifiable {
    case normal = "Normal"
    case protanopia = "Protanopia"
    case deuteranopia = "Deuteranopia"
    case tritanopia = "Tritanopia"
    case achromatopsia = "Achromatopsia"
    
    var id: String { self.rawValue }
}

// 2. Estructura de la Paleta
struct ColorPalette {
    let primary: Color
    let secondary: Color
    let accent: Color
}

// 3. El Gestor de Temas
final class ThemeManager: ObservableObject {
    
    @Published var currentType: AccessibilityType = .normal
    
    // CORRECCIÓN AQUÍ: Usamos 'Double' en lugar de 'CGFloat'
    // Los Sliders de SwiftUI requieren Double.
    @Published var fontScale: Double = 1.0
    @Published var lineSpacing: Double = 4.0
    @Published var isReadableFont: Bool = false
    
    var colors: ColorPalette {
        switch currentType {
        case .normal:
            return ColorPalette(primary: Color(hex: "C33C54"), secondary: Color(hex: "254E70"), accent: Color(hex: "8EE3EF"))
        case .protanopia:
            return ColorPalette(primary: Color(hex: "88874E"), secondary: Color(hex: "363767"), accent: Color(hex: "B2B3EC"))
        case .deuteranopia:
            return ColorPalette(primary: Color(hex: "909A4C"), secondary: Color(hex: "343165"), accent: Color(hex: "ADA7EB"))
        case .tritanopia:
            return ColorPalette(primary: Color(hex: "BC4948"), secondary: Color(hex: "27615F"), accent: Color(hex: "92E9E9"))
        case .achromatopsia:
            return ColorPalette(primary: Color(hex: "676767"), secondary: Color(hex: "454545"), accent: Color(hex: "CACACA"))
        }
    }
}
