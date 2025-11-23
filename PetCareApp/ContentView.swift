//
//  ContentView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//

import SwiftUI

// 1. Definición de Colores (Aproximados a tu imagen)
extension Color {
    static let brandBlue = Color(red: 0.13, green: 0.25, blue: 0.42) // El azul oscuro de la huella
    static let brandRed = Color(red: 0.76, green: 0.24, blue: 0.33)  // El rojo/rosa de los botones
}

// 2. Componente Reutilizable: Campo de Texto Personalizado
// Esto hace que crear formularios sea rápido y el código quede limpio.
struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
            if isSecure {
                SecureField("", text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            } else {
                TextField("", text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
        }
        .padding(.bottom, 10)
    }
}

// 3. Componente Reutilizable: Botón Principal
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.brandRed)
                .cornerRadius(15)
        }
        .padding(.vertical, 10)
    }
}

// --- PANTALLA 1: BIENVENIDA ---
struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Icono de la huella
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.brandBlue)
                    .rotationEffect(.degrees(20)) // Pequeña rotación como en la imagen
                
                Text("Bienvenido")
                    .font(.system(size: 40, weight: .heavy))
                    .padding(.top, 20)
                
                Spacer()
                
                // Navegación a Iniciar Sesión
                NavigationLink(destination: LoginView()) {
                    Text("Iniciar Sesión")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brandRed)
                        .cornerRadius(15)
                }
                
                // Navegación a Crear Cuenta
                NavigationLink(destination: SignUpView()) {
                    Text("Crear Cuenta")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brandRed)
                        .cornerRadius(15)
                }
            }
            .padding(30)
        }
    }
}

// --- PANTALLA 2: INICIAR SESIÓN ---
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Iniciar Sesión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 40)
            
            CustomTextField(title: "Email", placeholder: "", text: $email)
            CustomTextField(title: "Contraseña", placeholder: "", text: $password, isSecure: true)
            
            PrimaryButton(title: "Continuar") {
                print("Login presionado")
            }
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

// --- PANTALLA 3: CREAR CUENTA ---
struct SignUpView: View {
    @State private var nombre = ""
    @State private var apellidos = ""
    @State private var telefono = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ScrollView { // Usamos ScrollView porque son muchos campos
            VStack(alignment: .leading) {
                
                Text("Crear Cuenta")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 30)
                
                CustomTextField(title: "Nombre", placeholder: "", text: $nombre)
                CustomTextField(title: "Apellidos", placeholder: "", text: $apellidos)
                CustomTextField(title: "Teléfono", placeholder: "", text: $telefono)
                CustomTextField(title: "Email", placeholder: "", text: $email)
                CustomTextField(title: "Contraseña", placeholder: "", text: $password, isSecure: true)
                
                PrimaryButton(title: "Continuar") {
                    print("Crear cuenta presionado")
                }
            }
            .padding(30)
        }
    }
}

// Punto de entrada para la Previsualización
struct ContentView: View {
    var body: some View {
        WelcomeView()
    }
}

#Preview {
    ContentView()
}
