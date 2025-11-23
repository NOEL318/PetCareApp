//
//  WelcomeView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                
                // CONTENIDO
                VStack {
                    Spacer()
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(colorScheme == .dark ? themeManager.colors.accent : themeManager.colors.secondary)
                        .rotationEffect(.degrees(20))
                    
                    Text("Bienvenido")
                        .font(.system(size: 40, weight: .heavy))
                        .padding(.top, 20)
                        .foregroundColor(colorScheme == .dark ? .white : themeManager.colors.secondary)
                    
                    Spacer()
                    
                    // NAVEGACIÓN
                    NavigationLink(destination: LoginView()) {
                        Text("Iniciar Sesión")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeManager.colors.primary)
                            .cornerRadius(15)
                    }
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Crear Cuenta")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeManager.colors.primary)
                            .cornerRadius(15)
                    }
                }
                .padding(30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // BOTÓN DE ACCESIBILIDAD
                AccessibilityMenu()
                    .padding(.top, 10)
                    .padding(.trailing, 20)
            }
        }
    }
}
