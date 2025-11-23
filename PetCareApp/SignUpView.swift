//
//  SignUpView.swift
//  PetCareApp
//
//  Created by Noel Rincón Anaya on 23/11/25.
//


import SwiftUI

struct SignUpView: View {
    @State private var nombre = ""
    @State private var apellidos = ""
    @State private var telefono = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ScrollView {
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
                    print("Registro completado para: \(nombre)")
                }
            }
            .padding(30)
        }
    }
}
