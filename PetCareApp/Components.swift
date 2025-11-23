//
//  Components.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

// MARK: - 1. Extensiones de Color (Ingeniería)

extension Color {
    // Inicializador Hexadecimal
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // Colores estáticos por defecto (Fallback)
    static let brandRed = Color(hex: "C33C54")
    static let brandBlue = Color(hex: "254E70")
    static let brandCyan = Color(hex: "8EE3EF")
}


// MARK: - 2. Componentes UI

// A. Campo de Texto (Compatible con Dark Mode)
struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary) // Se adapta a blanco/negro automáticamente
            
            if isSecure {
                SecureField("", text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .foregroundColor(.primary)
            } else {
                TextField("", text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .foregroundColor(.primary)
            }
        }
        .padding(.bottom, 10)
    }
}

// B. Botón Principal (Adaptable al Tema)
struct PrimaryButton: View {
    let title: String
    // Añadimos esto para que pueda recibir el color del ThemeManager
    var backgroundColor: Color = .brandRed
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor) // Usa el color dinámico
                .cornerRadius(15)
        }
        .padding(.vertical, 10)
    }
}

// C. Menú Flotante de Accesibilidad

struct AccessibilitySettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss // Para cerrar el panel
    
    var body: some View {
        NavigationView {
            Form {
                // Sección 1: Daltonismo
                Section(header: Text("Percepción de Color")) {
                    Picker("Modo", selection: $themeManager.currentType) {
                        ForEach(AccessibilityType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                // Sección 2: Texto y Lectura
                Section(header: Text("Lectura y Texto")) {
                    // Toggle para Fuente Legible
                    Toggle(isOn: $themeManager.isReadableFont) {
                        Label("Fuente de Lectura Fácil", systemImage: "textformat")
                    }
                    
                    // Slider Tamaño
                    VStack(alignment: .leading) {
                        Text("Tamaño del Texto: \(String(format: "%.1f", themeManager.fontScale))x")
                            .font(.caption)
                        Slider(value: $themeManager.fontScale, in: 0.8...1.5, step: 0.1) {
                            Text("Tamaño")
                        } minimumValueLabel: {
                            Image(systemName: "textformat.size.smaller")
                        } maximumValueLabel: {
                            Image(systemName: "textformat.size.larger")
                        }
                    }
                    
                    // Slider Espaciado
                    VStack(alignment: .leading) {
                        Text("Espaciado entre líneas")
                            .font(.caption)
                        Slider(value: $themeManager.lineSpacing, in: 0...15, step: 1)
                    }
                }
            }
            .navigationTitle("Accesibilidad")
            .toolbar {
                Button("Listo") {
                    dismiss()
                }
            }
        }
    }
}

// MARK: - ACTUALIZADO: Botón del Menú
struct AccessibilityMenu: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme
    
    // Estado para saber si mostramos el panel
    @State private var showSettings = false
    
    var body: some View {
        Button(action: {
            showSettings.toggle()
        }) {
            Image(systemName: "accessibility")
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? .white : themeManager.colors.secondary)
                .padding(10)
                .background(
                    Circle()
                        .fill(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                )
        }
        // Esto abre el panel como una hoja modal
        .sheet(isPresented: $showSettings) {
            AccessibilitySettingsView()
                .presentationDetents([.medium]) // Ocupa solo media pantalla
        }
    }
}

// MARK: - NUEVO: Modificador Global de Accesibilidad
// Este es el truco de ingeniería para aplicar todo junto.
struct AccessibilityModifier: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        content
            // 1. Cambia la fuente si el toggle está activo (Usamos .rounded como proxy de "lectura fácil")
            .fontDesign(themeManager.isReadableFont ? .serif : .default)
            // 2. Aplica el espaciado de línea extra
            .lineSpacing(themeManager.lineSpacing)
            // 3. Escala todo el contenido (Zoom)
            .scaleEffect(themeManager.fontScale)
            // Opcional: animar los cambios suavemente
            .animation(.easeInOut, value: themeManager.fontScale)
            .animation(.easeInOut, value: themeManager.isReadableFont)
    }
}

// Extensión para usarlo fácil: .withAccessibility()
extension View {
    func withAccessibility() -> some View {
        self.modifier(AccessibilityModifier())
    }
}
