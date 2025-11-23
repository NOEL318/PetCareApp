//
//  LoginView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    // 1. Recibimos el gestor de temas
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        // ERROR ANTERIOR: Quitamos el 'NavigationStack' de aquí.
        // Ya estamos dentro de uno que viene del WelcomeView.
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Iniciar Sesión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 40)
            
            CustomTextField(title: "Email", placeholder: "", text: $email)
            CustomTextField(title: "Contraseña", placeholder: "", text: $password, isSecure: true)
            
            NavigationLink(destination: HomeView()) {
                Text("Continuar")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    // CORRECCIÓN CLAVE: Usamos el color del themeManager
                    .background(themeManager.colors.primary)
                    .cornerRadius(15)
            }
            .padding(.vertical, 10)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

#Preview {
    // Para que el preview funcione, necesitamos inyectar el themeManager dummy
    LoginView()
        .environmentObject(ThemeManager())
}
